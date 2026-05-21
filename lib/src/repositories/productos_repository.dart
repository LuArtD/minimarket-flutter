import 'package:drift/drift.dart';

import '../dao/productos_dao.dart';
import '../dao/views_dao.dart';
import '../database/app_database.dart';
import '../models/result.dart';

class ProductosRepository {
  final ProductosDao _dao;
  final ViewsDao _viewsDao;

  ProductosRepository(this._dao, this._viewsDao);

  Stream<List<Producto>> watchAll({bool soloActivos = true}) {
    return _dao.watchAll(soloActivos: soloActivos);
  }

  Stream<Producto?> watchById(int id) {
    return _dao.watchById(id);
  }

  Stream<List<Producto>> watchByCategoria(int categoriaId) {
    return _dao.watchByCategoria(categoriaId);
  }

  Stream<List<StockAlerta>> watchStockAlertas() {
    return _viewsDao.watchStockAlertas();
  }

  Stream<List<ReposicionEntry>> watchReposicion() {
    return _viewsDao.watchReposicion();
  }

  Future<Result<List<Producto>>> getAll({bool soloActivos = true}) async {
    try {
      final result = await _dao.getAll(soloActivos: soloActivos);
      return Success(result);
    } catch (e) {
      return Failure('Error al obtener productos', Exception(e.toString()));
    }
  }

  Future<Result<Producto?>> getById(int id) async {
    try {
      final result = await _dao.getById(id);
      if (result == null) {
        return Failure('Producto no encontrado: $id', ProductNotFoundException(id));
      }
      return Success(result);
    } catch (e) {
      return Failure('Error al obtener producto', Exception(e.toString()));
    }
  }

  Future<Result<List<Producto>>> getByCategoria(int categoriaId) async {
    try {
      final result = await _dao.getByCategoria(categoriaId);
      return Success(result);
    } catch (e) {
      return Failure('Error al obtener productos por categoría', Exception(e.toString()));
    }
  }

  Future<Result<int>> insert({
    required String nombre,
    required int categoriaId,
    String? descripcion,
    double margenGananciaPct = 0,
    double stockMinimo = 0,
    bool activo = true,
  }) async {
    try {
      final id = await _dao.insert(
        ProductosCompanion.insert(
          nombre: nombre,
          categoriaId: categoriaId,
          descripcion: Value(descripcion),
          margenGananciaPct: Value(margenGananciaPct),
          stockMinimo: Value(stockMinimo),
          activo: Value(activo ? 1 : 0),
        ),
      );
      return Success(id);
    } catch (e) {
      return Failure('Error al crear producto: $e', Exception(e.toString()));
    }
  }

  Future<Result<int>> update({
    required int id,
    String? nombre,
    String? descripcion,
    int? categoriaId,
    double? margenGananciaPct,
    double? stockMinimo,
    bool? activo,
  }) async {
    try {
      final count = await _dao.updateRow(
        id,
        ProductosCompanion(
          nombre: nombre != null ? Value(nombre) : const Value.absent(),
          descripcion: descripcion != null ? Value(descripcion) : const Value.absent(),
          categoriaId: categoriaId != null ? Value(categoriaId) : const Value.absent(),
          margenGananciaPct: margenGananciaPct != null ? Value(margenGananciaPct) : const Value.absent(),
          stockMinimo: stockMinimo != null ? Value(stockMinimo) : const Value.absent(),
          activo: activo != null ? Value(activo ? 1 : 0) : const Value.absent(),
        ),
      );
      return Success(count);
    } catch (e) {
      return Failure('Error al actualizar producto: $e', Exception(e.toString()));
    }
  }

  Future<Result<int>> updateMargen(int id, double margen) async {
    try {
      final count = await _dao.updateMargen(id, margen);
      return Success(count);
    } catch (e) {
      return Failure('Error al actualizar margen: $e', Exception(e.toString()));
    }
  }

  Future<Result<int>> updateStockMinimo(int id, double stockMinimo) async {
    try {
      final count = await _dao.updateStockMinimo(id, stockMinimo);
      return Success(count);
    } catch (e) {
      return Failure('Error al actualizar stock mínimo: $e', Exception(e.toString()));
    }
  }

  Future<Result<int>> toggleActive(int id, bool activo) async {
    try {
      final count = await _dao.toggleActive(id, activo);
      return Success(count);
    } catch (e) {
      return Failure('Error al cambiar estado de producto: $e', Exception(e.toString()));
    }
  }
}
