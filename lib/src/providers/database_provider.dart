import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../dao/ajustes_inventario_dao.dart';
import '../dao/categorias_dao.dart';
import '../dao/compra_detalles_dao.dart';
import '../dao/compras_dao.dart';
import '../dao/historial_margenes_dao.dart';
import '../dao/productos_dao.dart';
import '../dao/proveedores_dao.dart';
import '../dao/venta_detalles_dao.dart';
import '../dao/ventas_dao.dart';
import '../dao/views_dao.dart';
import '../database/app_database.dart';
import '../notifiers/productos_notifier.dart';
import '../notifiers/ventas_notifier.dart';
import '../repositories/ajustes_inventario_repository.dart';
import '../repositories/categorias_repository.dart';
import '../repositories/compras_repository.dart';
import '../repositories/dashboard_repository.dart';
import '../repositories/productos_repository.dart';
import '../repositories/proveedores_repository.dart';
import '../repositories/ventas_repository.dart';
import '../services/fifo_service.dart';

part 'database_provider.g.dart';

@Riverpod(keepAlive: true)
class StockUpdateCounter extends _$StockUpdateCounter {
  @override
  int build() => 0;

  void notify() => state++;
}

@riverpod
AppDatabase appDatabase(AppDatabaseRef ref) {
  throw UnimplementedError('Database must be provided via ProviderScope override');
}

@riverpod
CategoriasDao categoriasDao(CategoriasDaoRef ref) {
  return CategoriasDao(ref.watch(appDatabaseProvider));
}

@riverpod
ProveedoresDao proveedoresDao(ProveedoresDaoRef ref) {
  return ProveedoresDao(ref.watch(appDatabaseProvider));
}

@riverpod
ProductosDao productosDao(ProductosDaoRef ref) {
  return ProductosDao(ref.watch(appDatabaseProvider));
}

@riverpod
ComprasDao comprasDao(ComprasDaoRef ref) {
  return ComprasDao(ref.watch(appDatabaseProvider));
}

@riverpod
CompraDetallesDao compraDetallesDao(CompraDetallesDaoRef ref) {
  return CompraDetallesDao(ref.watch(appDatabaseProvider));
}

@riverpod
VentasDao ventasDao(VentasDaoRef ref) {
  return VentasDao(ref.watch(appDatabaseProvider));
}

@riverpod
VentaDetallesDao ventaDetallesDao(VentaDetallesDaoRef ref) {
  return VentaDetallesDao(ref.watch(appDatabaseProvider));
}

@riverpod
AjustesInventarioDao ajustesInventarioDao(AjustesInventarioDaoRef ref) {
  return AjustesInventarioDao(ref.watch(appDatabaseProvider));
}

@riverpod
HistorialMargenesDao historialMargenesDao(HistorialMargenesDaoRef ref) {
  return HistorialMargenesDao(ref.watch(appDatabaseProvider));
}

@riverpod
ViewsDao viewsDao(ViewsDaoRef ref) {
  return ViewsDao(ref.watch(appDatabaseProvider));
}

@riverpod
FifoService fifoService(FifoServiceRef ref) {
  return FifoService();
}

@riverpod
CategoriasRepository categoriasRepository(CategoriasRepositoryRef ref) {
  return CategoriasRepository(ref.watch(categoriasDaoProvider));
}

@riverpod
ProveedoresRepository proveedoresRepository(ProveedoresRepositoryRef ref) {
  return ProveedoresRepository(ref.watch(proveedoresDaoProvider));
}

@riverpod
ProductosRepository productosRepository(ProductosRepositoryRef ref) {
  return ProductosRepository(
    ref.watch(productosDaoProvider),
    ref.watch(viewsDaoProvider),
  );
}

@riverpod
ComprasRepository comprasRepository(ComprasRepositoryRef ref) {
  return ComprasRepository(
    ref.watch(comprasDaoProvider),
    ref.watch(compraDetallesDaoProvider),
    ref.watch(appDatabaseProvider),
  );
}

@riverpod
VentasRepository ventasRepository(VentasRepositoryRef ref) {
  return VentasRepository(
    ref.watch(ventasDaoProvider),
    ref.watch(ventaDetallesDaoProvider),
    ref.watch(viewsDaoProvider),
    ref.watch(fifoServiceProvider),
    ref.watch(appDatabaseProvider),
  );
}

@riverpod
AjustesInventarioRepository ajustesInventarioRepository(AjustesInventarioRepositoryRef ref) {
  return AjustesInventarioRepository(
    ref.watch(ajustesInventarioDaoProvider),
    ref.watch(productosDaoProvider),
  );
}

@riverpod
DashboardRepository dashboardRepository(DashboardRepositoryRef ref) {
  return DashboardRepository(ref.watch(viewsDaoProvider));
}

@riverpod
Stream<List<Compra>> comprasStream(ComprasStreamRef ref) {
  return ref.watch(comprasRepositoryProvider).watchAll();
}

@riverpod
Stream<List<Proveedore>> proveedoresStream(ProveedoresStreamRef ref) {
  return ref.watch(proveedoresRepositoryProvider).watchAll(soloActivos: false);
}

@riverpod
Stream<List<Venta>> ventasStream(VentasStreamRef ref) {
  final state = ref.watch(ventasNotifierProvider);
  return ref.watch(ventasRepositoryProvider).watchByFecha(state.fechaInicioStr, state.fechaFinStr);
}

@riverpod
Stream<List<Producto>> productosStream(ProductosStreamRef ref) {
  ref.watch(productosNotifierProvider);
  ref.watch(stockUpdateCounterProvider);
  return ref.watch(productosRepositoryProvider).watchAll();
}

@riverpod
Stream<List<Categoria>> categoriasStream(CategoriasStreamRef ref) {
  return ref.watch(categoriasRepositoryProvider).watchAll(soloActivas: false);
}

@riverpod
Stream<List<AjustesInventarioData>> ajustesStream(AjustesStreamRef ref) {
  return ref.watch(ajustesInventarioRepositoryProvider).watchAll();
}

@riverpod
Stream<List<ReposicionEntry>> reposicionStream(ReposicionStreamRef ref) {
  ref.watch(stockUpdateCounterProvider);
  return ref.watch(dashboardRepositoryProvider).watchReposicion();
}

@riverpod
Stream<List<KpiDiario>> kpiDiarioStream(KpiDiarioStreamRef ref) {
  ref.watch(stockUpdateCounterProvider);
  return ref.watch(dashboardRepositoryProvider).watchKpiDiario();
}

@riverpod
Stream<List<KpiSemanal>> kpiSemanalStream(KpiSemanalStreamRef ref) {
  ref.watch(stockUpdateCounterProvider);
  return ref.watch(dashboardRepositoryProvider).watchKpiSemanal();
}

@riverpod
Stream<List<KpiMensual>> kpiMensualStream(KpiMensualStreamRef ref) {
  ref.watch(stockUpdateCounterProvider);
  return ref.watch(dashboardRepositoryProvider).watchKpiMensual();
}

@riverpod
Stream<List<KpiMargenProducto>> kpiMargenProductoStream(KpiMargenProductoStreamRef ref) {
  ref.watch(stockUpdateCounterProvider);
  return ref.watch(dashboardRepositoryProvider).watchKpiMargenProducto();
}

@riverpod
Stream<List<KpiPorCategoria>> kpiPorCategoriaStream(KpiPorCategoriaStreamRef ref) {
  ref.watch(stockUpdateCounterProvider);
  return ref.watch(dashboardRepositoryProvider).watchKpiPorCategoria();
}

@riverpod
Stream<List<KpiDiaSemana>> kpiDiaSemanaStream(KpiDiaSemanaStreamRef ref) {
  ref.watch(stockUpdateCounterProvider);
  return ref.watch(dashboardRepositoryProvider).watchKpiDiaSemana();
}

@riverpod
Stream<List<KpiHoraPico>> kpiHoraPicoStream(KpiHoraPicoStreamRef ref) {
  ref.watch(stockUpdateCounterProvider);
  return ref.watch(dashboardRepositoryProvider).watchKpiHoraPico();
}

@riverpod
Stream<List<KpiMetodoPago>> kpiMetodoPagoStream(KpiMetodoPagoStreamRef ref) {
  ref.watch(stockUpdateCounterProvider);
  return ref.watch(dashboardRepositoryProvider).watchKpiMetodoPago();
}

@riverpod
Stream<List<TopVendido>> topMasVendidosStream(TopMasVendidosStreamRef ref) {
  ref.watch(stockUpdateCounterProvider);
  return ref.watch(dashboardRepositoryProvider).watchTop10MasVendidos();
}

@riverpod
Stream<List<DashboardEntry>> dashboardAyerStream(DashboardAyerStreamRef ref) {
  ref.watch(stockUpdateCounterProvider);
  return ref.watch(dashboardRepositoryProvider).watchDashboardAyer();
}

