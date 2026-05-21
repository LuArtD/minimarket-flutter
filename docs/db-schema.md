# DB Schema — Minimarket

> SQL completo en `minimarket.sql`. Este archivo documenta contratos, reglas y comportamiento de triggers.

## Tables

### `categorias`
| col | type | notes |
|-----|------|-------|
| id | INTEGER PK | |
| nombre | TEXT UNIQUE | |
| descripcion | TEXT | |
| activa | INTEGER | 1=activa, 0=inactiva |

### `proveedores`
| col | type | notes |
|-----|------|-------|
| id | INTEGER PK | |
| nombre | TEXT UNIQUE | |
| contacto / telefono / email / direccion | TEXT | |
| activo | INTEGER | 1/0 |

### `productos`
| col | type | notes |
|-----|------|-------|
| id | INTEGER PK | |
| nombre | TEXT UNIQUE | |
| categoria_id | FK categorias | |
| precio_venta | REAL | **Auto-managed by T1/T5** — MAX(lotes activos × margen) |
| margen_ganancia_pct | REAL | e.g. 30 = 30%. Changing this fires T5 |
| stock_minimo | REAL | Alert threshold |
| stock_actual | REAL | **Auto-managed by triggers** — never update manually |
| activo | INTEGER | 1/0 |

### `compras` (purchase order header)
| col | type | notes |
|-----|------|-------|
| id | INTEGER PK | |
| proveedor_id | FK proveedores | |
| fecha | TEXT | datetime |
| nro_factura | TEXT | optional |
| total | REAL | **Auto-calculated by T1** |

### `compra_detalles` (FIFO lots)
| col | type | notes |
|-----|------|-------|
| id | INTEGER PK | = lote_id |
| compra_id | FK compras | |
| producto_id | FK productos | |
| cantidad | REAL | total purchased |
| cantidad_restante | REAL | **Auto-decremented by T2** — equals cantidad on insert |
| precio_costo | REAL | unit cost paid to supplier |
| precio_venta_lote | REAL | **Auto-calculated by T1**: `precio_costo × (1 + margen/100)` |
| subtotal | REAL | GENERATED: `cantidad × precio_costo` — never insert |

### `ventas` (sale header)
| col | type | notes |
|-----|------|-------|
| id | INTEGER PK | |
| fecha | TEXT | datetime |
| metodo_pago | TEXT | `'efectivo'│'tarjeta'│'transferencia'` |
| total | REAL | **Auto-calculated by T2** |
| costo_total | REAL | **Auto-calculated by T2** |

### `venta_detalles` (sale lines — one per FIFO lot consumed)
| col | type | notes |
|-----|------|-------|
| id | INTEGER PK | |
| venta_id | FK ventas | |
| producto_id | FK productos | |
| lote_id | FK compra_detalles | which lot was consumed |
| cantidad | REAL | units taken from this lot |
| precio_venta | REAL | = `productos.precio_venta` at time of sale |
| precio_costo | REAL | = `compra_detalles.precio_costo` of that lot |
| subtotal | REAL | GENERATED: `cantidad × precio_venta` — never insert |
| costo_subtotal | REAL | GENERATED: `cantidad × precio_costo` — never insert |

### `ajustes_inventario` (physical inventory adjustments)
| col | type | notes |
|-----|------|-------|
| id | INTEGER PK | |
| producto_id | FK productos | |
| fecha | TEXT | |
| tipo | TEXT | `'entrada'│'salida'` |
| cantidad | REAL | always positive |
| motivo | TEXT | e.g. 'conteo físico', 'merma', 'robo' |
| stock_antes | REAL | record before adjustment |
| stock_despues | REAL | record after adjustment |

### `historial_margenes` (margin change audit log)
| col | type | notes |
|-----|------|-------|
| id | INTEGER PK | |
| producto_id | FK productos | |
| margen_anterior / margen_nuevo | REAL | |
| precio_venta_anterior / precio_venta_nuevo | REAL | |
| motivo | TEXT | optional |
| fecha | TEXT | auto |

---

## Triggers (automatic — never replicate in app code)

| Trigger | Fires on | Does |
|---------|----------|------|
| T1 `trg_compra_detalle_insert` | INSERT compra_detalles | Calculates `precio_venta_lote`; updates `productos.precio_venta` to MAX active lot; adds stock; recalculates `compras.total` |
| T2 `trg_venta_detalle_insert` | INSERT venta_detalles | Decrements `compra_detalles.cantidad_restante`; decrements `productos.stock_actual`; recalculates `ventas.total` + `costo_total` |
| T3 `trg_ajuste_inventario_insert` | INSERT ajustes_inventario | Updates `productos.stock_actual` ±cantidad |
| T4 `trg_producto_update` | UPDATE precio_venta/margen/stock_minimo | Updates `actualizado_en` |
| T5 `trg_margen_update` | UPDATE margen_ganancia_pct | Logs to `historial_margenes`; recalculates ALL active lots' `precio_venta_lote`; updates `productos.precio_venta` |

---

## Critical Business Rules

### FIFO
- Source: `v_lotes_disponibles` ordered by `fecha_compra ASC`
- One sale can span multiple lots → multiple `venta_detalles` rows for same `venta_id` + `producto_id`
- Validate total available stock BEFORE opening transaction

### Pricing
- `precio_venta` on product is always MAX of active lots × their margen
- `precio_venta` to use in `venta_detalles.precio_venta` = `productos.precio_venta` at moment of sale
- `precio_costo` in `venta_detalles` = the specific lot's `precio_costo`

### Stock Adjustments
- App must pass `stock_antes` = current `productos.stock_actual` before inserting
- `stock_despues` = stock_antes ± cantidad depending on tipo

### Margin Change
- Only one UPDATE needed: `UPDATE productos SET margen_ganancia_pct = ? WHERE id = ?`
- T5 handles everything else automatically
- Optionally write `motivo` to `historial_margenes` via separate UPDATE after trigger fires

---

## Views Reference

### Operational
- `v_lotes_disponibles` — active lots sorted FIFO, use as source for sales
- `v_stock_alertas` — all products with OK/REPONER status
- `v_reposicion` — only products below minimum stock
- `v_alertas_precio` — products where precio_venta doesn't match correct calculation

### KPIs / Reports
- `v_dashboard` — 8-row snapshot: sales today, income today, gross profit today, monthly income, monthly profit, products to reorder, inventory value at cost, inventory value at sale price
- `v_kpi_diario` — daily: num_ventas, ingresos, costos, ganancia_bruta
- `v_kpi_semanal` — weekly same
- `v_kpi_mensual` — monthly + breakdown by payment method
- `v_kpi_dia_semana` — best day of week
- `v_kpi_hora_pico` — peak sales hour
- `v_kpi_margen_producto` — margin % per product
- `v_kpi_por_categoria` — sales + margin per category
- `v_kpi_por_proveedor` — total purchased per supplier
- `v_kpi_metodo_pago` — totals per payment method
- `v_kpi_perdidas` — losses by adjustment motive

### Inventory
- `v_valor_inventario` — stock value at cost + at sale price + potential profit
- `v_capital_inmovilizado` — unsold stock value per product
- `v_eficiencia_lotes` — % sold per lot (AGOTADO / EN CURSO / LENTO)
- `v_evolucion_costos` — cost evolution per product across lots (inflation tracking)

### Audit
- `v_historial_margenes` — full margin change log
- `v_ajustes_historial` — full inventory adjustment log
- `v_ganancia_por_venta` — profit per individual sale
- `v_top10_mas_vendidos` / `v_top10_menos_vendidos` / `v_productos_sin_ventas`
