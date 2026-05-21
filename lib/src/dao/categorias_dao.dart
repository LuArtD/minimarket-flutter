import 'package:drift/drift.dart';

import '../database/app_database.dart';

part 'categorias_dao.g.dart';

@DriftAccessor(tables: [Categorias])
class CategoriasDao extends DatabaseAccessor<AppDatabase> with _$CategoriasDaoMixin {
  CategoriasDao(super.db);

  Stream<List<Categoria>> watchAll({bool soloActivas = true}) {
    final query = select(categorias);
    if (soloActivas) {
      query.where((t) => t.activa.equals(1));
    }
    return query.watch();
  }

  Stream<Categoria?> watchById(int id) {
    return (select(categorias)..where((t) => t.id.equals(id))).watchSingleOrNull();
  }

  Future<List<Categoria>> getAll({bool soloActivas = true}) {
    final query = select(categorias);
    if (soloActivas) {
      query.where((t) => t.activa.equals(1));
    }
    return query.get();
  }

  Future<Categoria?> getById(int id) {
    return (select(categorias)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<int> insert(CategoriasCompanion entry) {
    return into(categorias).insert(entry);
  }

  Future<int> updateRow(int id, CategoriasCompanion entry) {
    return (update(categorias)..where((t) => t.id.equals(id))).write(entry);
  }

  Future<int> deleteRow(int id) {
    return (delete(categorias)..where((t) => t.id.equals(id))).go();
  }

  Future<int> toggleActive(int id, bool activa) {
    return (update(categorias)..where((t) => t.id.equals(id)))
        .write(CategoriasCompanion(activa: Value(activa ? 1 : 0)));
  }
}
