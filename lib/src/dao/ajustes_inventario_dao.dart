import 'package:drift/drift.dart';

import '../database/app_database.dart';

part 'ajustes_inventario_dao.g.dart';

@DriftAccessor(tables: [AjustesInventario])
class AjustesInventarioDao extends DatabaseAccessor<AppDatabase> with _$AjustesInventarioDaoMixin {
  AjustesInventarioDao(super.db);

  Stream<List<AjustesInventarioData>> watchAll() {
    return (select(ajustesInventario)..orderBy([(t) => OrderingTerm.desc(t.fecha)])).watch();
  }

  Stream<List<AjustesInventarioData>> watchByProductoId(int productoId) {
    return (select(ajustesInventario)
          ..where((t) => t.productoId.equals(productoId))
          ..orderBy([(t) => OrderingTerm.desc(t.fecha)]))
        .watch();
  }

  Stream<List<AjustesInventarioData>> watchByTipo(String tipo) {
    return (select(ajustesInventario)
          ..where((t) => t.tipo.equals(tipo))
          ..orderBy([(t) => OrderingTerm.desc(t.fecha)]))
        .watch();
  }

  Future<List<AjustesInventarioData>> getAll() {
    return (select(ajustesInventario)..orderBy([(t) => OrderingTerm.desc(t.fecha)])).get();
  }

  Future<List<AjustesInventarioData>> getByProductoId(int productoId) {
    return (select(ajustesInventario)
          ..where((t) => t.productoId.equals(productoId))
          ..orderBy([(t) => OrderingTerm.desc(t.fecha)]))
        .get();
  }

  Future<int> insert(AjustesInventarioCompanion entry) {
    return into(ajustesInventario).insert(entry, mode: InsertMode.insert);
  }
}
