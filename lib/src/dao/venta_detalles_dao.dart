import 'package:drift/drift.dart';

import '../database/app_database.dart';

part 'venta_detalles_dao.g.dart';

@DriftAccessor(tables: [VentaDetalles])
class VentaDetallesDao extends DatabaseAccessor<AppDatabase> with _$VentaDetallesDaoMixin {
  VentaDetallesDao(super.db);

  Stream<List<VentaDetalle>> watchByVentaId(int ventaId) {
    return (select(ventaDetalles)..where((t) => t.ventaId.equals(ventaId))).watch();
  }

  Stream<List<VentaDetalle>> watchByProductoId(int productoId) {
    return (select(ventaDetalles)..where((t) => t.productoId.equals(productoId))).watch();
  }

  Stream<List<VentaDetalle>> watchByLoteId(int loteId) {
    return (select(ventaDetalles)..where((t) => t.loteId.equals(loteId))).watch();
  }

  Future<List<VentaDetalle>> getByVentaId(int ventaId) {
    return (select(ventaDetalles)..where((t) => t.ventaId.equals(ventaId))).get();
  }

  Future<List<VentaDetalle>> getByProductoId(int productoId) {
    return (select(ventaDetalles)..where((t) => t.productoId.equals(productoId))).get();
  }

  Future<int> insert(VentaDetallesCompanion entry) {
    return into(ventaDetalles).insert(entry, mode: InsertMode.insert);
  }

  Future<List<int>> insertMultiple(List<VentaDetallesCompanion> entries) async {
    final ids = <int>[];
    for (final entry in entries) {
      final id = await into(ventaDetalles).insert(entry, mode: InsertMode.insert);
      ids.add(id);
    }
    return ids;
  }
}
