import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'compras_notifier.g.dart';

class ComprasState {
  const ComprasState();
}

@riverpod
class ComprasNotifier extends _$ComprasNotifier {
  @override
  ComprasState build() {
    return const ComprasState();
  }
}
