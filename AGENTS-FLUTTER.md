# Minimarket — Flutter

## Descripción del Proyecto

Aplicación Flutter para gestión de minimarket/tienda. Maneja inventario con sistema FIFO por lotes, compras a proveedores, ventas con cálculo automático de ganancia, ajustes de inventario y KPIs de negocio. Toda la lógica de negocio reside en la capa de datos; la UI (Flutter widgets) es responsabilidad del developer.

## Stack

- **Flutter** (última versión estable) → https://docs.flutter.dev/
- **Dart** (última versión estable) → https://dart.dev/guides
- **Riverpod** (state management + inyección de dependencias) → https://riverpod.dev/
- **Drift** (base de datos SQLite con ORM) → https://drift.simonbinder.eu/
- **Material 3** (diseño y componentes UI) → https://api.flutter.dev/flutter/material/package-summary.html

## Documentación Oficial (consultar antes de escribir código)

### Flutter
- Guía principal: https://docs.flutter.dev/
- Widgets: https://docs.flutter.dev/ui/widgets
- Layouts: https://docs.flutter.dev/ui/layout
- State management: https://docs.flutter.dev/data-and-backend/state-mgmt
- Navigation: https://docs.flutter.dev/cookbook/navigation/navigation-basics

### Riverpod
- Introducción: https://riverpod.dev/docs/introduction/getting_started
- Providers: https://riverpod.dev/docs/concepts/providers
- Notifier: https://riverpod.dev/docs/concepts/notifiers
- Inyección de dependencias: https://riverpod.dev/docs/essentials/dependency_overrides
- Async providers: https://riverpod.dev/docs/essentials/async_providers

### Drift
- Setup: https://drift.simonbinder.eu/setup/
- Tables: https://drift.simonbinder.eu/docs/defining-tables/
- Queries: https://drift.simonbinder.eu/docs/writing_queries/
- Generated code: https://drift.simonbinder.eu/docs/getting-started/codegen/
- Migrations: https://drift.simonbinder.eu/docs/advanced-features/migrations/
- SQL views: https://drift.simonbinder.eu/docs/advanced-features/views/

### Material 3 (Flutter)
- Material 3: https://docs.flutter.dev/ui/design/material-3
- Theme: https://api.flutter.dev/flutter/material/ThemeData-class.html
- ColorScheme: https://api.flutter.dev/flutter/material/ColorScheme-class.html

## Gestión de Estado con Riverpod

### Reglas de estado (ESTRICTO)

- **`StateProvider`**: estado simple y mutable (contadores, toggles, inputs de texto)
- **`StateNotifierProvider` / `NotifierProvider`**: estado complejo con lógica (lista de productos, formularios)
- **`FutureProvider`**: operaciones async únicas (cargar datos iniciales)
- **`StreamProvider`**: flujos continuos de datos (observar cambios en la base de datos)
- **`Provider`**: valores inmutables o servicios (repositorios, servicios)
- **`ref.watch()`**: observar un provider dentro de otro provider o dentro de un widget
- **`ref.read()`**: leer un provider una sola vez (eventos, callbacks)
- **`ref.listen()`**: escuchar cambios para efectos secundarios (mostrar snackbar, navegar)

### Patrones de estado

| Patrón | Cuándo usar |
|--------|-------------|
| `StateProvider` | Estado local simple (texto de input, checkbox, índice seleccionado) |
| `NotifierProvider` | Estado complejo con lógica de negocio y múltiples acciones |
| `FutureProvider` | Carga única de datos (fetch inicial) |
| `StreamProvider` | Datos reactivos que cambian en el tiempo (observar DB) |
| `Provider` | Servicios, repositorios, valores inmutables |

### Errores comunes a evitar

- NO usar `setState` para estado compartido entre pantallas → usar Riverpod
- NO llamar `ref.watch()` dentro de callbacks (`onPressed`, `onTap`) → usar `ref.read()`
- NO mutar estado directamente en Notifier → usar `state = state.copyWith(...)`
- NO crear providers sin tipo → siempre tipar explícitamente
- NO acceder a repositories directamente desde widgets → siempre via providers

## Material 3 — Reglas de UI

### Tema

- Usar `MaterialApp` con `theme: ThemeData(useMaterial3: true)`
- Usar `ColorScheme.fromSeed()` para generar esquema de colores
- NO hardcodear colores → siempre usar `Theme.of(context).colorScheme.primary`, `surface`, etc.

### Componentes

- **AppBar**: `AppBar` con `centerTitle` para headers de pantalla
- **NavigationBar**: navegación inferior con 3-5 destinos máximo
- **Cards**: `Card`, `OutlinedCard` según contexto
- **Buttons**: `FilledButton` (acción principal), `OutlinedButton` (secundaria), `TextButton` (terciaria)
- **TextFields**: `TextField` con `InputDecoration` para formularios
- **Lists**: `ListView.builder` para listas largas, NO `Column` con loops
- **Dialogs**: `showDialog` con `AlertDialog` para confirmaciones
- **SnackBars**: `ScaffoldMessenger.of(context).showSnackBar()` para mensajes efímeros
- **Indicadores**: `CircularProgressIndicator` para loading, `LinearProgressIndicator` para progreso conocido

### Espaciado y tipografía

- Usar `Theme.of(context).textTheme` para todos los textos (`displayLarge`, `headlineMedium`, `bodyLarge`, `labelSmall`, etc.)
- Espaciado con `SizedBox`, `Padding`, o valores constantes (`8.0`, `16.0`)
- NO usar valores mágicos → definir constantes en un archivo de spacing

## Arquitectura MVVM (ESTRICTA)

### Flujo de datos

```
UI (Widgets) → Notifier (ViewModel) → Repository → DAO → Drift (SQLite)
                ↑                                      ↓
                └────── Stream / Future ←──────────────┘
```

### Responsabilidades por capa

| Capa | Responsabilidad | NO debe |
|------|----------------|---------|
| **View** (Widgets) | Renderizar UI, capturar eventos del usuario | Contener lógica de negocio, acceso a DB |
| **Notifier** (ViewModel) | Exponer estado, manejar eventos de UI, orquestar Repositories | Referencias a widgets, BuildContext |
| **Repository** | Única fuente de verdad, orquestar DAOs + Services | Lógica de UI, exponer entities directamente |
| **Service** | Funciones stateless (FIFO, cálculos) | Acceder a Repositories o DAOs |
| **DAO** | Consultas SQL tipadas | Lógica de negocio fuera de queries |

### Notifier (ViewModel) con ciclo de vida

**Regla de oro**: TODOS los ViewModels se implementan como `Notifier` o `AsyncNotifier` de Riverpod. Esto garantiza:

- **Sobrevive cambios de configuración** (rotación, tema, etc.)
- **Scope ligado al lifecycle** del widget tree
- **Se destruye automáticamente** cuando ningún widget lo observa
- **Inyección automática** de dependencias via `ref.watch()` / `ref.read()`

### Estructura del Notifier

- Extender `Notifier` o `AsyncNotifier`
- Exponer un estado inmutable (clase con `copyWith`)
- Observar datos de Drift en `build()` usando `ref.watch()`
- Acciones de UI son métodos del Notifier que llaman al Repository
- Usar `state = state.copyWith(...)` para actualizar estado

### Reglas MVVM (CRÍTICO)

1. **UI nunca accede a Repository/DAO directamente** → siempre via Notifier
2. **Notifier nunca tiene referencia a widgets** → expone estado, la UI observa con `ref.watch()`
3. **Un solo estado por Notifier** (patrón UiState) → NO múltiples estados separados
4. **Notifier se destruye cuando no se observa** → Riverpod maneja el lifecycle
5. **Estado es inmutable** → usar `copyWith()` para actualizar, nunca modificar directamente
6. **Repository expone `Stream`** → Notifier lo consume y expone como estado
7. **Usar `AutoDispose`** para providers que no necesitan persistir fuera de pantalla

## Reglas de Arquitectura (ESTRICTO)

### Reglas por capa

- **Tables (Drift)**: solo definición de columnas con tipos Drift (`intColumn()`, `textColumn()`, `realColumn()`). Sin lógica de negocio.
- **DAOs**: solo consultas (`select`, `insert`, `update`, `delete`). Usar `Stream` para reads, `Future` para writes.
- **Repositories**: única fuente de verdad. Orquestan DAOs + servicios. Exponen `Stream` y `Future`.
- **Services**: funciones stateless. Sin acceso directo a Repositories.
- **Providers**: proveen todas las dependencias. Database como singleton, DAOs derivados de la misma instancia.

### Drift — Pre-popular DB

La base de datos debe pre-popularse con el SQL de `docs/minimarket.sql` en la primera ejecución. Usar `MigrationStrategy.beforeOpen` para ejecutar el script. El script usa `IF NOT EXISTS` en todas las sentencias, por lo que es seguro ejecutarlo en cada inicio.

### Drift — DAOs deben usar Stream para reads

- Reads: retornar `Stream<List<T>>` para que la UI se actualice automáticamente
- Writes: métodos `Future` que retornan el ID o void
- Consultar vistas directamente con `customSelect` o mapear resultados de `SELECT * FROM nombre_vista`

### Riverpod — Inyección de dependencias

- `@riverpod` para generar providers automáticamente (riverpod_generator)
- Database como provider singleton
- Repositories como providers que dependen de la database
- Notifiers como providers que dependen de los repositories
- Usar `ref.watch()` para dependencias entre providers

## Base de Datos

### Schema completo
→ Ver `docs/minimarket.sql` (SQL completo con tablas, triggers y vistas)
→ Ver `docs/db-schema.md` (documentación de contratos y reglas de negocio)

### Tablas

| Tabla | Descripción |
|-------|-------------|
| `categorias` | Categorías de productos (activa/inactiva) |
| `proveedores` | Proveedores con datos de contacto |
| `productos` | Productos con margen de ganancia, stock mínimo, stock actual |
| `compras` | Cabecera de orden de compra a proveedor |
| `compra_detalles` | Líneas de compra = lotes FIFO (cantidad_restante se decrementa al vender) |
| `ventas` | Cabecera de venta con método de pago |
| `venta_detalles` | Líneas de venta con referencia al lote consumido (FIFO) |
| `ajustes_inventario` | Ajustes de stock físico (entrada/salida por merma, robo, conteo) |
| `historial_margenes` | Auditoría de cambios de margen de ganancia |

### Triggers (automáticos — NO replicar en código app)

| Trigger | Fires on | Hace |
|---------|----------|------|
| T1 `trg_compra_detalle_insert` | INSERT compra_detalles | Calcula `precio_venta_lote`; actualiza `productos.precio_venta` al MAX de lotes activos; suma stock; recalcula `compras.total` |
| T2 `trg_venta_detalle_insert` | INSERT venta_detalles | Decrementa `cantidad_restante` del lote; decrementa `stock_actual`; recalcula `ventas.total` + `costo_total` |
| T3 `trg_ajuste_inventario_insert` | INSERT ajustes_inventario | Actualiza `productos.stock_actual` ±cantidad |
| T4 `trg_producto_update` | UPDATE precio_venta/margen/stock_minimo | Actualiza `actualizado_en` |
| T5 `trg_margen_update` | UPDATE margen_ganancia_pct | Log en `historial_margenes`; recalcula `precio_venta_lote` de lotes activos; actualiza `productos.precio_venta` |

### Reglas de Negocio (CRÍTICO)

1. **FIFO**: siempre consumir el lote más antiguo primero (`v_lotes_disponibles` ORDER BY `fecha_compra ASC`)
2. **NUNCA calcular stock manualmente**: los triggers lo manejan automáticamente
3. **NUNCA insertar `precio_venta_lote` manualmente**: trigger T1 lo calcula
4. **NUNCA insertar `subtotal`/`costo_subtotal`**: son columnas GENERATED
5. **Cambiar `margen_ganancia_pct`**: trigger T5 recalcula todos los lotes activos + log en `historial_margenes`
6. **Validar stock suficiente ANTES de insertar venta**: consultar `v_lotes_disponibles`
7. **`cantidad_restante` nunca puede ser negativo**: validar en FifoService antes de INSERT
8. **Métodos de pago**: `'efectivo' | 'tarjeta' | 'transferencia'`

### Vistas clave (usar para reads, nunca hacer joins manuales)

| Vista | Uso |
|-------|-----|
| `v_dashboard` | Snapshot rápido del negocio (8 KPIs) |
| `v_lotes_disponibles` | Lotes activos ordenados FIFO — fuente para ventas |
| `v_stock_alertas` | Productos con estado OK/REPONER |
| `v_reposicion` | Solo productos bajo stock mínimo |
| `v_alertas_precio` | Productos cuyo precio no coincide con el cálculo correcto |
| `v_kpi_diario` / `v_kpi_semanal` / `v_kpi_mensual` | KPIs por período |
| `v_kpi_margen_producto` | Margen % por producto |
| `v_kpi_por_categoria` | Ventas y margen por categoría |
| `v_kpi_por_proveedor` | Total comprado por proveedor |
| `v_kpi_metodo_pago` | Totales por método de pago |
| `v_valor_inventario` | Valor del inventario a costo y a venta |
| `v_capital_inmovilizado` | Capital inmovilizado en stock sin vender |
| `v_eficiencia_lotes` | % vendido por lote (AGOTADO/EN CURSO/LENTO) |
| `v_evolucion_costos` | Evolución de costos por producto (inflación) |
| `v_historial_margenes` | Log completo de cambios de margen |
| `v_ajustes_historial` | Log de ajustes de inventario |
| `v_ganancia_por_venta` | Ganancia por venta individual |
| `v_top10_mas_vendidos` / `v_top10_menos_vendidos` / `v_productos_sin_ventas` | Rankings |
| `v_kpi_dia_semana` / `v_kpi_hora_pico` | Mejor día y hora pico |
| `v_kpi_perdidas` | Pérdidas por tipo de ajuste |

### FifoService — Flujo de venta FIFO

1. INSERT INTO ventas → obtener venta_id
2. Para cada producto vendido:
   a. SELECT * FROM v_lotes_disponibles WHERE producto_id = ? ORDER BY fecha_compra ASC
   b. Consumir lotes oldest-first hasta cubrir la cantidad solicitada
   c. Para cada lote usado → INSERT INTO venta_detalles (venta_id, producto_id, lote_id, cantidad, precio_venta, precio_costo)
3. Los triggers manejan automáticamente: decremento de stock, cantidad_restante, totales de venta

## Errores

- Todas las operaciones de DB: try/catch, envolver en `Result<T>` o similar (success/error)
- Stock insuficiente: validar contra `v_lotes_disponibles` ANTES de insertar venta
- Lanzar excepciones específicas: `InsufficientStockException`, `ProductNotFoundException`, etc.
