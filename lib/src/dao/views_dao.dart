import 'package:drift/drift.dart';

import '../database/app_database.dart';

part 'views_dao.g.dart';

class DashboardEntry {
  final String kpi;
  final String valor;
  const DashboardEntry({required this.kpi, required this.valor});
}

class LoteDisponible {
  final int loteId;
  final String producto;
  final int productoId;
  final String fechaCompra;
  final int compraId;
  final String proveedor;
  final double cantidadOriginal;
  final double cantidadRestante;
  final double precioCosto;
  final double precioVentaLote;
  const LoteDisponible({
    required this.loteId,
    required this.producto,
    required this.productoId,
    required this.fechaCompra,
    required this.compraId,
    required this.proveedor,
    required this.cantidadOriginal,
    required this.cantidadRestante,
    required this.precioCosto,
    required this.precioVentaLote,
  });
}

class StockAlerta {
  final int id;
  final String producto;
  final String categoria;
  final double stockActual;
  final double stockMinimo;
  final double precioVenta;
  final String estadoStock;
  const StockAlerta({
    required this.id,
    required this.producto,
    required this.categoria,
    required this.stockActual,
    required this.stockMinimo,
    required this.precioVenta,
    required this.estadoStock,
  });
}

class ReposicionEntry {
  final int id;
  final String producto;
  final String categoria;
  final double stockActual;
  final double stockMinimo;
  final double faltante;
  const ReposicionEntry({
    required this.id,
    required this.producto,
    required this.categoria,
    required this.stockActual,
    required this.stockMinimo,
    required this.faltante,
  });
}

class KpiDiario {
  final String dia;
  final int numVentas;
  final double ingresos;
  final double costos;
  final double gananciaBruta;
  final double gananciaBrutaPromedio;
  const KpiDiario({
    required this.dia,
    required this.numVentas,
    required this.ingresos,
    required this.costos,
    required this.gananciaBruta,
    required this.gananciaBrutaPromedio,
  });
}

class KpiMensual {
  final String mes;
  final int numVentas;
  final double ingresos;
  final double costos;
  final double gananciaBruta;
  final double totalEfectivo;
  final double totalTarjeta;
  final double totalTransferencia;
  const KpiMensual({
    required this.mes,
    required this.numVentas,
    required this.ingresos,
    required this.costos,
    required this.gananciaBruta,
    required this.totalEfectivo,
    required this.totalTarjeta,
    required this.totalTransferencia,
  });
}

class KpiSemanal {
  final String semana;
  final int numVentas;
  final double ingresos;
  final double costos;
  final double gananciaBruta;
  final double ticketPromedio;
  const KpiSemanal({
    required this.semana,
    required this.numVentas,
    required this.ingresos,
    required this.costos,
    required this.gananciaBruta,
    required this.ticketPromedio,
  });
}

class KpiMargenProducto {
  final int productoId;
  final String producto;
  final String categoria;
  final int numVentas;
  final double unidadesVendidas;
  final double ingresosTotal;
  final double costoTotal;
  final double gananciaBruta;
  final double margenPct;
  const KpiMargenProducto({
    required this.productoId,
    required this.producto,
    required this.categoria,
    required this.numVentas,
    required this.unidadesVendidas,
    required this.ingresosTotal,
    required this.costoTotal,
    required this.gananciaBruta,
    required this.margenPct,
  });
}

class KpiMetodoPago {
  final String metodoPago;
  final int numVentas;
  final double totalCobrado;
  final double ticketPromedio;
  const KpiMetodoPago({
    required this.metodoPago,
    required this.numVentas,
    required this.totalCobrado,
    required this.ticketPromedio,
  });
}

class KpiPorCategoria {
  final String categoria;
  final int numTransacciones;
  final double unidadesVendidas;
  final double ingresos;
  final double costos;
  final double gananciaBruta;
  final double margenPct;
  const KpiPorCategoria({
    required this.categoria,
    required this.numTransacciones,
    required this.unidadesVendidas,
    required this.ingresos,
    required this.costos,
    required this.gananciaBruta,
    required this.margenPct,
  });
}

class KpiPorProveedor {
  final String proveedor;
  final int numCompras;
  final double totalComprado;
  final double promedioPorCompra;
  final String primeraCompra;
  final String ultimaCompra;
  const KpiPorProveedor({
    required this.proveedor,
    required this.numCompras,
    required this.totalComprado,
    required this.promedioPorCompra,
    required this.primeraCompra,
    required this.ultimaCompra,
  });
}

class ValorInventario {
  final String producto;
  final String categoria;
  final double stockActual;
  final double costoPromedio;
  final double precioVenta;
  final double valorACosto;
  final double valorAVenta;
  final double gananciaPotencial;
  const ValorInventario({
    required this.producto,
    required this.categoria,
    required this.stockActual,
    required this.costoPromedio,
    required this.precioVenta,
    required this.valorACosto,
    required this.valorAVenta,
    required this.gananciaPotencial,
  });
}

class CapitalInmovilizado {
  final String producto;
  final String categoria;
  final int lotesActivos;
  final double unidadesSinVender;
  final double capitalInmovilizado;
  final double valorPotencialVenta;
  const CapitalInmovilizado({
    required this.producto,
    required this.categoria,
    required this.lotesActivos,
    required this.unidadesSinVender,
    required this.capitalInmovilizado,
    required this.valorPotencialVenta,
  });
}

class EficienciaLote {
  final String producto;
  final int loteId;
  final String fechaCompra;
  final String proveedor;
  final double comprado;
  final double vendido;
  final double disponible;
  final double pctVendido;
  final String estado;
  const EficienciaLote({
    required this.producto,
    required this.loteId,
    required this.fechaCompra,
    required this.proveedor,
    required this.comprado,
    required this.vendido,
    required this.disponible,
    required this.pctVendido,
    required this.estado,
  });
}

class EvolucionCosto {
  final String producto;
  final String fechaCompra;
  final String proveedor;
  final double cantidad;
  final double precioCosto;
  final double precioVentaLote;
  final double margenLotePct;
  const EvolucionCosto({
    required this.producto,
    required this.fechaCompra,
    required this.proveedor,
    required this.cantidad,
    required this.precioCosto,
    required this.precioVentaLote,
    required this.margenLotePct,
  });
}

class HistorialMargenView {
  final int id;
  final String fecha;
  final String producto;
  final String categoria;
  final double margenPctAntes;
  final double margenPctDespues;
  final double precioAntes;
  final double precioDespues;
  final double diferenciaPrecio;
  final String motivo;
  const HistorialMargenView({
    required this.id,
    required this.fecha,
    required this.producto,
    required this.categoria,
    required this.margenPctAntes,
    required this.margenPctDespues,
    required this.precioAntes,
    required this.precioDespues,
    required this.diferenciaPrecio,
    required this.motivo,
  });
}

class AjusteHistorial {
  final int id;
  final String fecha;
  final String producto;
  final String categoria;
  final String tipo;
  final double cantidad;
  final String motivo;
  final double stockAntes;
  final double stockDespues;
  const AjusteHistorial({
    required this.id,
    required this.fecha,
    required this.producto,
    required this.categoria,
    required this.tipo,
    required this.cantidad,
    required this.motivo,
    required this.stockAntes,
    required this.stockDespues,
  });
}

class GananciaPorVenta {
  final int ventaId;
  final String fecha;
  final String metodoPago;
  final double ingreso;
  final double costo;
  final double gananciaBruta;
  final double margenPct;
  const GananciaPorVenta({
    required this.ventaId,
    required this.fecha,
    required this.metodoPago,
    required this.ingreso,
    required this.costo,
    required this.gananciaBruta,
    required this.margenPct,
  });
}

class VentaDetalleView {
  final int id;
  final int ventaId;
  final int productoId;
  final String productoNombre;
  final int loteId;
  final double cantidad;
  final double precioVenta;
  final double precioCosto;
  final double subtotal;
  final double ganancia;
  const VentaDetalleView({
    required this.id,
    required this.ventaId,
    required this.productoId,
    required this.productoNombre,
    required this.loteId,
    required this.cantidad,
    required this.precioVenta,
    required this.precioCosto,
    required this.subtotal,
    required this.ganancia,
  });
}

class CompraDetalleView {
  final int id;
  final int compraId;
  final int productoId;
  final String productoNombre;
  final double cantidad;
  final double cantidadRestante;
  final double precioCosto;
  final double precioVentaLote;
  final double subtotal;
  const CompraDetalleView({
    required this.id,
    required this.compraId,
    required this.productoId,
    required this.productoNombre,
    required this.cantidad,
    required this.cantidadRestante,
    required this.precioCosto,
    required this.precioVentaLote,
    required this.subtotal,
  });
}

class HistorialMargenProducto {
  final int id;
  final String fecha;
  final double margenPctAntes;
  final double margenPctDespues;
  final double precioAntes;
  final double precioDespues;
  final double diferenciaPrecio;
  final String motivo;
  const HistorialMargenProducto({
    required this.id,
    required this.fecha,
    required this.margenPctAntes,
    required this.margenPctDespues,
    required this.precioAntes,
    required this.precioDespues,
    required this.diferenciaPrecio,
    required this.motivo,
  });
}

class AjusteProducto {
  final int id;
  final String fecha;
  final String tipo;
  final double cantidad;
  final String motivo;
  final double stockAntes;
  final double stockDespues;
  const AjusteProducto({
    required this.id,
    required this.fecha,
    required this.tipo,
    required this.cantidad,
    required this.motivo,
    required this.stockAntes,
    required this.stockDespues,
  });
}

class TopVendido {
  final String producto;
  final String categoria;
  final double unidadesVendidas;
  final double ingresos;
  final double costos;
  final double gananciaBruta;
  const TopVendido({
    required this.producto,
    required this.categoria,
    required this.unidadesVendidas,
    required this.ingresos,
    required this.costos,
    required this.gananciaBruta,
  });
}

class ProductoSinVentas {
  final String producto;
  final String categoria;
  final double stockActual;
  final double precioVenta;
  final double valorInventario;
  const ProductoSinVentas({
    required this.producto,
    required this.categoria,
    required this.stockActual,
    required this.precioVenta,
    required this.valorInventario,
  });
}

class KpiDiaSemana {
  final String diaSemana;
  final String orden;
  final int numVentas;
  final double ticketPromedio;
  final double ingresosTotal;
  final double gananciaTotal;
  const KpiDiaSemana({
    required this.diaSemana,
    required this.orden,
    required this.numVentas,
    required this.ticketPromedio,
    required this.ingresosTotal,
    required this.gananciaTotal,
  });
}

class KpiHoraPico {
  final String hora;
  final int numVentas;
  final double ingresos;
  final double ticketPromedio;
  const KpiHoraPico({
    required this.hora,
    required this.numVentas,
    required this.ingresos,
    required this.ticketPromedio,
  });
}

class KpiPerdida {
  final String motivo;
  final int numAjustes;
  final double unidadesPerdidas;
  final double unidadesRecuperadas;
  const KpiPerdida({
    required this.motivo,
    required this.numAjustes,
    required this.unidadesPerdidas,
    required this.unidadesRecuperadas,
  });
}

class AlertaPrecio {
  final int id;
  final String producto;
  final String categoria;
  final double margenPct;
  final double precioVentaActual;
  final double precioVentaCorrecto;
  final double diferencia;
  final String estado;
  const AlertaPrecio({
    required this.id,
    required this.producto,
    required this.categoria,
    required this.margenPct,
    required this.precioVentaActual,
    required this.precioVentaCorrecto,
    required this.diferencia,
    required this.estado,
  });
}

@DriftAccessor(tables: [
  Ventas,
  Productos,
  Categorias,
  Compras,
  CompraDetalles,
  Proveedores,
  VentaDetalles,
  AjustesInventario,
  HistorialMargenes,
])
class ViewsDao extends DatabaseAccessor<AppDatabase> with _$ViewsDaoMixin {
  ViewsDao(super.db);

  Stream<List<DashboardEntry>> watchDashboard() {
    return customSelect('SELECT * FROM v_dashboard', readsFrom: {ventas, productos, compras, compraDetalles, categorias}).watch().map((rows) {
      return rows.map((row) {
        return DashboardEntry(
          kpi: row.read<String?>('kpi') ?? 'Desconocido',
          valor: row.read<String?>('valor') ?? '0',
        );
      }).toList();
    });
  }

  Stream<List<LoteDisponible>> watchLotesDisponibles() {
    return customSelect('SELECT * FROM v_lotes_disponibles', readsFrom: {compraDetalles, compras, productos, proveedores}).watch().map((rows) {
      return rows.map((row) {
        return LoteDisponible(
          loteId: row.read<int>('lote_id'),
          producto: row.read<String?>('producto') ?? 'Desconocido',
          productoId: row.read<int>('producto_id'),
          fechaCompra: row.read<String?>('fecha_compra') ?? 'Desconocido',
          compraId: row.read<int>('compra_id'),
          proveedor: row.read<String?>('proveedor') ?? 'Desconocido',
          cantidadOriginal: row.read<double>('cantidad_original'),
          cantidadRestante: row.read<double>('cantidad_restante'),
          precioCosto: row.read<double>('precio_costo'),
          precioVentaLote: row.read<double>('precio_venta_lote'),
        );
      }).toList();
    });
  }

  Stream<List<LoteDisponible>> watchLotesDisponiblesByProducto(int productoId) {
    return customSelect(
      'SELECT * FROM v_lotes_disponibles WHERE producto_id = ?',
      variables: [Variable.withInt(productoId)],
      readsFrom: {compraDetalles, compras, productos, proveedores},
    ).watch().map((rows) {
      return rows.map((row) {
        return LoteDisponible(
          loteId: row.read<int>('lote_id'),
          producto: row.read<String?>('producto') ?? 'Desconocido',
          productoId: row.read<int>('producto_id'),
          fechaCompra: row.read<String?>('fecha_compra') ?? 'Desconocido',
          compraId: row.read<int>('compra_id'),
          proveedor: row.read<String?>('proveedor') ?? 'Desconocido',
          cantidadOriginal: row.read<double>('cantidad_original'),
          cantidadRestante: row.read<double>('cantidad_restante'),
          precioCosto: row.read<double>('precio_costo'),
          precioVentaLote: row.read<double>('precio_venta_lote'),
        );
      }).toList();
    });
  }

  Stream<List<StockAlerta>> watchStockAlertas() {
    return customSelect('SELECT * FROM v_stock_alertas', readsFrom: {productos, categorias}).watch().map((rows) {
      return rows.map((row) {
        return StockAlerta(
          id: row.read<int>('id'),
          producto: row.read<String?>('producto') ?? 'Desconocido',
          categoria: row.read<String?>('categoria') ?? 'Sin categoría',
          stockActual: row.read<double>('stock_actual'),
          stockMinimo: row.read<double>('stock_minimo'),
          precioVenta: row.read<double>('precio_venta'),
          estadoStock: row.read<String?>('estado_stock') ?? 'OK',
        );
      }).toList();
    });
  }

  Stream<List<ReposicionEntry>> watchReposicion() {
    return customSelect('SELECT * FROM v_reposicion', readsFrom: {productos, categorias}).watch().map((rows) {
      return rows.map((row) {
        return ReposicionEntry(
          id: row.read<int>('id'),
          producto: row.read<String?>('producto') ?? 'Desconocido',
          categoria: row.read<String?>('categoria') ?? 'Sin categoría',
          stockActual: row.read<double>('stock_actual'),
          stockMinimo: row.read<double>('stock_minimo'),
          faltante: row.read<double>('faltante'),
        );
      }).toList();
    });
  }

  Stream<List<AlertaPrecio>> watchAlertasPrecio() {
    return customSelect('SELECT * FROM v_alertas_precio', readsFrom: {productos, categorias, compraDetalles}).watch().map((rows) {
      return rows.map((row) {
        return AlertaPrecio(
          id: row.read<int>('id'),
          producto: row.read<String?>('producto') ?? 'Desconocido',
          categoria: row.read<String?>('categoria') ?? 'Sin categoría',
          margenPct: row.read<double>('margen_pct'),
          precioVentaActual: row.read<double>('precio_venta_actual'),
          precioVentaCorrecto: row.read<double>('precio_venta_correcto'),
          diferencia: row.read<double>('diferencia'),
          estado: row.read<String?>('estado') ?? 'OK',
        );
      }).toList();
    });
  }

  Stream<List<KpiDiario>> watchKpiDiario() {
    return customSelect('SELECT * FROM v_kpi_diario', readsFrom: {ventas}).watch().map((rows) {
      return rows.map((row) {
        return KpiDiario(
          dia: row.read<String?>('dia') ?? 'Desconocido',
          numVentas: row.read<int>('num_ventas'),
          ingresos: row.read<double>('ingresos'),
          costos: row.read<double>('costos'),
          gananciaBruta: row.read<double>('ganancia_bruta'),
          gananciaBrutaPromedio: row.read<double>('ganancia_bruta_promedio'),
        );
      }).toList();
    });
  }

  Stream<List<KpiSemanal>> watchKpiSemanal() {
    return customSelect('SELECT * FROM v_kpi_semanal', readsFrom: {ventas}).watch().map((rows) {
      return rows.map((row) {
        return KpiSemanal(
          semana: row.read<String?>('semana') ?? 'Desconocido',
          numVentas: row.read<int>('num_ventas'),
          ingresos: row.read<double>('ingresos'),
          costos: row.read<double>('costos'),
          gananciaBruta: row.read<double>('ganancia_bruta'),
          ticketPromedio: row.read<double>('ticket_promedio'),
        );
      }).toList();
    });
  }

  Stream<List<KpiMensual>> watchKpiMensual() {
    return customSelect('SELECT * FROM v_kpi_mensual', readsFrom: {ventas}).watch().map((rows) {
      return rows.map((row) {
        return KpiMensual(
          mes: row.read<String?>('mes') ?? 'Desconocido',
          numVentas: row.read<int>('num_ventas'),
          ingresos: row.read<double>('ingresos'),
          costos: row.read<double>('costos'),
          gananciaBruta: row.read<double>('ganancia_bruta'),
          totalEfectivo: row.read<double>('total_efectivo'),
          totalTarjeta: row.read<double>('total_tarjeta'),
          totalTransferencia: row.read<double>('total_transferencia'),
        );
      }).toList();
    });
  }

  Stream<List<KpiMargenProducto>> watchKpiMargenProducto() {
    return customSelect('SELECT * FROM v_kpi_margen_producto', readsFrom: {ventaDetalles, productos, categorias}).watch().map((rows) {
      return rows.map((row) {
        return KpiMargenProducto(
          productoId: row.read<int>('producto_id'),
          producto: row.read<String?>('producto') ?? 'Desconocido',
          categoria: row.read<String?>('categoria') ?? 'Sin categoría',
          numVentas: row.read<int>('num_ventas'),
          unidadesVendidas: row.read<double>('unidades_vendidas'),
          ingresosTotal: row.read<double>('ingresos_total'),
          costoTotal: row.read<double>('costo_total'),
          gananciaBruta: row.read<double>('ganancia_bruta'),
          margenPct: row.read<double>('margen_pct'),
        );
      }).toList();
    });
  }

  Stream<List<KpiMetodoPago>> watchKpiMetodoPago() {
    return customSelect('SELECT * FROM v_kpi_metodo_pago', readsFrom: {ventas}).watch().map((rows) {
      return rows.map((row) {
        return KpiMetodoPago(
          metodoPago: row.read<String?>('metodo_pago') ?? 'Desconocido',
          numVentas: row.read<int>('num_ventas'),
          totalCobrado: row.read<double>('total_cobrado'),
          ticketPromedio: row.read<double>('ticket_promedio'),
        );
      }).toList();
    });
  }

  Stream<List<KpiPorCategoria>> watchKpiPorCategoria() {
    return customSelect('SELECT * FROM v_kpi_por_categoria', readsFrom: {ventaDetalles, productos, categorias}).watch().map((rows) {
      return rows.map((row) {
        return KpiPorCategoria(
          categoria: row.read<String?>('categoria') ?? 'Sin categoría',
          numTransacciones: row.read<int>('num_transacciones'),
          unidadesVendidas: row.read<double>('unidades_vendidas'),
          ingresos: row.read<double>('ingresos'),
          costos: row.read<double>('costos'),
          gananciaBruta: row.read<double>('ganancia_bruta'),
          margenPct: row.read<double>('margen_pct'),
        );
      }).toList();
    });
  }

  Stream<List<KpiPorProveedor>> watchKpiPorProveedor() {
    return customSelect('SELECT * FROM v_kpi_por_proveedor', readsFrom: {compras, proveedores}).watch().map((rows) {
      return rows.map((row) {
        return KpiPorProveedor(
          proveedor: row.read<String?>('proveedor') ?? 'Desconocido',
          numCompras: row.read<int>('num_compras'),
          totalComprado: row.read<double>('total_comprado'),
          promedioPorCompra: row.read<double>('promedio_por_compra'),
          primeraCompra: row.read<String?>('primera_compra') ?? 'Desconocido',
          ultimaCompra: row.read<String?>('ultima_compra') ?? 'Desconocido',
        );
      }).toList();
    });
  }

  Stream<List<ValorInventario>> watchValorInventario() {
    return customSelect('SELECT * FROM v_valor_inventario', readsFrom: {productos, categorias, compraDetalles}).watch().map((rows) {
      return rows.map((row) {
        return ValorInventario(
          producto: row.read<String?>('producto') ?? 'Desconocido',
          categoria: row.read<String?>('categoria') ?? 'Sin categoría',
          stockActual: row.read<double>('stock_actual'),
          costoPromedio: row.read<double>('costo_promedio'),
          precioVenta: row.read<double>('precio_venta'),
          valorACosto: row.read<double>('valor_a_costo'),
          valorAVenta: row.read<double>('valor_a_venta'),
          gananciaPotencial: row.read<double>('ganancia_potencial'),
        );
      }).toList();
    });
  }

  Stream<List<CapitalInmovilizado>> watchCapitalInmovilizado() {
    return customSelect('SELECT * FROM v_capital_inmovilizado', readsFrom: {compraDetalles, productos, categorias}).watch().map((rows) {
      return rows.map((row) {
        return CapitalInmovilizado(
          producto: row.read<String?>('producto') ?? 'Desconocido',
          categoria: row.read<String?>('categoria') ?? 'Sin categoría',
          lotesActivos: row.read<int>('lotes_activos'),
          unidadesSinVender: row.read<double>('unidades_sin_vender'),
          capitalInmovilizado: row.read<double>('capital_inmovilizado'),
          valorPotencialVenta: row.read<double>('valor_potencial_venta'),
        );
      }).toList();
    });
  }

  Stream<List<EficienciaLote>> watchEficienciaLotes() {
    return customSelect('SELECT * FROM v_eficiencia_lotes', readsFrom: {compraDetalles, compras, productos, proveedores}).watch().map((rows) {
      return rows.map((row) {
        return EficienciaLote(
          producto: row.read<String?>('producto') ?? 'Desconocido',
          loteId: row.read<int>('lote_id'),
          fechaCompra: row.read<String?>('fecha_compra') ?? 'Desconocido',
          proveedor: row.read<String?>('proveedor') ?? 'Desconocido',
          comprado: row.read<double>('comprado'),
          vendido: row.read<double>('vendido'),
          disponible: row.read<double>('disponible'),
          pctVendido: row.read<double>('pct_vendido'),
          estado: row.read<String?>('estado') ?? 'Desconocido',
        );
      }).toList();
    });
  }

  Stream<List<EvolucionCosto>> watchEvolucionCostos() {
    return customSelect('SELECT * FROM v_evolucion_costos', readsFrom: {compraDetalles, compras, productos, proveedores}).watch().map((rows) {
      return rows.map((row) {
        return EvolucionCosto(
          producto: row.read<String?>('producto') ?? 'Desconocido',
          fechaCompra: row.read<String?>('fecha_compra') ?? 'Desconocido',
          proveedor: row.read<String?>('proveedor') ?? 'Desconocido',
          cantidad: row.read<double>('cantidad'),
          precioCosto: row.read<double>('precio_costo'),
          precioVentaLote: row.read<double>('precio_venta_lote'),
          margenLotePct: row.read<double>('margen_lote_pct'),
        );
      }).toList();
    });
  }

  Stream<List<HistorialMargenView>> watchHistorialMargenes() {
    return customSelect('SELECT * FROM v_historial_margenes', readsFrom: {historialMargenes, productos, categorias}).watch().map((rows) {
      return rows.map((row) {
        return HistorialMargenView(
          id: row.read<int>('id'),
          fecha: row.read<String?>('fecha') ?? 'Desconocido',
          producto: row.read<String?>('producto') ?? 'Desconocido',
          categoria: row.read<String?>('categoria') ?? 'Sin categoría',
          margenPctAntes: row.read<double>('margen_pct_antes'),
          margenPctDespues: row.read<double>('margen_pct_despues'),
          precioAntes: row.read<double>('precio_antes'),
          precioDespues: row.read<double>('precio_despues'),
          diferenciaPrecio: row.read<double>('diferencia_precio'),
          motivo: row.read<String?>('motivo') ?? 'Desconocido',
        );
      }).toList();
    });
  }

  Stream<List<AjusteHistorial>> watchAjustesHistorial() {
    return customSelect('SELECT * FROM v_ajustes_historial', readsFrom: {ajustesInventario, productos, categorias}).watch().map((rows) {
      return rows.map((row) {
        return AjusteHistorial(
          id: row.read<int>('id'),
          fecha: row.read<String?>('fecha') ?? 'Desconocido',
          producto: row.read<String?>('producto') ?? 'Desconocido',
          categoria: row.read<String?>('categoria') ?? 'Sin categoría',
          tipo: row.read<String?>('tipo') ?? 'Desconocido',
          cantidad: row.read<double>('cantidad'),
          motivo: row.read<String?>('motivo') ?? 'Desconocido',
          stockAntes: row.read<double>('stock_antes'),
          stockDespues: row.read<double>('stock_despues'),
        );
      }).toList();
    });
  }

  Stream<List<GananciaPorVenta>> watchGananciaPorVenta() {
    return customSelect('SELECT * FROM v_ganancia_por_venta', readsFrom: {ventas}).watch().map((rows) {
      return rows.map((row) {
        return GananciaPorVenta(
          ventaId: row.read<int>('venta_id'),
          fecha: row.read<String?>('fecha') ?? 'Desconocido',
          metodoPago: row.read<String?>('metodo_pago') ?? 'Desconocido',
          ingreso: row.read<double>('ingreso'),
          costo: row.read<double>('costo'),
          gananciaBruta: row.read<double>('ganancia_bruta'),
          margenPct: row.read<double>('margen_pct'),
        );
      }).toList();
    });
  }

  Stream<List<TopVendido>> watchTop10MasVendidos() {
    return customSelect('SELECT * FROM v_top10_mas_vendidos', readsFrom: {ventaDetalles, productos, categorias}).watch().map((rows) {
      return rows.map((row) {
        return TopVendido(
          producto: row.read<String?>('producto') ?? 'Desconocido',
          categoria: row.read<String?>('categoria') ?? 'Sin categoría',
          unidadesVendidas: row.read<double>('unidades_vendidas'),
          ingresos: row.read<double>('ingresos'),
          costos: row.read<double>('costos'),
          gananciaBruta: row.read<double>('ganancia_bruta'),
        );
      }).toList();
    });
  }

  Stream<List<TopVendido>> watchTop10MenosVendidos() {
    return customSelect('SELECT * FROM v_top10_menos_vendidos', readsFrom: {productos, categorias, ventaDetalles}).watch().map((rows) {
      return rows.map((row) {
        return TopVendido(
          producto: row.read<String?>('producto') ?? 'Desconocido',
          categoria: row.read<String?>('categoria') ?? 'Sin categoría',
          unidadesVendidas: row.read<double>('unidades_vendidas'),
          ingresos: 0,
          costos: 0,
          gananciaBruta: 0,
        );
      }).toList();
    });
  }

  Stream<List<ProductoSinVentas>> watchProductosSinVentas() {
    return customSelect('SELECT * FROM v_productos_sin_ventas', readsFrom: {productos, categorias, ventaDetalles}).watch().map((rows) {
      return rows.map((row) {
        return ProductoSinVentas(
          producto: row.read<String?>('producto') ?? 'Desconocido',
          categoria: row.read<String?>('categoria') ?? 'Sin categoría',
          stockActual: row.read<double>('stock_actual'),
          precioVenta: row.read<double>('precio_venta'),
          valorInventario: row.read<double>('valor_inventario'),
        );
      }).toList();
    });
  }

  Stream<List<DashboardEntry>> watchDashboardAyer() {
    return customSelect('''
      SELECT 'Ventas ayer' AS kpi, CAST(COUNT(*) AS TEXT) AS valor
      FROM ventas WHERE DATE(fecha) = DATE('now','localtime','-1 day')
      UNION ALL
      SELECT 'Ingresos ayer', CAST(ROUND(COALESCE(SUM(total),0),2) AS TEXT)
      FROM ventas WHERE DATE(fecha) = DATE('now','localtime','-1 day')
      UNION ALL
      SELECT 'Ganancia ayer', CAST(ROUND(COALESCE(SUM(total-costo_total),0),2) AS TEXT)
      FROM ventas WHERE DATE(fecha) = DATE('now','localtime','-1 day')
      UNION ALL
      SELECT 'Ventas mes ant', CAST(COUNT(*) AS TEXT)
      FROM ventas WHERE strftime('%Y-%m',fecha) = strftime('%Y-%m','now','localtime','-1 month')
      UNION ALL
      SELECT 'Ingresos mes ant', CAST(ROUND(COALESCE(SUM(total),0),2) AS TEXT)
      FROM ventas WHERE strftime('%Y-%m',fecha) = strftime('%Y-%m','now','localtime','-1 month')
      UNION ALL
      SELECT 'Ganancia mes ant', CAST(ROUND(COALESCE(SUM(total-costo_total),0),2) AS TEXT)
      FROM ventas WHERE strftime('%Y-%m',fecha) = strftime('%Y-%m','now','localtime','-1 month')
    ''', readsFrom: {ventas}).watch().map((rows) {
      return rows.map((row) {
        return DashboardEntry(
          kpi: row.read<String?>('kpi') ?? 'Desconocido',
          valor: row.read<String?>('valor') ?? '0',
        );
      }).toList();
    });
  }

  Stream<List<KpiDiaSemana>> watchKpiDiaSemana() {
    return customSelect('SELECT * FROM v_kpi_dia_semana', readsFrom: {ventas}).watch().map((rows) {
      return rows.map((row) {
        return KpiDiaSemana(
          diaSemana: row.read<String?>('dia_semana') ?? 'Desconocido',
          orden: row.read<String?>('orden') ?? '0',
          numVentas: row.read<int>('num_ventas'),
          ticketPromedio: row.read<double>('ticket_promedio'),
          ingresosTotal: row.read<double>('ingresos_total'),
          gananciaTotal: row.read<double>('ganancia_total'),
        );
      }).toList();
    });
  }

  Stream<List<KpiHoraPico>> watchKpiHoraPico() {
    return customSelect('SELECT * FROM v_kpi_hora_pico', readsFrom: {ventas}).watch().map((rows) {
      return rows.map((row) {
        return KpiHoraPico(
          hora: row.read<String?>('hora') ?? '00',
          numVentas: row.read<int>('num_ventas'),
          ingresos: row.read<double>('ingresos'),
          ticketPromedio: row.read<double>('ticket_promedio'),
        );
      }).toList();
    });
  }

  Stream<List<KpiPerdida>> watchKpiPerdidas() {
    return customSelect('SELECT * FROM v_kpi_perdidas', readsFrom: {ajustesInventario}).watch().map((rows) {
      return rows.map((row) {
        return KpiPerdida(
          motivo: row.read<String?>('motivo') ?? 'Desconocido',
          numAjustes: row.read<int>('num_ajustes'),
          unidadesPerdidas: row.read<double>('unidades_perdidas'),
          unidadesRecuperadas: row.read<double>('unidades_recuperadas'),
        );
      }).toList();
    });
  }

  Future<List<LoteDisponible>> getLotesDisponiblesByProducto(int productoId) async {
    final rows = await customSelect(
      'SELECT * FROM v_lotes_disponibles WHERE producto_id = ? ORDER BY fecha_compra ASC',
      variables: [Variable.withInt(productoId)],
    ).get();
    return rows.map((row) {
      return LoteDisponible(
        loteId: row.read<int>('lote_id'),
        producto: row.read<String?>('producto') ?? 'Desconocido',
        productoId: row.read<int>('producto_id'),
        fechaCompra: row.read<String?>('fecha_compra') ?? 'Desconocido',
        compraId: row.read<int>('compra_id'),
        proveedor: row.read<String?>('proveedor') ?? 'Desconocido',
        cantidadOriginal: row.read<double>('cantidad_original'),
        cantidadRestante: row.read<double>('cantidad_restante'),
        precioCosto: row.read<double>('precio_costo'),
        precioVentaLote: row.read<double>('precio_venta_lote'),
      );
    }).toList();
  }

  Future<double> getStockDisponibleByProducto(int productoId) async {
    final result = await customSelect(
      'SELECT COALESCE(SUM(cantidad_restante), 0) as total FROM v_lotes_disponibles WHERE producto_id = ?',
      variables: [Variable.withInt(productoId)],
    ).getSingle();
    return result.read<double>('total');
  }

  Stream<List<VentaDetalleView>> watchVentaDetallesView(int ventaId) {
    return customSelect(
      '''SELECT vd.id, vd.venta_id, vd.producto_id, p.nombre AS producto_nombre,
                vd.lote_id, vd.cantidad, vd.precio_venta, vd.precio_costo,
                ROUND(vd.cantidad * vd.precio_venta, 2) AS subtotal,
                ROUND(vd.cantidad * (vd.precio_venta - vd.precio_costo), 2) AS ganancia
         FROM venta_detalles vd
         JOIN productos p ON p.id = vd.producto_id
         WHERE vd.venta_id = ?
         ORDER BY vd.id ASC''',
      variables: [Variable.withInt(ventaId)],
      readsFrom: {ventaDetalles, productos},
    ).watch().map((rows) {
      return rows.map((row) {
        return VentaDetalleView(
          id: row.read<int>('id'),
          ventaId: row.read<int>('venta_id'),
          productoId: row.read<int>('producto_id'),
          productoNombre: row.read<String?>('producto_nombre') ?? 'Desconocido',
          loteId: row.read<int>('lote_id'),
          cantidad: row.read<double>('cantidad'),
          precioVenta: row.read<double>('precio_venta'),
          precioCosto: row.read<double>('precio_costo'),
          subtotal: row.read<double>('subtotal'),
          ganancia: row.read<double>('ganancia'),
        );
      }).toList();
    });
  }

  Stream<List<CompraDetalleView>> watchCompraDetallesView(int compraId) {
    return customSelect(
      '''SELECT cd.id, cd.compra_id, cd.producto_id, p.nombre AS producto_nombre,
                cd.cantidad, cd.cantidad_restante, cd.precio_costo, cd.precio_venta_lote,
                ROUND(cd.cantidad * cd.precio_costo, 2) AS subtotal
         FROM compra_detalles cd
         JOIN productos p ON p.id = cd.producto_id
         WHERE cd.compra_id = ?
         ORDER BY cd.id ASC''',
      variables: [Variable.withInt(compraId)],
      readsFrom: {compraDetalles, productos},
    ).watch().map((rows) {
      return rows.map((row) {
        return CompraDetalleView(
          id: row.read<int>('id'),
          compraId: row.read<int>('compra_id'),
          productoId: row.read<int>('producto_id'),
          productoNombre: row.read<String?>('producto_nombre') ?? 'Desconocido',
          cantidad: row.read<double>('cantidad'),
          cantidadRestante: row.read<double>('cantidad_restante'),
          precioCosto: row.read<double>('precio_costo'),
          precioVentaLote: row.read<double>('precio_venta_lote'),
          subtotal: row.read<double>('subtotal'),
        );
      }).toList();
    });
  }

  Stream<List<HistorialMargenProducto>> watchHistorialMargenesByProducto(int productoId) {
    return customSelect(
      '''SELECT hm.id, hm.fecha,
                hm.margen_anterior AS margen_pct_antes,
                hm.margen_nuevo AS margen_pct_despues,
                hm.precio_venta_anterior AS precio_antes,
                hm.precio_venta_nuevo AS precio_despues,
                ROUND(hm.precio_venta_nuevo - hm.precio_venta_anterior, 2) AS diferencia_precio,
                COALESCE(hm.motivo, '(sin motivo)') AS motivo
         FROM historial_margenes hm
         WHERE hm.producto_id = ?
         ORDER BY hm.fecha DESC
         LIMIT 20''',
      variables: [Variable.withInt(productoId)],
      readsFrom: {historialMargenes},
    ).watch().map((rows) {
      return rows.map((row) {
        return HistorialMargenProducto(
          id: row.read<int>('id'),
          fecha: row.read<String?>('fecha') ?? '',
          margenPctAntes: row.read<double>('margen_pct_antes'),
          margenPctDespues: row.read<double>('margen_pct_despues'),
          precioAntes: row.read<double>('precio_antes'),
          precioDespues: row.read<double>('precio_despues'),
          diferenciaPrecio: row.read<double>('diferencia_precio'),
          motivo: row.read<String?>('motivo') ?? '',
        );
      }).toList();
    });
  }

  Stream<List<AjusteProducto>> watchAjustesByProducto(int productoId) {
    return customSelect(
      '''SELECT ai.id, ai.fecha, ai.tipo, ai.cantidad, ai.motivo,
                ai.stock_antes, ai.stock_despues
         FROM ajustes_inventario ai
         WHERE ai.producto_id = ?
         ORDER BY ai.fecha DESC
         LIMIT 20''',
      variables: [Variable.withInt(productoId)],
      readsFrom: {ajustesInventario},
    ).watch().map((rows) {
      return rows.map((row) {
        return AjusteProducto(
          id: row.read<int>('id'),
          fecha: row.read<String?>('fecha') ?? '',
          tipo: row.read<String?>('tipo') ?? '',
          cantidad: row.read<double>('cantidad'),
          motivo: row.read<String?>('motivo') ?? '',
          stockAntes: row.read<double>('stock_antes'),
          stockDespues: row.read<double>('stock_despues'),
        );
      }).toList();
    });
  }
}
