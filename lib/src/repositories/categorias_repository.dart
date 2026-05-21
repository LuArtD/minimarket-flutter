import 'package:drift/drift.dart';

import '../dao/categorias_dao.dart';
import '../database/app_database.dart';
import '../models/result.dart';

class CategoriasRepository {
  final CategoriasDao _dao;

  CategoriasRepository(this._dao);

  Stream<List<Categoria>> watchAll({bool soloActivas = true}) {
    return _dao.watchAll(soloActivas: soloActivas);
  }

  Stream<Categoria?> watchById(int id) {
    return _dao.watchById(id);
  }

  Future<Result<List<Categoria>>> getAll({bool soloActivas = true}) async {
    try {
      final result = await _dao.getAll(soloActivas: soloActivas);
      return Success(result);
    } catch (e) {
      return Failure('Error al obtener categorías', Exception(e.toString()));
    }
  }

  Future<Result<Categoria?>> getById(int id) async {
    try {
      final result = await _dao.getById(id);
      if (result == null) {
        return Failure('Categoría no encontrada: $id', CategoryNotFoundException(id));
      }
      return Success(result);
    } catch (e) {
      return Failure('Error al obtener categoría', Exception(e.toString()));
    }
  }

  Future<Result<int>> insert({
    required String nombre,
    String? descripcion,
    bool activa = true,
  }) async {
    try {
      final id = await _dao.insert(
        CategoriasCompanion.insert(
          nombre: nombre,
          descripcion: Value(descripcion),
          activa: Value(activa ? 1 : 0),
        ),
      );
      return Success(id);
    } catch (e) {
      return Failure('Error al crear categoría: $e', Exception(e.toString()));
    }
  }

  Future<Result<int>> update({
    required int id,
    String? nombre,
    String? descripcion,
    bool? activa,
  }) async {
    try {
      final count = await _dao.updateRow(
        id,
        CategoriasCompanion(
          nombre: nombre != null ? Value(nombre) : const Value.absent(),
          descripcion: descripcion != null ? Value(descripcion) : const Value.absent(),
          activa: activa != null ? Value(activa ? 1 : 0) : const Value.absent(),
        ),
      );
      return Success(count);
    } catch (e) {
      return Failure('Error al actualizar categoría: $e', Exception(e.toString()));
    }
  }

  Future<Result<int>> delete(int id) async {
    try {
      final count = await _dao.deleteRow(id);
      return Success(count);
    } catch (e) {
      return Failure('Error al eliminar categoría: $e', Exception(e.toString()));
    }
  }

  Future<Result<int>> toggleActive(int id, bool activa) async {
    try {
      final count = await _dao.toggleActive(id, activa);
      return Success(count);
    } catch (e) {
      return Failure('Error al cambiar estado de categoría: $e', Exception(e.toString()));
    }
  }
}
