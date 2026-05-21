import 'package:drift/drift.dart';

import '../database/app_database.dart';

part 'ventas_dao.g.dart';

@DriftAccessor(tables: [Ventas])
class VentasDao extends DatabaseAccessor<AppDatabase> with _$VentasDaoMixin {
  VentasDao(super.db);

  Stream<List<Venta>> watchAll() {
    return (select(ventas)..orderBy([(t) => OrderingTerm.desc(t.fecha)])).watch();
  }

  Stream<Venta?> watchById(int id) {
    return (select(ventas)..where((t) => t.id.equals(id))).watchSingleOrNull();
  }

  Stream<List<Venta>> watchByFecha(String fechaInicio, String fechaFin) {
    return (select(ventas)
          ..where((t) => t.fecha.isBetweenValues(fechaInicio, fechaFin))
          ..orderBy([(t) => OrderingTerm.desc(t.fecha)]))
        .watch();
  }

  Stream<List<Venta>> watchByMetodoPago(String metodoPago) {
    return (select(ventas)
          ..where((t) => t.metodoPago.equals(metodoPago))
          ..orderBy([(t) => OrderingTerm.desc(t.fecha)]))
        .watch();
  }

  Future<List<Venta>> getAll() {
    return (select(ventas)..orderBy([(t) => OrderingTerm.desc(t.fecha)])).get();
  }

  Future<Venta?> getById(int id) {
    return (select(ventas)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  Future<List<Venta>> getByFecha(String fechaInicio, String fechaFin) {
    return (select(ventas)
          ..where((t) => t.fecha.isBetweenValues(fechaInicio, fechaFin))
          ..orderBy([(t) => OrderingTerm.desc(t.fecha)]))
        .get();
  }

  Future<int> insert(VentasCompanion entry) {
    return into(ventas).insert(entry, mode: InsertMode.insert);
  }

  Future<int> updateTotales(int id, double total, double costoTotal) {
    return (update(ventas)..where((t) => t.id.equals(id)))
        .write(VentasCompanion(total: Value(total), costoTotal: Value(costoTotal)));
  }
}
