import 'package:drift/drift.dart';

import '../database/app_database.dart';

part 'compra_detalles_dao.g.dart';

@DriftAccessor(tables: [CompraDetalles])
class CompraDetallesDao extends DatabaseAccessor<AppDatabase> with _$CompraDetallesDaoMixin {
  CompraDetallesDao(super.db);

  Stream<List<CompraDetalle>> watchByCompraId(int compraId) {
    return (select(compraDetalles)..where((t) => t.compraId.equals(compraId))).watch();
  }

  Stream<List<CompraDetalle>> watchByProductoId(int productoId) {
    return (select(compraDetalles)..where((t) => t.productoId.equals(productoId))).watch();
  }

  Stream<CompraDetalle?> watchById(int id) {
    return (select(compraDetalles)..where((t) => t.id.equals(id))).watchSingleOrNull();
  }

  Future<List<CompraDetalle>> getByCompraId(int compraId) {
    return (select(compraDetalles)..where((t) => t.compraId.equals(compraId))).get();
  }

  Future<List<CompraDetalle>> getByProductoId(int productoId) {
    return (select(compraDetalles)..where((t) => t.productoId.equals(productoId))).get();
  }

  Future<CompraDetalle?> getById(int id) {
    return (select(compraDetalles)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<int> insert(CompraDetallesCompanion entry) {
    return into(compraDetalles).insert(entry, mode: InsertMode.insert);
  }

  Future<int> updateCantidadRestante(int id, double cantidadRestante) {
    return (update(compraDetalles)..where((t) => t.id.equals(id)))
        .write(CompraDetallesCompanion(cantidadRestante: Value(cantidadRestante)));
  }
}
