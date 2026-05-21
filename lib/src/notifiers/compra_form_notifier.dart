import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/result.dart';
import '../providers/database_provider.dart';
import '../repositories/compras_repository.dart';

part 'compra_form_notifier.g.dart';

class CompraDetalleItem {
  final int productoId;
  final String nombre;
  final double cantidad;
  final double precioCosto;

  const CompraDetalleItem({
    required this.productoId,
    required this.nombre,
    required this.cantidad,
    required this.precioCosto,
  });

  double get subtotal => cantidad * precioCosto;

  CompraDetalleItem copyWith({double? cantidad, double? precioCosto}) {
    return CompraDetalleItem(
      productoId: productoId,
      nombre: nombre,
      cantidad: cantidad ?? this.cantidad,
      precioCosto: precioCosto ?? this.precioCosto,
    );
  }
}

class CompraFormState {
  final int? proveedorId;
  final String? nroFactura;
  final List<CompraDetalleItem> detalles;
  final AsyncValue<void> submitState;

  const CompraFormState({
    this.proveedorId,
    this.nroFactura,
    this.detalles = const [],
    this.submitState = const AsyncData(null),
  });

  double get total => detalles.fold(0, (sum, d) => sum + d.subtotal);

  CompraFormState copyWith({
    int? proveedorId,
    String? nroFactura,
    List<CompraDetalleItem>? detalles,
    AsyncValue<void>? submitState,
  }) {
    return CompraFormState(
      proveedorId: proveedorId ?? this.proveedorId,
      nroFactura: nroFactura ?? this.nroFactura,
      detalles: detalles ?? this.detalles,
      submitState: submitState ?? this.submitState,
    );
  }
}

@riverpod
class CompraFormNotifier extends _$CompraFormNotifier {
  @override
  CompraFormState build() {
    return const CompraFormState();
  }

  void setProveedor(int id) {
    state = state.copyWith(proveedorId: id);
  }

  void setNroFactura(String? value) {
    state = state.copyWith(nroFactura: value);
  }

  void addProducto(int productoId, String nombre) {
    final existing = state.detalles.indexWhere((d) => d.productoId == productoId);
    if (existing >= 0) {
      final updated = List<CompraDetalleItem>.from(state.detalles);
      updated[existing] = updated[existing].copyWith(cantidad: updated[existing].cantidad + 1);
      state = state.copyWith(detalles: updated);
    } else {
      state = state.copyWith(
        detalles: [
          ...state.detalles,
          CompraDetalleItem(productoId: productoId, nombre: nombre, cantidad: 1, precioCosto: 0),
        ],
      );
    }
  }

  void updateDetalle(int productoId, {double? cantidad, double? precioCosto}) {
    final updated = state.detalles.map((d) {
      if (d.productoId == productoId) {
        return d.copyWith(cantidad: cantidad, precioCosto: precioCosto);
      }
      return d;
    }).toList();
    state = state.copyWith(detalles: updated);
  }

  void removeDetalle(int productoId) {
    state = state.copyWith(
      detalles: state.detalles.where((d) => d.productoId != productoId).toList(),
    );
  }

  Future<Result<int>> save() async {
    if (state.proveedorId == null) {
      return const Failure('Selecciona un proveedor');
    }
    if (state.detalles.isEmpty) {
      return const Failure('Agrega al menos un producto');
    }
    for (final d in state.detalles) {
      if (d.cantidad <= 0) return const Failure('La cantidad debe ser mayor a 0');
      if (d.precioCosto <= 0) return const Failure('El precio de costo debe ser mayor a 0');
    }

    state = state.copyWith(submitState: const AsyncLoading());

    final repo = ref.read(comprasRepositoryProvider);
    final detalles = state.detalles
        .map((d) => CompraDetalleEntry(
              productoId: d.productoId,
              cantidad: d.cantidad,
              precioCosto: d.precioCosto,
            ))
        .toList();

    final result = await repo.crearCompra(
      proveedorId: state.proveedorId!,
      nroFactura: state.nroFactura,
      detalles: detalles,
    );

    if (result.isSuccess) {
      ref.read(stockUpdateCounterProvider.notifier).notify();
      state = const CompraFormState();
    } else {
      state = state.copyWith(
        submitState: AsyncError(result.errorMessage, StackTrace.current),
      );
    }

    return result;
  }

  void reset() {
    state = const CompraFormState();
  }
}
