import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/result.dart';
import '../providers/database_provider.dart';
import '../repositories/ventas_repository.dart';

part 'venta_form_notifier.g.dart';

class VentaProductoItem {
  final int productoId;
  final String nombre;
  final double precioVenta;
  final double cantidad;
  final double stockDisponible;

  const VentaProductoItem({
    required this.productoId,
    required this.nombre,
    required this.precioVenta,
    required this.cantidad,
    required this.stockDisponible,
  });

  double get subtotal => cantidad * precioVenta;

  VentaProductoItem copyWith({double? cantidad}) {
    return VentaProductoItem(
      productoId: productoId,
      nombre: nombre,
      precioVenta: precioVenta,
      cantidad: cantidad ?? this.cantidad,
      stockDisponible: stockDisponible,
    );
  }
}

class VentaFormState {
  final List<VentaProductoItem> productos;
  final String metodoPago;
  final String? observaciones;
  final AsyncValue<void> submitState;

  const VentaFormState({
    this.productos = const [],
    this.metodoPago = 'efectivo',
    this.observaciones,
    this.submitState = const AsyncData(null),
  });

  double get total => productos.fold(0, (sum, p) => sum + p.subtotal);

  VentaFormState copyWith({
    List<VentaProductoItem>? productos,
    String? metodoPago,
    String? observaciones,
    AsyncValue<void>? submitState,
  }) {
    return VentaFormState(
      productos: productos ?? this.productos,
      metodoPago: metodoPago ?? this.metodoPago,
      observaciones: observaciones ?? this.observaciones,
      submitState: submitState ?? this.submitState,
    );
  }
}

@riverpod
class VentaFormNotifier extends _$VentaFormNotifier {
  @override
  VentaFormState build() {
    return const VentaFormState();
  }

  void addProducto(int productoId, String nombre, double precioVenta, double stockDisponible) {
    final existing = state.productos.indexWhere((p) => p.productoId == productoId);
    if (existing >= 0) {
      final updated = List<VentaProductoItem>.from(state.productos);
      final current = updated[existing];
      if (current.cantidad < current.stockDisponible) {
        updated[existing] = current.copyWith(cantidad: current.cantidad + 1);
        state = state.copyWith(productos: updated);
      }
    } else {
      state = state.copyWith(
        productos: [
          ...state.productos,
          VentaProductoItem(
            productoId: productoId,
            nombre: nombre,
            precioVenta: precioVenta,
            cantidad: 1,
            stockDisponible: stockDisponible,
          ),
        ],
      );
    }
  }

  void removeProducto(int productoId) {
    state = state.copyWith(
      productos: state.productos.where((p) => p.productoId != productoId).toList(),
    );
  }

  void updateCantidad(int productoId, double cantidad) {
    final updated = state.productos.map((p) {
      if (p.productoId == productoId) {
        final clamped = cantidad.clamp(0.0, p.stockDisponible);
        return p.copyWith(cantidad: clamped);
      }
      return p;
    }).toList();
    state = state.copyWith(productos: updated);
  }

  void setMetodoPago(String metodo) {
    state = state.copyWith(metodoPago: metodo);
  }

  void setObservaciones(String? obs) {
    state = state.copyWith(observaciones: obs);
  }

  Future<Result<int>> save() async {
    if (state.productos.isEmpty) {
      return const Failure('Agrega al menos un producto');
    }

    state = state.copyWith(submitState: const AsyncLoading());

    final repo = ref.read(ventasRepositoryProvider);
    final productos = state.productos
        .map((p) => VentaProductoEntry(productoId: p.productoId, cantidad: p.cantidad))
        .toList();

    final result = await repo.crearVenta(
      metodoPago: state.metodoPago,
      productos: productos,
      observaciones: state.observaciones,
    );

    if (result.isSuccess) {
      ref.read(stockUpdateCounterProvider.notifier).notify();
      state = const VentaFormState();
    } else {
      state = state.copyWith(
        submitState: AsyncError(result.errorMessage, StackTrace.current),
      );
    }

    return result;
  }

  void reset() {
    state = const VentaFormState();
  }
}
