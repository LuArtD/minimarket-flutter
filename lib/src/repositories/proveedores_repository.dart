import 'package:drift/drift.dart';

import '../dao/proveedores_dao.dart';
import '../database/app_database.dart';
import '../models/result.dart';

class ProveedoresRepository {
  final ProveedoresDao _dao;

  ProveedoresRepository(this._dao);

  Stream<List<Proveedore>> watchAll({bool soloActivos = true}) {
    return _dao.watchAll(soloActivos: soloActivos);
  }

  Stream<Proveedore?> watchById(int id) {
    return _dao.watchById(id);
  }

  Future<Result<List<Proveedore>>> getAll({bool soloActivos = true}) async {
    try {
      final result = await _dao.getAll(soloActivos: soloActivos);
      return Success(result);
    } catch (e) {
      return Failure('Error al obtener proveedores', Exception(e.toString()));
    }
  }

  Future<Result<Proveedore?>> getById(int id) async {
    try {
      final result = await _dao.getById(id);
      if (result == null) {
        return Failure('Proveedor no encontrado: $id', SupplierNotFoundException(id));
      }
      return Success(result);
    } catch (e) {
      return Failure('Error al obtener proveedor', Exception(e.toString()));
    }
  }

  Future<Result<int>> insert({
    required String nombre,
    String? contacto,
    String? telefono,
    String? email,
    String? direccion,
    bool activo = true,
  }) async {
    try {
      final id = await _dao.insert(
        ProveedoresCompanion.insert(
          nombre: nombre,
          contacto: Value(contacto),
          telefono: Value(telefono),
          email: Value(email),
          direccion: Value(direccion),
          activo: Value(activo ? 1 : 0),
        ),
      );
      return Success(id);
    } catch (e) {
      return Failure('Error al crear proveedor: $e', Exception(e.toString()));
    }
  }

  Future<Result<int>> update({
    required int id,
    String? nombre,
    String? contacto,
    String? telefono,
    String? email,
    String? direccion,
    bool? activo,
  }) async {
    try {
      final count = await _dao.updateRow(
        id,
        ProveedoresCompanion(
          nombre: nombre != null ? Value(nombre) : const Value.absent(),
          contacto: contacto != null ? Value(contacto) : const Value.absent(),
          telefono: telefono != null ? Value(telefono) : const Value.absent(),
          email: email != null ? Value(email) : const Value.absent(),
          direccion: direccion != null ? Value(direccion) : const Value.absent(),
          activo: activo != null ? Value(activo ? 1 : 0) : const Value.absent(),
        ),
      );
      return Success(count);
    } catch (e) {
      return Failure('Error al actualizar proveedor: $e', Exception(e.toString()));
    }
  }

  Future<Result<int>> delete(int id) async {
    try {
      final count = await _dao.deleteRow(id);
      return Success(count);
    } catch (e) {
      return Failure('Error al eliminar proveedor: $e', Exception(e.toString()));
    }
  }

  Future<Result<int>> toggleActive(int id, bool activo) async {
    try {
      final count = await _dao.toggleActive(id, activo);
      return Success(count);
    } catch (e) {
      return Failure('Error al cambiar estado de proveedor: $e', Exception(e.toString()));
    }
  }
}
