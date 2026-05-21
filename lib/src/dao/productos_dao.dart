import 'package:drift/drift.dart';

import '../database/app_database.dart';

part 'productos_dao.g.dart';

@DriftAccessor(tables: [Productos])
class ProductosDao extends DatabaseAccessor<AppDatabase> with _$ProductosDaoMixin {
  ProductosDao(super.db);

  Stream<List<Producto>> watchAll({bool soloActivos = true}) {
    final query = select(productos);
    if (soloActivos) {
      query.where((t) => t.activo.equals(1));
    }
    return query.watch();
  }

  Stream<Producto?> watchById(int id) {
    return (select(productos)..where((t) => t.id.equals(id))).watchSingleOrNull();
  }

  Stream<List<Producto>> watchByCategoria(int categoriaId) {
    return (select(productos)
          ..where((t) => t.categoriaId.equals(categoriaId) & t.activo.equals(1)))
        .watch();
  }

  Future<List<Producto>> getAll({bool soloActivos = true}) {
    final query = select(productos);
    if (soloActivos) {
      query.where((t) => t.activo.equals(1));
    }
    return query.get();
  }

  Future<Producto?> getById(int id) {
    return (select(productos)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<List<Producto>> getByCategoria(int categoriaId) {
    return (select(productos)
          ..where((t) => t.categoriaId.equals(categoriaId) & t.activo.equals(1)))
        .get();
  }

  Future<int> insert(ProductosCompanion entry) {
    return into(productos).insert(entry);
  }

  Future<int> updateRow(int id, ProductosCompanion entry) {
    return (update(productos)..where((t) => t.id.equals(id))).write(entry);
  }

  Future<int> toggleActive(int id, bool activo) {
    return (update(productos)..where((t) => t.id.equals(id)))
        .write(ProductosCompanion(activo: Value(activo ? 1 : 0)));
  }

  Future<int> updateMargen(int id, double margen) {
    return (update(productos)..where((t) => t.id.equals(id)))
        .write(ProductosCompanion(margenGananciaPct: Value(margen)));
  }

  Future<int> updateStockMinimo(int id, double stockMinimo) {
    return (update(productos)..where((t) => t.id.equals(id)))
        .write(ProductosCompanion(stockMinimo: Value(stockMinimo)));
  }
}
