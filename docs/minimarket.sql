-- =============================================================================
--  MINIMARKET - Base de datos SQLite
--  Generado para: Tienda / minimarket
--  Características: FIFO por lote, múltiples proveedores, stock mínimo,
--                   ajuste de inventario, KPIs de ganancia bruta/neta,
--                   métodos de pago (efectivo / tarjeta / transferencia)
-- =============================================================================

-- NOTA: journal_mode = WAL debe ejecutarse FUERA de cualquier transacción.
-- Si usás DB Browser, DBeaver u otro cliente que auto-inicia transacciones,
-- ejecutá esta línea por separado en una sesión nueva antes de correr el script:
--   PRAGMA journal_mode = WAL;
--
-- Las siguientes líneas sí son seguras dentro de transacciones:
PRAGMA foreign_keys = ON;        -- Integridad referencial activada
PRAGMA encoding = 'UTF-8';

-- =============================================================================
-- 1. CATEGORÍAS DE PRODUCTOS
-- =============================================================================
CREATE TABLE IF NOT EXISTS categorias (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT    NOT NULL UNIQUE,
    descripcion TEXT,
    activa      INTEGER NOT NULL DEFAULT 1,       -- 1 = activa, 0 = inactiva
    creado_en   TEXT    NOT NULL DEFAULT (datetime('now','localtime'))
);

-- =============================================================================
-- 2. PROVEEDORES
-- =============================================================================
CREATE TABLE IF NOT EXISTS proveedores (
    id          INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre      TEXT    NOT NULL UNIQUE,
    contacto    TEXT,                             -- Nombre del contacto
    telefono    TEXT,
    email       TEXT,
    direccion   TEXT,
    activo      INTEGER NOT NULL DEFAULT 1,
    creado_en   TEXT    NOT NULL DEFAULT (datetime('now','localtime'))
);

-- =============================================================================
-- 3. PRODUCTOS
-- =============================================================================
CREATE TABLE IF NOT EXISTS productos (
    id                  INTEGER PRIMARY KEY AUTOINCREMENT,
    nombre              TEXT    NOT NULL UNIQUE,
    descripcion         TEXT,
    categoria_id        INTEGER NOT NULL REFERENCES categorias(id) ON UPDATE CASCADE,
    precio_venta        REAL    NOT NULL DEFAULT 0 CHECK (precio_venta >= 0),
    -- Margen de ganancia deseado para este producto (ej: 30 = 30%)
    margen_ganancia_pct REAL    NOT NULL DEFAULT 0 CHECK (margen_ganancia_pct >= 0),
    -- Stock mínimo para alerta de reorden
    stock_minimo        REAL    NOT NULL DEFAULT 0 CHECK (stock_minimo >= 0),
    -- Stock calculado se consulta via vista; este campo es el acumulado real
    stock_actual        REAL    NOT NULL DEFAULT 0 CHECK (stock_actual >= 0),
    activo              INTEGER NOT NULL DEFAULT 1,
    creado_en           TEXT    NOT NULL DEFAULT (datetime('now','localtime')),
    actualizado_en      TEXT    NOT NULL DEFAULT (datetime('now','localtime'))
);

CREATE INDEX IF NOT EXISTS idx_productos_categoria ON productos(categoria_id);
CREATE INDEX IF NOT EXISTS idx_productos_activo    ON productos(activo);

-- =============================================================================
-- 4. LOTES DE COMPRA  (cabecera de cada orden/factura de compra)
-- =============================================================================
CREATE TABLE IF NOT EXISTS compras (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    proveedor_id    INTEGER NOT NULL REFERENCES proveedores(id) ON UPDATE CASCADE,
    fecha           TEXT    NOT NULL DEFAULT (datetime('now','localtime')),
    nro_factura     TEXT,                          -- Número de factura del proveedor
    observaciones   TEXT,
    total           REAL    NOT NULL DEFAULT 0 CHECK (total >= 0),
    creado_en       TEXT    NOT NULL DEFAULT (datetime('now','localtime'))
);

CREATE INDEX IF NOT EXISTS idx_compras_proveedor ON compras(proveedor_id);
CREATE INDEX IF NOT EXISTS idx_compras_fecha     ON compras(fecha);

-- =============================================================================
-- 5. DETALLE DE COMPRA / LOTES (líneas de cada compra — base del FIFO)
--    Cada fila es un lote independiente de un producto.
--    El campo cantidad_restante se va decrementando al vender.
-- =============================================================================
CREATE TABLE IF NOT EXISTS compra_detalles (
    id                  INTEGER PRIMARY KEY AUTOINCREMENT,
    compra_id           INTEGER NOT NULL REFERENCES compras(id) ON UPDATE CASCADE,
    producto_id         INTEGER NOT NULL REFERENCES productos(id) ON UPDATE CASCADE,
    cantidad            REAL    NOT NULL CHECK (cantidad > 0),
    cantidad_restante   REAL    NOT NULL CHECK (cantidad_restante >= 0),
    precio_costo        REAL    NOT NULL CHECK (precio_costo >= 0),  -- Costo unitario
    -- Calculado automáticamente por trigger: precio_costo * (1 + margen_ganancia_pct/100)
    precio_venta_lote   REAL    NOT NULL DEFAULT 0 CHECK (precio_venta_lote >= 0),
    subtotal            REAL    GENERATED ALWAYS AS (cantidad * precio_costo) STORED,
    creado_en           TEXT    NOT NULL DEFAULT (datetime('now','localtime'))
);

CREATE INDEX IF NOT EXISTS idx_cd_compra   ON compra_detalles(compra_id);
CREATE INDEX IF NOT EXISTS idx_cd_producto ON compra_detalles(producto_id);
-- Índice clave para FIFO: obtener el lote más antiguo con stock disponible
CREATE INDEX IF NOT EXISTS idx_cd_fifo ON compra_detalles(producto_id, compra_id, cantidad_restante);

-- =============================================================================
-- 6. VENTAS  (cabecera)
-- =============================================================================
CREATE TABLE IF NOT EXISTS ventas (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    fecha           TEXT    NOT NULL DEFAULT (datetime('now','localtime')),
    metodo_pago     TEXT    NOT NULL DEFAULT 'efectivo'
                            CHECK (metodo_pago IN ('efectivo','tarjeta','transferencia')),
    total           REAL    NOT NULL DEFAULT 0 CHECK (total >= 0),
    -- Costo total de lo vendido (calculado al registrar, útil para margen)
    costo_total     REAL    NOT NULL DEFAULT 0 CHECK (costo_total >= 0),
    observaciones   TEXT,
    creado_en       TEXT    NOT NULL DEFAULT (datetime('now','localtime'))
);

CREATE INDEX IF NOT EXISTS idx_ventas_fecha ON ventas(fecha);
CREATE INDEX IF NOT EXISTS idx_ventas_pago  ON ventas(metodo_pago);

-- =============================================================================
-- 7. DETALLE DE VENTA
--    Cada línea indica de qué lote (compra_detalle) se tomaron unidades (FIFO).
--    Una misma línea de venta puede repartirse en varios lotes si el primero
--    no tiene suficiente stock; en ese caso hay varias filas con el mismo
--    venta_id y producto_id pero distintos lote_id.
-- =============================================================================
CREATE TABLE IF NOT EXISTS venta_detalles (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    venta_id        INTEGER NOT NULL REFERENCES ventas(id) ON UPDATE CASCADE,
    producto_id     INTEGER NOT NULL REFERENCES productos(id) ON UPDATE CASCADE,
    lote_id         INTEGER NOT NULL REFERENCES compra_detalles(id) ON UPDATE CASCADE,
    cantidad        REAL    NOT NULL CHECK (cantidad > 0),
    precio_venta    REAL    NOT NULL CHECK (precio_venta >= 0),  -- Precio al momento de venta
    precio_costo    REAL    NOT NULL CHECK (precio_costo >= 0),  -- Costo del lote (FIFO)
    subtotal        REAL    GENERATED ALWAYS AS (cantidad * precio_venta) STORED,
    costo_subtotal  REAL    GENERATED ALWAYS AS (cantidad * precio_costo) STORED,
    creado_en       TEXT    NOT NULL DEFAULT (datetime('now','localtime'))
);

CREATE INDEX IF NOT EXISTS idx_vd_venta    ON venta_detalles(venta_id);
CREATE INDEX IF NOT EXISTS idx_vd_producto ON venta_detalles(producto_id);
CREATE INDEX IF NOT EXISTS idx_vd_lote     ON venta_detalles(lote_id);

-- =============================================================================
-- 8. AJUSTES DE INVENTARIO  (conteo físico)
--    tipo: 'entrada' suma stock, 'salida' lo descuenta (merma, robo, etc.)
-- =============================================================================
CREATE TABLE IF NOT EXISTS ajustes_inventario (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    producto_id     INTEGER NOT NULL REFERENCES productos(id) ON UPDATE CASCADE,
    fecha           TEXT    NOT NULL DEFAULT (datetime('now','localtime')),
    tipo            TEXT    NOT NULL CHECK (tipo IN ('entrada','salida')),
    cantidad        REAL    NOT NULL CHECK (cantidad > 0),
    motivo          TEXT    NOT NULL,  -- 'conteo físico', 'merma', 'robo', etc.
    stock_antes     REAL    NOT NULL,
    stock_despues   REAL    NOT NULL,
    creado_en       TEXT    NOT NULL DEFAULT (datetime('now','localtime'))
);

CREATE INDEX IF NOT EXISTS idx_aj_producto ON ajustes_inventario(producto_id);
CREATE INDEX IF NOT EXISTS idx_aj_fecha    ON ajustes_inventario(fecha);

-- =============================================================================
-- 9. HISTORIAL DE CAMBIOS DE MARGEN DE GANANCIA
--    Registra cada vez que se modifica margen_ganancia_pct de un producto.
--    El trigger T5 lo alimenta automáticamente.
-- =============================================================================
CREATE TABLE IF NOT EXISTS historial_margenes (
    id              INTEGER PRIMARY KEY AUTOINCREMENT,
    producto_id     INTEGER NOT NULL REFERENCES productos(id) ON UPDATE CASCADE,
    margen_anterior REAL    NOT NULL,
    margen_nuevo    REAL    NOT NULL,
    precio_venta_anterior REAL NOT NULL,
    precio_venta_nuevo    REAL NOT NULL,
    motivo          TEXT,                    -- Opcional: razón del cambio
    fecha           TEXT NOT NULL DEFAULT (datetime('now','localtime'))
);

CREATE INDEX IF NOT EXISTS idx_hm_producto ON historial_margenes(producto_id);
CREATE INDEX IF NOT EXISTS idx_hm_fecha    ON historial_margenes(fecha);

-- =============================================================================
-- TRIGGERS
-- =============================================================================
-- IMPORTANTE: Las columnas GENERATED ALWAYS (subtotal, costo_subtotal) NO pueden
-- usarse en subqueries dentro de triggers en SQLite. Se recalculan explícitamente.

-- T1: Al insertar un compra_detalle →
--     1) Calcula precio_venta_lote = precio_costo * (1 + margen%)
--     2) Actualiza productos.precio_venta con el precio más alto de todos los lotes activos
--     3) Suma stock y recalcula total de la compra
CREATE TRIGGER IF NOT EXISTS trg_compra_detalle_insert
AFTER INSERT ON compra_detalles
BEGIN
    -- Calcular precio_venta_lote usando el margen del producto
    UPDATE compra_detalles
       SET precio_venta_lote = ROUND(
               NEW.precio_costo * (1.0 + (
                   SELECT margen_ganancia_pct / 100.0
                     FROM productos WHERE id = NEW.producto_id
               )), 2)
     WHERE id = NEW.id;

    -- Actualizar productos.precio_venta con el MAX de todos los lotes activos
    UPDATE productos
       SET precio_venta   = (
               SELECT ROUND(MAX(cd.precio_costo * (1.0 + p2.margen_ganancia_pct / 100.0)), 2)
                 FROM compra_detalles cd
                 JOIN productos p2 ON p2.id = cd.producto_id
                WHERE cd.producto_id = NEW.producto_id
                  AND cd.cantidad_restante > 0
           ),
           stock_actual   = stock_actual + NEW.cantidad,
           actualizado_en = datetime('now','localtime')
     WHERE id = NEW.producto_id;

    -- Recalcular total de la cabecera de compra
    UPDATE compras
       SET total = (
               SELECT COALESCE(SUM(cd.cantidad * cd.precio_costo), 0)
                 FROM compra_detalles cd
                WHERE cd.compra_id = NEW.compra_id
           )
     WHERE id = NEW.compra_id;
END;

-- T2: Al insertar un venta_detalle → decrementa lote FIFO, stock y totales de venta
CREATE TRIGGER IF NOT EXISTS trg_venta_detalle_insert
AFTER INSERT ON venta_detalles
BEGIN
    -- Decrementar cantidad restante del lote (FIFO)
    UPDATE compra_detalles
       SET cantidad_restante = cantidad_restante - NEW.cantidad
     WHERE id = NEW.lote_id;

    -- Decrementar stock del producto
    UPDATE productos
       SET stock_actual   = stock_actual - NEW.cantidad,
           actualizado_en = datetime('now','localtime')
     WHERE id = NEW.producto_id;

    -- Recalcular totales de la venta (sin usar columnas generadas)
    UPDATE ventas
       SET total       = (
               SELECT COALESCE(SUM(vd.cantidad * vd.precio_venta), 0)
                 FROM venta_detalles vd
                WHERE vd.venta_id = NEW.venta_id
           ),
           costo_total = (
               SELECT COALESCE(SUM(vd.cantidad * vd.precio_costo), 0)
                 FROM venta_detalles vd
                WHERE vd.venta_id = NEW.venta_id
           )
     WHERE id = NEW.venta_id;
END;

-- T3: Al insertar un ajuste de inventario → actualiza stock_actual del producto
CREATE TRIGGER IF NOT EXISTS trg_ajuste_inventario_insert
AFTER INSERT ON ajustes_inventario
BEGIN
    UPDATE productos
       SET stock_actual   = CASE NEW.tipo
                                WHEN 'entrada' THEN stock_actual + NEW.cantidad
                                WHEN 'salida'  THEN stock_actual - NEW.cantidad
                                ELSE stock_actual
                            END,
           actualizado_en = datetime('now','localtime')
     WHERE id = NEW.producto_id;
END;

-- T4: Actualizar productos.actualizado_en al modificar precio, margen o stock mínimo
CREATE TRIGGER IF NOT EXISTS trg_producto_update
AFTER UPDATE OF precio_venta, margen_ganancia_pct, stock_minimo ON productos
WHEN NEW.precio_venta        != OLD.precio_venta
  OR NEW.margen_ganancia_pct != OLD.margen_ganancia_pct
  OR NEW.stock_minimo        != OLD.stock_minimo
BEGIN
    UPDATE productos
       SET actualizado_en = datetime('now','localtime')
     WHERE id = NEW.id;
END;

-- T5: Al cambiar margen_ganancia_pct de un producto →
--     1) Registra el cambio en historial_margenes
--     2) Recalcula precio_venta_lote en todos los lotes activos (con stock)
--     3) Actualiza productos.precio_venta con el nuevo MAX
CREATE TRIGGER IF NOT EXISTS trg_margen_update
AFTER UPDATE OF margen_ganancia_pct ON productos
WHEN NEW.margen_ganancia_pct != OLD.margen_ganancia_pct
BEGIN
    -- 1) Registrar en historial antes de recalcular
    INSERT INTO historial_margenes (
        producto_id, margen_anterior, margen_nuevo,
        precio_venta_anterior, precio_venta_nuevo,
        fecha
    )
    VALUES (
        NEW.id,
        OLD.margen_ganancia_pct,
        NEW.margen_ganancia_pct,
        OLD.precio_venta,
        -- precio nuevo = MAX costo activo * (1 + nuevo margen)
        COALESCE((
            SELECT ROUND(MAX(cd.precio_costo * (1.0 + NEW.margen_ganancia_pct / 100.0)), 2)
              FROM compra_detalles cd
             WHERE cd.producto_id = NEW.id
               AND cd.cantidad_restante > 0
        ), 0),
        datetime('now','localtime')
    );

    -- 2) Recalcular precio_venta_lote en lotes activos con el nuevo margen
    UPDATE compra_detalles
       SET precio_venta_lote = ROUND(precio_costo * (1.0 + NEW.margen_ganancia_pct / 100.0), 2)
     WHERE producto_id = NEW.id
       AND cantidad_restante > 0;

    -- 3) Actualizar precio_venta del producto con el nuevo MAX
    UPDATE productos
       SET precio_venta   = COALESCE((
               SELECT ROUND(MAX(cd.precio_costo * (1.0 + NEW.margen_ganancia_pct / 100.0)), 2)
                 FROM compra_detalles cd
                WHERE cd.producto_id = NEW.id
                  AND cd.cantidad_restante > 0
           ), 0),
           actualizado_en = datetime('now','localtime')
     WHERE id = NEW.id;
END;

-- =============================================================================
-- VISTAS
-- =============================================================================

-- V_PRECIO: Alerta de productos cuyo precio de venta no coincide con el máximo de sus lotes activos
CREATE VIEW IF NOT EXISTS v_alertas_precio AS
SELECT
    p.id,
    p.nombre                                                    AS producto,
    cat.nombre                                                  AS categoria,
    p.margen_ganancia_pct                                       AS margen_pct,
    p.precio_venta                                              AS precio_venta_actual,
    ROUND(MAX(cd.precio_costo * (1 + p.margen_ganancia_pct / 100.0)), 2) AS precio_venta_correcto,
    ROUND(MAX(cd.precio_costo * (1 + p.margen_ganancia_pct / 100.0))
          - p.precio_venta, 2)                                  AS diferencia,
    CASE
        WHEN ABS(ROUND(MAX(cd.precio_costo * (1 + p.margen_ganancia_pct / 100.0)), 2)
             - p.precio_venta) > 0.001
        THEN 'ACTUALIZAR PRECIO'
        ELSE 'OK'
    END                                                         AS estado
FROM productos p
JOIN categorias cat ON cat.id = p.categoria_id
JOIN compra_detalles cd ON cd.producto_id = p.id AND cd.cantidad_restante > 0
WHERE p.activo = 1
GROUP BY p.id
ORDER BY estado DESC, diferencia DESC;

-- V1: Stock actual con alerta de reorden
CREATE VIEW IF NOT EXISTS v_stock_alertas AS
SELECT
    p.id,
    p.nombre                                    AS producto,
    c.nombre                                    AS categoria,
    p.stock_actual,
    p.stock_minimo,
    p.precio_venta,
    CASE WHEN p.stock_actual <= p.stock_minimo
         THEN 'REPONER'
         ELSE 'OK'
    END                                         AS estado_stock
FROM productos p
JOIN categorias c ON c.id = p.categoria_id
WHERE p.activo = 1
ORDER BY estado_stock DESC, p.nombre;

-- V2: Lotes disponibles (FIFO) — para saber de qué lote sacar primero
CREATE VIEW IF NOT EXISTS v_lotes_disponibles AS
SELECT
    cd.id                                       AS lote_id,
    p.nombre                                    AS producto,
    p.id                                        AS producto_id,
    co.fecha                                    AS fecha_compra,
    co.id                                       AS compra_id,
    pr.nombre                                   AS proveedor,
    cd.cantidad                                 AS cantidad_original,
    cd.cantidad_restante,
    cd.precio_costo,
    cd.precio_venta_lote
FROM compra_detalles cd
JOIN compras  co ON co.id = cd.compra_id
JOIN productos p ON p.id  = cd.producto_id
JOIN proveedores pr ON pr.id = co.proveedor_id
WHERE cd.cantidad_restante > 0
ORDER BY cd.producto_id, co.fecha ASC, cd.id ASC;   -- ASC = FIFO

-- V3: Ganancia bruta por venta
CREATE VIEW IF NOT EXISTS v_ganancia_por_venta AS
SELECT
    v.id                                        AS venta_id,
    v.fecha,
    v.metodo_pago,
    v.total                                     AS ingreso,
    v.costo_total                               AS costo,
    (v.total - v.costo_total)                   AS ganancia_bruta,
    CASE WHEN v.total > 0
         THEN ROUND((v.total - v.costo_total) * 100.0 / v.total, 2)
         ELSE 0
    END                                         AS margen_pct
FROM ventas v
ORDER BY v.fecha DESC;

-- V4: KPI — Resumen de ganancias brutas por día
CREATE VIEW IF NOT EXISTS v_kpi_diario AS
SELECT
    DATE(fecha)                                 AS dia,
    COUNT(*)                                    AS num_ventas,
    ROUND(SUM(total),2)                         AS ingresos,
    ROUND(SUM(costo_total),2)                   AS costos,
    ROUND(SUM(total - costo_total),2)           AS ganancia_bruta,
    ROUND(AVG(total - costo_total),2)           AS ganancia_bruta_promedio
FROM ventas
GROUP BY DATE(fecha)
ORDER BY dia DESC;

-- V5: KPI — Resumen por mes
CREATE VIEW IF NOT EXISTS v_kpi_mensual AS
SELECT
    strftime('%Y-%m', fecha)                    AS mes,
    COUNT(*)                                    AS num_ventas,
    ROUND(SUM(total),2)                         AS ingresos,
    ROUND(SUM(costo_total),2)                   AS costos,
    ROUND(SUM(total - costo_total),2)           AS ganancia_bruta,
    SUM(CASE metodo_pago WHEN 'efectivo'      THEN total ELSE 0 END) AS total_efectivo,
    SUM(CASE metodo_pago WHEN 'tarjeta'       THEN total ELSE 0 END) AS total_tarjeta,
    SUM(CASE metodo_pago WHEN 'transferencia' THEN total ELSE 0 END) AS total_transferencia
FROM ventas
GROUP BY strftime('%Y-%m', fecha)
ORDER BY mes DESC;

-- V6: KPI — Margen por producto (histórico)
CREATE VIEW IF NOT EXISTS v_kpi_margen_producto AS
SELECT
    p.id                                                                AS producto_id,
    p.nombre                                                            AS producto,
    cat.nombre                                                          AS categoria,
    COUNT(DISTINCT vd.venta_id)                                         AS num_ventas,
    ROUND(SUM(vd.cantidad),2)                                           AS unidades_vendidas,
    ROUND(SUM(vd.cantidad * vd.precio_venta),2)                         AS ingresos_total,
    ROUND(SUM(vd.cantidad * vd.precio_costo),2)                         AS costo_total,
    ROUND(SUM(vd.cantidad * vd.precio_venta) - SUM(vd.cantidad * vd.precio_costo),2) AS ganancia_bruta,
    CASE WHEN SUM(vd.cantidad * vd.precio_venta) > 0
         THEN ROUND((SUM(vd.cantidad * vd.precio_venta) - SUM(vd.cantidad * vd.precio_costo)) * 100.0 / SUM(vd.cantidad * vd.precio_venta),2)
         ELSE 0
    END                                                                 AS margen_pct
FROM venta_detalles vd
JOIN productos   p   ON p.id   = vd.producto_id
JOIN categorias  cat ON cat.id = p.categoria_id
GROUP BY vd.producto_id
ORDER BY ganancia_bruta DESC;

-- V7: KPI — Ventas por método de pago (global)
CREATE VIEW IF NOT EXISTS v_kpi_metodo_pago AS
SELECT
    metodo_pago,
    COUNT(*)                        AS num_ventas,
    ROUND(SUM(total),2)             AS total_cobrado,
    ROUND(AVG(total),2)             AS ticket_promedio
FROM ventas
GROUP BY metodo_pago;

-- V8: Historial completo de ajustes de inventario
CREATE VIEW IF NOT EXISTS v_ajustes_historial AS
SELECT
    ai.id,
    ai.fecha,
    p.nombre        AS producto,
    c.nombre        AS categoria,
    ai.tipo,
    ai.cantidad,
    ai.motivo,
    ai.stock_antes,
    ai.stock_despues
FROM ajustes_inventario ai
JOIN productos  p ON p.id = ai.producto_id
JOIN categorias c ON c.id = p.categoria_id
ORDER BY ai.fecha DESC;

-- V9: Productos por debajo del stock mínimo (vista rápida de reposición)
CREATE VIEW IF NOT EXISTS v_reposicion AS
SELECT
    p.id,
    p.nombre                        AS producto,
    cat.nombre                      AS categoria,
    p.stock_actual,
    p.stock_minimo,
    (p.stock_minimo - p.stock_actual) AS faltante
FROM productos p
JOIN categorias cat ON cat.id = p.categoria_id
WHERE p.activo = 1
  AND p.stock_actual <= p.stock_minimo
ORDER BY faltante DESC;


-- =============================================================================
-- VISTAS ESTADÍSTICAS Y ECONÓMICAS EXTENDIDAS
-- =============================================================================

-- V10: Ganancia bruta por semana
CREATE VIEW IF NOT EXISTS v_kpi_semanal AS
SELECT
    strftime('%Y-W%W', fecha)                           AS semana,
    COUNT(*)                                            AS num_ventas,
    ROUND(SUM(total), 2)                                AS ingresos,
    ROUND(SUM(costo_total), 2)                          AS costos,
    ROUND(SUM(total - costo_total), 2)                  AS ganancia_bruta,
    ROUND(AVG(total), 2)                                AS ticket_promedio
FROM ventas
GROUP BY strftime('%Y-W%W', fecha)
ORDER BY semana DESC;

-- V11: Mejor día de la semana por ingresos
CREATE VIEW IF NOT EXISTS v_kpi_dia_semana AS
SELECT
    CASE strftime('%w', fecha)
        WHEN '0' THEN 'Domingo'
        WHEN '1' THEN 'Lunes'
        WHEN '2' THEN 'Martes'
        WHEN '3' THEN 'Miércoles'
        WHEN '4' THEN 'Jueves'
        WHEN '5' THEN 'Viernes'
        WHEN '6' THEN 'Sábado'
    END                                                 AS dia_semana,
    strftime('%w', fecha)                               AS orden,
    COUNT(*)                                            AS num_ventas,
    ROUND(AVG(total), 2)                                AS ticket_promedio,
    ROUND(SUM(total), 2)                                AS ingresos_total,
    ROUND(SUM(total - costo_total), 2)                  AS ganancia_total
FROM ventas
GROUP BY strftime('%w', fecha)
ORDER BY ingresos_total DESC;

-- V12: Hora pico de ventas
CREATE VIEW IF NOT EXISTS v_kpi_hora_pico AS
SELECT
    strftime('%H', fecha)                               AS hora,
    COUNT(*)                                            AS num_ventas,
    ROUND(SUM(total), 2)                                AS ingresos,
    ROUND(AVG(total), 2)                                AS ticket_promedio
FROM ventas
GROUP BY strftime('%H', fecha)
ORDER BY num_ventas DESC;

-- V13: Top 10 productos más vendidos por unidades
CREATE VIEW IF NOT EXISTS v_top10_mas_vendidos AS
SELECT
    p.nombre                                            AS producto,
    cat.nombre                                          AS categoria,
    ROUND(SUM(vd.cantidad), 0)                          AS unidades_vendidas,
    ROUND(SUM(vd.cantidad * vd.precio_venta), 2)        AS ingresos,
    ROUND(SUM(vd.cantidad * vd.precio_costo), 2)        AS costos,
    ROUND(SUM(vd.cantidad * (vd.precio_venta - vd.precio_costo)), 2) AS ganancia_bruta
FROM venta_detalles vd
JOIN productos  p   ON p.id   = vd.producto_id
JOIN categorias cat ON cat.id = p.categoria_id
GROUP BY vd.producto_id
ORDER BY unidades_vendidas DESC
LIMIT 10;

-- V14: Top 10 productos menos vendidos (candidatos a revisar)
CREATE VIEW IF NOT EXISTS v_top10_menos_vendidos AS
SELECT
    p.nombre                                            AS producto,
    cat.nombre                                          AS categoria,
    COALESCE(ROUND(SUM(vd.cantidad), 0), 0)             AS unidades_vendidas,
    p.stock_actual
FROM productos p
JOIN categorias cat ON cat.id = p.categoria_id
LEFT JOIN venta_detalles vd ON vd.producto_id = p.id
WHERE p.activo = 1
GROUP BY p.id
ORDER BY unidades_vendidas ASC
LIMIT 10;

-- V15: Productos que nunca se han vendido
CREATE VIEW IF NOT EXISTS v_productos_sin_ventas AS
SELECT
    p.nombre                                            AS producto,
    cat.nombre                                          AS categoria,
    p.stock_actual,
    p.precio_venta,
    ROUND(p.stock_actual * p.precio_venta, 2)           AS valor_inventario
FROM productos p
JOIN categorias cat ON cat.id = p.categoria_id
LEFT JOIN venta_detalles vd ON vd.producto_id = p.id
WHERE vd.id IS NULL AND p.activo = 1;

-- V16: Valor del inventario actual (a precio de costo promedio y a precio de venta)
CREATE VIEW IF NOT EXISTS v_valor_inventario AS
SELECT
    p.nombre                                            AS producto,
    cat.nombre                                          AS categoria,
    p.stock_actual,
    ROUND(costo_prom.costo_promedio, 4)                 AS costo_promedio,
    p.precio_venta,
    ROUND(p.stock_actual * costo_prom.costo_promedio, 2) AS valor_a_costo,
    ROUND(p.stock_actual * p.precio_venta, 2)           AS valor_a_venta,
    ROUND(p.stock_actual * (p.precio_venta - costo_prom.costo_promedio), 2) AS ganancia_potencial
FROM productos p
JOIN categorias cat ON cat.id = p.categoria_id
JOIN (
    SELECT producto_id, AVG(precio_costo) AS costo_promedio
    FROM compra_detalles
    GROUP BY producto_id
) costo_prom ON costo_prom.producto_id = p.id
WHERE p.activo = 1
ORDER BY valor_a_costo DESC;

-- V17: Ventas e ingresos por categoría
CREATE VIEW IF NOT EXISTS v_kpi_por_categoria AS
SELECT
    cat.nombre                                          AS categoria,
    COUNT(DISTINCT vd.venta_id)                         AS num_transacciones,
    ROUND(SUM(vd.cantidad), 0)                          AS unidades_vendidas,
    ROUND(SUM(vd.cantidad * vd.precio_venta), 2)        AS ingresos,
    ROUND(SUM(vd.cantidad * vd.precio_costo), 2)        AS costos,
    ROUND(SUM(vd.cantidad * (vd.precio_venta - vd.precio_costo)), 2) AS ganancia_bruta,
    CASE WHEN SUM(vd.cantidad * vd.precio_venta) > 0
         THEN ROUND(SUM(vd.cantidad * (vd.precio_venta - vd.precio_costo)) * 100.0
              / SUM(vd.cantidad * vd.precio_venta), 2)
         ELSE 0
    END                                                 AS margen_pct
FROM venta_detalles vd
JOIN productos  p   ON p.id   = vd.producto_id
JOIN categorias cat ON cat.id = p.categoria_id
GROUP BY cat.id
ORDER BY ganancia_bruta DESC;

-- V18: Total comprado por proveedor
CREATE VIEW IF NOT EXISTS v_kpi_por_proveedor AS
SELECT
    pr.nombre                                           AS proveedor,
    COUNT(DISTINCT c.id)                                AS num_compras,
    ROUND(SUM(c.total), 2)                              AS total_comprado,
    ROUND(AVG(c.total), 2)                              AS promedio_por_compra,
    MIN(DATE(c.fecha))                                  AS primera_compra,
    MAX(DATE(c.fecha))                                  AS ultima_compra
FROM compras c
JOIN proveedores pr ON pr.id = c.proveedor_id
GROUP BY pr.id
ORDER BY total_comprado DESC;

-- V19: Evolución del costo por producto y lote (detectar inflación de costos)
CREATE VIEW IF NOT EXISTS v_evolucion_costos AS
SELECT
    p.nombre                                            AS producto,
    co.fecha                                            AS fecha_compra,
    pr.nombre                                           AS proveedor,
    cd.cantidad,
    cd.precio_costo,
    cd.precio_venta_lote,
    ROUND((cd.precio_venta_lote - cd.precio_costo) * 100.0
          / cd.precio_costo, 2)                         AS margen_lote_pct
FROM compra_detalles cd
JOIN compras     co ON co.id  = cd.compra_id
JOIN productos    p ON p.id   = cd.producto_id
JOIN proveedores pr ON pr.id  = co.proveedor_id
ORDER BY p.nombre, co.fecha ASC;

-- V20: Capital inmovilizado — lotes con stock sin vender
CREATE VIEW IF NOT EXISTS v_capital_inmovilizado AS
SELECT
    p.nombre                                            AS producto,
    cat.nombre                                          AS categoria,
    COUNT(cd.id)                                        AS lotes_activos,
    ROUND(SUM(cd.cantidad_restante), 0)                 AS unidades_sin_vender,
    ROUND(SUM(cd.cantidad_restante * cd.precio_costo), 2) AS capital_inmovilizado,
    ROUND(SUM(cd.cantidad_restante * cd.precio_venta_lote), 2) AS valor_potencial_venta
FROM compra_detalles cd
JOIN productos  p   ON p.id   = cd.producto_id
JOIN categorias cat ON cat.id = p.categoria_id
WHERE cd.cantidad_restante > 0
GROUP BY cd.producto_id
ORDER BY capital_inmovilizado DESC;

-- V21: Eficiencia de venta por lote (% vendido de cada lote comprado)
CREATE VIEW IF NOT EXISTS v_eficiencia_lotes AS
SELECT
    p.nombre                                            AS producto,
    cd.id                                               AS lote_id,
    DATE(co.fecha)                                      AS fecha_compra,
    pr.nombre                                           AS proveedor,
    cd.cantidad                                         AS comprado,
    ROUND(cd.cantidad - cd.cantidad_restante, 0)        AS vendido,
    cd.cantidad_restante                                AS disponible,
    ROUND((cd.cantidad - cd.cantidad_restante) * 100.0
          / cd.cantidad, 1)                             AS pct_vendido,
    CASE
        WHEN cd.cantidad_restante = 0            THEN 'AGOTADO'
        WHEN (cd.cantidad - cd.cantidad_restante)
             * 100.0 / cd.cantidad >= 50         THEN 'EN CURSO'
        ELSE 'LENTO'
    END                                                 AS estado
FROM compra_detalles cd
JOIN compras     co ON co.id = cd.compra_id
JOIN productos    p ON p.id  = cd.producto_id
JOIN proveedores pr ON pr.id = co.proveedor_id
ORDER BY p.nombre, co.fecha;

-- V22: Pérdidas por ajustes de inventario (merma, robo, etc.)
CREATE VIEW IF NOT EXISTS v_kpi_perdidas AS
SELECT
    motivo,
    COUNT(*)                                            AS num_ajustes,
    ROUND(SUM(CASE tipo WHEN 'salida' THEN cantidad ELSE 0 END), 2) AS unidades_perdidas,
    ROUND(SUM(CASE tipo WHEN 'entrada' THEN cantidad ELSE 0 END), 2) AS unidades_recuperadas
FROM ajustes_inventario
GROUP BY motivo
ORDER BY unidades_perdidas DESC;

-- V23: Dashboard general — snapshot rápido del negocio
CREATE VIEW IF NOT EXISTS v_dashboard AS
SELECT 'Ventas hoy'             AS kpi,
       CAST(COUNT(*) AS TEXT)   AS valor
FROM ventas WHERE DATE(fecha) = DATE('now','localtime')
UNION ALL
SELECT 'Ingresos hoy',
       CAST(ROUND(COALESCE(SUM(total),0),2) AS TEXT)
FROM ventas WHERE DATE(fecha) = DATE('now','localtime')
UNION ALL
SELECT 'Ganancia bruta hoy',
       CAST(ROUND(COALESCE(SUM(total-costo_total),0),2) AS TEXT)
FROM ventas WHERE DATE(fecha) = DATE('now','localtime')
UNION ALL
SELECT 'Ingresos este mes',
       CAST(ROUND(COALESCE(SUM(total),0),2) AS TEXT)
FROM ventas WHERE strftime('%Y-%m',fecha) = strftime('%Y-%m','now','localtime')
UNION ALL
SELECT 'Ganancia bruta este mes',
       CAST(ROUND(COALESCE(SUM(total-costo_total),0),2) AS TEXT)
FROM ventas WHERE strftime('%Y-%m',fecha) = strftime('%Y-%m','now','localtime')
UNION ALL
SELECT 'Productos a reponer',
       CAST(COUNT(*) AS TEXT)
FROM v_reposicion
UNION ALL
SELECT 'Valor inventario (costo)',
       CAST(ROUND(COALESCE(SUM(capital_inmovilizado),0),2) AS TEXT)
FROM v_capital_inmovilizado
UNION ALL
SELECT 'Valor inventario (venta)',
       CAST(ROUND(COALESCE(SUM(valor_potencial_venta),0),2) AS TEXT)
FROM v_capital_inmovilizado;

-- V_HISTORIAL_MARGENES: trazabilidad completa de cambios de margen por producto
CREATE VIEW IF NOT EXISTS v_historial_margenes AS
SELECT
    hm.id,
    hm.fecha,
    p.nombre                                        AS producto,
    cat.nombre                                      AS categoria,
    hm.margen_anterior                              AS margen_pct_antes,
    hm.margen_nuevo                                 AS margen_pct_despues,
    hm.precio_venta_anterior                        AS precio_antes,
    hm.precio_venta_nuevo                           AS precio_despues,
    ROUND(hm.precio_venta_nuevo
          - hm.precio_venta_anterior, 2)            AS diferencia_precio,
    COALESCE(hm.motivo, '(sin motivo)')             AS motivo
FROM historial_margenes hm
JOIN productos  p   ON p.id   = hm.producto_id
JOIN categorias cat ON cat.id = p.categoria_id
ORDER BY hm.fecha DESC;

-- =============================================================================
-- DATOS INICIALES DE EJEMPLO
-- =============================================================================

-- Categorías base de un minimarket
INSERT OR IGNORE INTO categorias (nombre, descripcion) VALUES
    ('Bebidas',         'Refrescos, agua, jugos, lácteos líquidos'),
    ('Alimentos',       'Enlatados, pastas, arroz, azúcar, sal'),
    ('Snacks',          'Galletas, papas fritas, golosinas'),
    ('Limpieza',        'Detergentes, jabones, desengrasantes'),
    ('Higiene Personal','Champú, pasta dental, desodorante'),
    ('Varios',          'Artículos de uso general');

-- Proveedor de ejemplo
INSERT OR IGNORE INTO proveedores (nombre, contacto, telefono) VALUES
    ('Distribuidor Central', 'Juan Pérez', '555-1234'),
    ('Proveedor Local',      'Ana García', '555-5678');

-- Productos de ejemplo
-- precio_venta se calcula automáticamente al registrar el primer lote de compra
-- margen_ganancia_pct: porcentaje de ganancia deseado sobre el costo
INSERT OR IGNORE INTO productos (nombre, categoria_id, precio_venta, margen_ganancia_pct, stock_minimo) VALUES
    ('Agua mineral 500ml',    1, 0, 30,  20),
    ('Refresco cola 1L',      1, 0, 25,  15),
    ('Arroz blanco 1kg',      2, 0, 20,  10),
    ('Aceite vegetal 1L',     2, 0, 22,   8),
    ('Galletas surtidas',     3, 0, 35,  12),
    ('Jabón de lavar 200g',   4, 0, 28,  10),
    ('Pasta dental 75ml',     5, 0, 30,   8);

-- =============================================================================
-- CONSULTAS DE EJEMPLO (comentadas — ejecutar según necesidad)
-- =============================================================================

-- ** Ver productos que necesitan reposición **
-- SELECT * FROM v_reposicion;

-- ** Ver todos los lotes disponibles (FIFO) de un producto **
-- SELECT * FROM v_lotes_disponibles WHERE producto_id = 1;

-- ** KPI del mes actual **
-- SELECT * FROM v_kpi_mensual WHERE mes = strftime('%Y-%m','now','localtime');

-- ** KPI del día de hoy **
-- SELECT * FROM v_kpi_diario WHERE dia = DATE('now','localtime');

-- ** Margen por producto ordenado por ganancia **
-- SELECT * FROM v_kpi_margen_producto;

-- ** Ganancia bruta total de un rango de fechas **
-- SELECT
--     SUM(total)      AS ingresos,
--     SUM(costo_total)AS costos,
--     SUM(total - costo_total) AS ganancia_bruta
-- FROM ventas
-- WHERE fecha BETWEEN '2024-01-01' AND '2024-12-31';

-- =============================================================================
-- FLUJO FIFO AL REGISTRAR UNA VENTA  (pseudocódigo / ejemplo comentado)
-- =============================================================================
-- 1. Insertar cabecera en `ventas`.
-- 2. Para cada producto vendido:
--    a. Consultar v_lotes_disponibles WHERE producto_id = ? ORDER BY fecha_compra ASC
--    b. Ir consumiendo lotes en orden (más antiguo primero) hasta cubrir la cantidad.
--    c. Por cada lote usado, insertar en `venta_detalles`:
--       (venta_id, producto_id, lote_id, cantidad, precio_venta, precio_costo)
--    d. El trigger trg_venta_detalle_insert se encarga del resto automáticamente.
-- =============================================================================
