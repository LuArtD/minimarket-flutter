import '../dao/ajustes_inventario_dao.dart';
import '../dao/productos_dao.dart';
import '../database/app_database.dart';
import '../models/result.dart';

class AjustesInventarioRepository {
  final AjustesInventarioDao _dao;
  final ProductosDao _productosDao;

  AjustesInventarioRepository(this._dao, this._productosDao);

  Stream<List<AjustesInventarioData>> watchAll() {
    return _dao.watchAll();
  }

  Stream<List<AjustesInventarioData>> watchByProductoId(int productoId) {
    return _dao.watchByProductoId(productoId);
  }

  Stream<List<AjustesInventarioData>> watchByTipo(String tipo) {
    return _dao.watchByTipo(tipo);
  }

  Future<Result<List<AjustesInventarioData>>> getAll() async {
    try {
      final result = await _dao.getAll();
      return Success(result);
    } catch (e) {
      return Failure('Error al obtener ajustes de inventario', Exception(e.toString()));
    }
  }

  Future<Result<int>> registrarAjuste({
    required int productoId,
    required String tipo,
    required double cantidad,
    required String motivo,
  }) async {
    try {
      if (tipo != 'entrada' && tipo != 'salida') {
        return Failure(
          'Tipo de ajuste inválido: $tipo',
          const InvalidAdjustmentTypeException('invalid'),
        );
      }

      final producto = await _productosDao.getById(productoId);
      if (producto == null) {
        return Failure('Producto no encontrado: $productoId', ProductNotFoundException(productoId));
      }

      final stockAntes = producto.stockActual;
      final stockDespues = tipo == 'entrada'
          ? stockAntes + cantidad
          : stockAntes - cantidad;

      if (stockDespues < 0) {
        return Failure(
          'Stock insuficiente: stock actual $stockAntes, ajuste $tipo $cantidad',
          InsufficientStockException(
            productId: productoId,
            requested: tipo == 'salida' ? cantidad : 0,
            available: stockAntes,
          ),
        );
      }

      final id = await _dao.insert(
        AjustesInventarioCompanion.insert(
          productoId: productoId,
          tipo: tipo,
          cantidad: cantidad,
          motivo: motivo,
          stockAntes: stockAntes,
          stockDespues: stockDespues,
        ),
      );

      return Success(id);
    } catch (e) {
      return Failure('Error al registrar ajuste: $e', Exception(e.toString()));
    }
  }
}
