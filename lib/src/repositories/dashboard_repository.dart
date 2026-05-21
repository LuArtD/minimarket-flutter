import '../dao/views_dao.dart';

class DashboardRepository {
  final ViewsDao _viewsDao;

  DashboardRepository(this._viewsDao);

  Stream<List<DashboardEntry>> watchDashboard() {
    return _viewsDao.watchDashboard();
  }

  Stream<List<LoteDisponible>> watchLotesDisponibles() {
    return _viewsDao.watchLotesDisponibles();
  }

  Stream<List<LoteDisponible>> watchLotesDisponiblesByProducto(int productoId) {
    return _viewsDao.watchLotesDisponiblesByProducto(productoId);
  }

  Stream<List<StockAlerta>> watchStockAlertas() {
    return _viewsDao.watchStockAlertas();
  }

  Stream<List<ReposicionEntry>> watchReposicion() {
    return _viewsDao.watchReposicion();
  }

  Stream<List<AlertaPrecio>> watchAlertasPrecio() {
    return _viewsDao.watchAlertasPrecio();
  }

  Stream<List<KpiDiario>> watchKpiDiario() {
    return _viewsDao.watchKpiDiario();
  }

  Stream<List<KpiSemanal>> watchKpiSemanal() {
    return _viewsDao.watchKpiSemanal();
  }

  Stream<List<KpiMensual>> watchKpiMensual() {
    return _viewsDao.watchKpiMensual();
  }

  Stream<List<KpiMargenProducto>> watchKpiMargenProducto() {
    return _viewsDao.watchKpiMargenProducto();
  }

  Stream<List<KpiMetodoPago>> watchKpiMetodoPago() {
    return _viewsDao.watchKpiMetodoPago();
  }

  Stream<List<KpiPorCategoria>> watchKpiPorCategoria() {
    return _viewsDao.watchKpiPorCategoria();
  }

  Stream<List<KpiPorProveedor>> watchKpiPorProveedor() {
    return _viewsDao.watchKpiPorProveedor();
  }

  Stream<List<ValorInventario>> watchValorInventario() {
    return _viewsDao.watchValorInventario();
  }

  Stream<List<CapitalInmovilizado>> watchCapitalInmovilizado() {
    return _viewsDao.watchCapitalInmovilizado();
  }

  Stream<List<EficienciaLote>> watchEficienciaLotes() {
    return _viewsDao.watchEficienciaLotes();
  }

  Stream<List<EvolucionCosto>> watchEvolucionCostos() {
    return _viewsDao.watchEvolucionCostos();
  }

  Stream<List<HistorialMargenView>> watchHistorialMargenes() {
    return _viewsDao.watchHistorialMargenes();
  }

  Stream<List<AjusteHistorial>> watchAjustesHistorial() {
    return _viewsDao.watchAjustesHistorial();
  }

  Stream<List<GananciaPorVenta>> watchGananciaPorVenta() {
    return _viewsDao.watchGananciaPorVenta();
  }

  Stream<List<TopVendido>> watchTop10MasVendidos() {
    return _viewsDao.watchTop10MasVendidos();
  }

  Stream<List<TopVendido>> watchTop10MenosVendidos() {
    return _viewsDao.watchTop10MenosVendidos();
  }

  Stream<List<ProductoSinVentas>> watchProductosSinVentas() {
    return _viewsDao.watchProductosSinVentas();
  }

  Stream<List<KpiDiaSemana>> watchKpiDiaSemana() {
    return _viewsDao.watchKpiDiaSemana();
  }

  Stream<List<KpiHoraPico>> watchKpiHoraPico() {
    return _viewsDao.watchKpiHoraPico();
  }

  Stream<List<KpiPerdida>> watchKpiPerdidas() {
    return _viewsDao.watchKpiPerdidas();
  }
}
