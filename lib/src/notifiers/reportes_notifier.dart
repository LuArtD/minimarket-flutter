import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'reportes_notifier.g.dart';

class ReportesState {
  const ReportesState();
}

@riverpod
class ReportesNotifier extends _$ReportesNotifier {
  @override
  ReportesState build() {
    return const ReportesState();
  }
}
