import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/result.dart';
import '../providers/database_provider.dart';

part 'productos_notifier.g.dart';

class ProductosState {
  final String busqueda;
  final int? categoriaFiltro;
  final bool soloStockBajo;
  final AsyncValue<void> actionState;

  const ProductosState({
    this.busqueda = '',
    this.categoriaFiltro,
    this.soloStockBajo = false,
    this.actionState = const AsyncData(null),
  });

  ProductosState copyWith({String? busqueda, int? Function()? categoriaFiltro, bool? soloStockBajo, AsyncValue<void>? actionState}) {
    return ProductosState(
      busqueda: busqueda ?? this.busqueda,
      categoriaFiltro: categoriaFiltro != null ? categoriaFiltro() : this.categoriaFiltro,
      soloStockBajo: soloStockBajo ?? this.soloStockBajo,
      actionState: actionState ?? this.actionState,
    );
  }
}

@riverpod
class ProductosNotifier extends _$ProductosNotifier {
  @override
  ProductosState build() {
    return const ProductosState();
  }

  void search(String query) {
    state = state.copyWith(busqueda: query);
  }

  void filterByCategoria(int? categoriaId) {
    state = state.copyWith(categoriaFiltro: () => categoriaId);
  }

  void toggleStockBajo() {
    state = state.copyWith(soloStockBajo: !state.soloStockBajo);
  }

  Future<Result<int>> create({required String nombre, required int categoriaId, String? descripcion, double margenGananciaPct = 0, double stockMinimo = 0}) async {
    state = state.copyWith(actionState: const AsyncLoading());
    final repo = ref.read(productosRepositoryProvider);
    final result = await repo.insert(nombre: nombre, categoriaId: categoriaId, descripcion: descripcion, margenGananciaPct: margenGananciaPct, stockMinimo: stockMinimo);
    state = state.copyWith(actionState: result.isSuccess ? const AsyncData(null) : AsyncError(result.errorMessage, StackTrace.current));
    return result;
  }

  Future<Result<int>> update({required int id, String? nombre, String? descripcion, int? categoriaId, double? margenGananciaPct, double? stockMinimo, bool? activo}) async {
    state = state.copyWith(actionState: const AsyncLoading());
    final repo = ref.read(productosRepositoryProvider);
    final result = await repo.update(id: id, nombre: nombre, descripcion: descripcion, categoriaId: categoriaId, margenGananciaPct: margenGananciaPct, stockMinimo: stockMinimo);
    state = state.copyWith(actionState: result.isSuccess ? const AsyncData(null) : AsyncError(result.errorMessage, StackTrace.current));
    return result;
  }

  Future<Result<int>> toggleActive(int id, bool activo) async {
    final repo = ref.read(productosRepositoryProvider);
    return repo.toggleActive(id, activo);
  }
}
