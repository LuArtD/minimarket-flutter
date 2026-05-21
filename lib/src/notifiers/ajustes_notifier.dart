import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../models/result.dart';
import '../providers/database_provider.dart';

part 'ajustes_notifier.g.dart';

class AjustesState {
  const AjustesState();
}

@riverpod
class AjustesNotifier extends _$AjustesNotifier {
  @override
  AjustesState build() {
    return const AjustesState();
  }

  Future<Result<int>> registrar({required int productoId, required String tipo, required double cantidad, required String motivo}) async {
    final repo = ref.read(ajustesInventarioRepositoryProvider);
    final result = repo.registrarAjuste(productoId: productoId, tipo: tipo, cantidad: cantidad, motivo: motivo);
    final resolved = await result;
    if (resolved.isSuccess) {
      ref.read(stockUpdateCounterProvider.notifier).notify();
    }
    return resolved;
  }
}
