# MiniMarket

Aplicación de gestión de inventario y ventas para minimarket con método FIFO, construida con Flutter.

## Capturas

<div align="center">

| | |
|---|---|
| <img src="docs/screenshots/dashboard.jpg" width="300"><br>*Dashboard* | <img src="docs/screenshots/productos.jpg" width="300"><br>*Productos* |
| <img src="docs/screenshots/ventas.jpg" width="300"><br>*Ventas* | <img src="docs/screenshots/compras.jpg" width="300"><br>*Compras* |
| <img src="docs/screenshots/reportes.jpg" width="300"><br>*Reportes* | |

</div>

## Funcionalidades

- **Dashboard** — KPIs en tiempo real con tarjetas premium, sparklines de 7 días, evolución diaria, top 5 más vendidos, ventas por método de pago (pie chart), alertas de stock bajo.
- **Productos** — CRUD completo, filtro por categoría, búsqueda por nombre, filtro de stock bajo, control de activos/inactivos.
- **Ventas** — Registro de ventas con selección de productos por diálogo, control de cantidad y método de pago (efectivo/tarjeta/transferencia), cálculo de ganancia por producto.
- **Compras** — Registro de compras con asignación de proveedor y número de factura, detalle por lote con seguimiento FIFO.
- **Reportes** — Análisis diario, semanal, mensual, mejor día de la semana, hora pico, ventas por categoría, margen por producto.
- **Categorías y Proveedores** — CRUD con activación/desactivación.
- **Ajustes de inventario** — Registro de entradas/salidas con motivo y control de stock resultante.

## Stack técnico

| Componente | Tecnología |
|---|---|
| Framework | Flutter 3.x / Dart 3.x |
| Estado | Riverpod (con riverpod_annotation + codegen) |
| Base de datos | Drift (SQLite) con FIFO vía window functions |
| Navegación | go_router |
| Gráficos | fl_chart |
| Localización | flutter_localizations (español) |
| Arquitectura | UI / Notifiers / Providers / Repositories / DAOs |

## Gestión de inventario FIFO

La app implementa contabilidad de costos **FIFO** (First In, First Out):

- Cada compra genera lotes con precio de costo unitario.
- Al vender, el costo se descuenta del lote más antiguo con saldo disponible.
- Las vistas `v_kpi_*` calculan ganancia bruta, márgenes y rotación mediante ventanas SQL.

## Requisitos

- Flutter SDK 3.11+
- Dart 3.11+

## Instalación

```bash
git clone <repo-url>
cd minimarket
flutter pub get
flutter run
```

La base de datos se inicializa automáticamente con datos de demostración al primer inicio.

## Licencia

MIT
