import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'ventas_notifier.g.dart';

class VentasState {
  final DateTime fechaInicio;
  final DateTime fechaFin;
  final String? filtroMetodoPago;

  VentasState({
    DateTime? fechaInicio,
    DateTime? fechaFin,
    this.filtroMetodoPago,
  })  : fechaInicio = fechaInicio ?? DateTime.now().subtract(const Duration(days: 7)),
        fechaFin = fechaFin ?? DateTime.now();

  VentasState copyWith({DateTime? fechaInicio, DateTime? fechaFin, String? filtroMetodoPago}) {
    return VentasState(
      fechaInicio: fechaInicio ?? this.fechaInicio,
      fechaFin: fechaFin ?? this.fechaFin,
      filtroMetodoPago: filtroMetodoPago ?? this.filtroMetodoPago,
    );
  }

  String get fechaInicioStr => '${fechaInicio.year}-${fechaInicio.month.toString().padLeft(2, '0')}-${fechaInicio.day.toString().padLeft(2, '0')}T00:00:00';
  String get fechaFinStr => '${fechaFin.year}-${fechaFin.month.toString().padLeft(2, '0')}-${fechaFin.day.toString().padLeft(2, '0')}T23:59:59';
}

@riverpod
class VentasNotifier extends _$VentasNotifier {
  @override
  VentasState build() {
    return VentasState();
  }

  void setFechaRange(DateTime inicio, DateTime fin) {
    state = state.copyWith(fechaInicio: inicio, fechaFin: fin);
  }

  void setMetodoPago(String? metodo) {
    state = state.copyWith(filtroMetodoPago: metodo);
  }
}
