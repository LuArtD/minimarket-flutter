import 'package:drift/drift.dart';

import '../database/app_database.dart';

part 'historial_margenes_dao.g.dart';

@DriftAccessor(tables: [HistorialMargenes])
class HistorialMargenesDao extends DatabaseAccessor<AppDatabase> with _$HistorialMargenesDaoMixin {
  HistorialMargenesDao(super.db);

  Stream<List<HistorialMargene>> watchByProductoId(int productoId) {
    return (select(historialMargenes)
          ..where((t) => t.productoId.equals(productoId))
          ..orderBy([(t) => OrderingTerm.desc(t.fecha)]))
        .watch();
  }

  Stream<List<HistorialMargene>> watchAll() {
    return (select(historialMargenes)..orderBy([(t) => OrderingTerm.desc(t.fecha)])).watch();
  }

  Future<List<HistorialMargene>> getByProductoId(int productoId) {
    return (select(historialMargenes)
          ..where((t) => t.productoId.equals(productoId))
          ..orderBy([(t) => OrderingTerm.desc(t.fecha)]))
        .get();
  }

  Future<List<HistorialMargene>> getAll() {
    return (select(historialMargenes)..orderBy([(t) => OrderingTerm.desc(t.fecha)])).get();
  }
}
