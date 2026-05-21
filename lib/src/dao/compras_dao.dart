import 'package:drift/drift.dart';

import '../database/app_database.dart';

part 'compras_dao.g.dart';

@DriftAccessor(tables: [Compras])
class ComprasDao extends DatabaseAccessor<AppDatabase> with _$ComprasDaoMixin {
  ComprasDao(super.db);

  Stream<List<Compra>> watchAll() {
    return (select(compras)..orderBy([(t) => OrderingTerm.desc(t.fecha)])).watch();
  }

  Stream<Compra?> watchById(int id) {
    return (select(compras)..where((t) => t.id.equals(id))).watchSingleOrNull();
  }

  Stream<List<Compra>> watchByProveedor(int proveedorId) {
    return (select(compras)
          ..where((t) => t.proveedorId.equals(proveedorId))
          ..orderBy([(t) => OrderingTerm.desc(t.fecha)]))
        .watch();
  }

  Future<List<Compra>> getAll() {
    return (select(compras)..orderBy([(t) => OrderingTerm.desc(t.fecha)])).get();
  }

  Future<Compra?> getById(int id) {
    return (select(compras)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<List<Compra>> getByProveedor(int proveedorId) {
    return (select(compras)
          ..where((t) => t.proveedorId.equals(proveedorId))
          ..orderBy([(t) => OrderingTerm.desc(t.fecha)]))
        .get();
  }

  Future<int> insert(ComprasCompanion entry) {
    return into(compras).insert(entry, mode: InsertMode.insert);
  }

  Future<int> updateTotal(int id, double total) {
    return (update(compras)..where((t) => t.id.equals(id)))
        .write(ComprasCompanion(total: Value(total)));
  }
}
