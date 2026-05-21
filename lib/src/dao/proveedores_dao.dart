import 'package:drift/drift.dart';

import '../database/app_database.dart';

part 'proveedores_dao.g.dart';

@DriftAccessor(tables: [Proveedores])
class ProveedoresDao extends DatabaseAccessor<AppDatabase> with _$ProveedoresDaoMixin {
  ProveedoresDao(super.db);

  Stream<List<Proveedore>> watchAll({bool soloActivos = true}) {
    final query = select(proveedores);
    if (soloActivos) {
      query.where((t) => t.activo.equals(1));
    }
    return query.watch();
  }

  Stream<Proveedore?> watchById(int id) {
    return (select(proveedores)..where((t) => t.id.equals(id))).watchSingleOrNull();
  }

  Future<List<Proveedore>> getAll({bool soloActivos = true}) {
    final query = select(proveedores);
    if (soloActivos) {
      query.where((t) => t.activo.equals(1));
    }
    return query.get();
  }

  Future<Proveedore?> getById(int id) {
    return (select(proveedores)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<int> insert(ProveedoresCompanion entry) {
    return into(proveedores).insert(entry);
  }

  Future<int> updateRow(int id, ProveedoresCompanion entry) {
    return (update(proveedores)..where((t) => t.id.equals(id))).write(entry);
  }

  Future<int> deleteRow(int id) {
    return (delete(proveedores)..where((t) => t.id.equals(id))).go();
  }

  Future<int> toggleActive(int id, bool activo) {
    return (update(proveedores)..where((t) => t.id.equals(id)))
        .write(ProveedoresCompanion(activo: Value(activo ? 1 : 0)));
  }
}
