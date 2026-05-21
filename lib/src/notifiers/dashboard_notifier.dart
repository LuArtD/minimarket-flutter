import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../dao/views_dao.dart';

part 'dashboard_notifier.g.dart';

class DashboardState {
  final Map<String, String> kpis;
  final Map<String, String> kpisAyer;
  final List<StockAlerta> alertasStock;
  final List<KpiDiario> kpiDiario;
  final List<KpiMetodoPago> metodoPago;
  final List<TopVendido> topVendidos;
  final List<ReposicionEntry> reposicion;

  const DashboardState({
    this.kpis = const {},
    this.kpisAyer = const {},
    this.alertasStock = const [],
    this.kpiDiario = const [],
    this.metodoPago = const [],
    this.topVendidos = const [],
    this.reposicion = const [],
  });

  DashboardState copyWith({
    Map<String, String>? kpis,
    Map<String, String>? kpisAyer,
    List<StockAlerta>? alertasStock,
    List<KpiDiario>? kpiDiario,
    List<KpiMetodoPago>? metodoPago,
    List<TopVendido>? topVendidos,
    List<ReposicionEntry>? reposicion,
  }) {
    return DashboardState(
      kpis: kpis ?? this.kpis,
      kpisAyer: kpisAyer ?? this.kpisAyer,
      alertasStock: alertasStock ?? this.alertasStock,
      kpiDiario: kpiDiario ?? this.kpiDiario,
      metodoPago: metodoPago ?? this.metodoPago,
      topVendidos: topVendidos ?? this.topVendidos,
      reposicion: reposicion ?? this.reposicion,
    );
  }
}

@riverpod
class DashboardNotifier extends _$DashboardNotifier {
  @override
  DashboardState build() {
    return const DashboardState();
  }

  void updateKpis(Map<String, String> kpis) {
    state = state.copyWith(kpis: kpis);
  }

  void updateKpisAyer(Map<String, String> kpisAyer) {
    state = state.copyWith(kpisAyer: kpisAyer);
  }

  void updateAlertas(List<StockAlerta> alertas) {
    state = state.copyWith(alertasStock: alertas);
  }

  void updateKpiDiario(List<KpiDiario> data) {
    state = state.copyWith(kpiDiario: data.take(7).toList());
  }

  void updateMetodoPago(List<KpiMetodoPago> data) {
    state = state.copyWith(metodoPago: data);
  }

  void updateTopVendidos(List<TopVendido> data) {
    state = state.copyWith(topVendidos: data.take(5).toList());
  }

  void updateReposicion(List<ReposicionEntry> data) {
    state = state.copyWith(reposicion: data);
  }
}
