import 'package:drift/drift.dart';

import '../dao/venta_detalles_dao.dart';
import '../dao/ventas_dao.dart';
import '../dao/views_dao.dart';
import '../database/app_database.dart';
import '../models/result.dart';
import '../services/fifo_service.dart';

class VentaProductoEntry {
  final int productoId;
  final double cantidad;

  const VentaProductoEntry({
    required this.productoId,
    required this.cantidad,
  });
}

class VentasRepository {
  final VentasDao _ventasDao;
  final VentaDetallesDao _detallesDao;
  final ViewsDao _viewsDao;
  final FifoService _fifoService;
  final AppDatabase _db;

  VentasRepository(this._ventasDao, this._detallesDao, this._viewsDao, this._fifoService, this._db);

  Stream<List<Venta>> watchAll() {
    return _ventasDao.watchAll();
  }

  Stream<Venta?> watchById(int id) {
    return _ventasDao.watchById(id);
  }

  Stream<List<Venta>> watchByFecha(String fechaInicio, String fechaFin) {
    return _ventasDao.watchByFecha(fechaInicio, fechaFin);
  }

  Stream<List<VentaDetalle>> watchDetallesByVenta(int ventaId) {
    return _detallesDao.watchByVentaId(ventaId);
  }

  Future<Result<List<Venta>>> getAll() async {
    try {
      final result = await _ventasDao.getAll();
      return Success(result);
    } catch (e) {
      return Failure('Error al obtener ventas', Exception(e.toString()));
    }
  }

  Future<Result<Venta?>> getById(int id) async {
    try {
      final result = await _ventasDao.getById(id);
      if (result == null) {
        return Failure('Venta no encontrada: $id', SaleNotFoundException(id));
      }
      return Success(result);
    } catch (e) {
      return Failure('Error al obtener venta', Exception(e.toString()));
    }
  }

  Future<Result<int>> crearVenta({
    required String metodoPago,
    required List<VentaProductoEntry> productos,
    String? observaciones,
  }) async {
    try {
      final validMethods = ['efectivo', 'tarjeta', 'transferencia'];
      if (!validMethods.contains(metodoPago)) {
        return Failure(
          'Método de pago inválido: $metodoPago',
          const InvalidPaymentMethodException('invalid'),
        );
      }

      for (final producto in productos) {
        final stockDisponible = await _viewsDao.getStockDisponibleByProducto(producto.productoId);
        final validacion = await _fifoService.validarStock(
          producto.productoId,
          producto.cantidad,
          stockDisponible,
        );
        if (validacion.isFailure) {
          return Failure(validacion.errorMessage);
        }
      }

      final ahora = DateTime.now().toIso8601String().replaceAll('T', ' ').split('.').first;

      final todosDetalles = <VentaDetalleEntry>[];

      for (final producto in productos) {
        final lotes = await _viewsDao.getLotesDisponiblesByProducto(producto.productoId);
        final detalles = _fifoService.calcularVentaFIFO(
          ventaId: 0,
          productoId: producto.productoId,
          cantidad: producto.cantidad,
          lotes: lotes,
        );
        todosDetalles.addAll(detalles);
      }

      double totalVenta = _fifoService.calcularTotalVenta(todosDetalles);
      double costoTotalVenta = _fifoService.calcularCostoTotal(todosDetalles);

      return await _db.transaction(() async {
        final ventaId = await _ventasDao.insert(
          VentasCompanion.insert(
            fecha: Value(ahora),
            metodoPago: Value(metodoPago),
            total: Value(totalVenta),
            costoTotal: Value(costoTotalVenta),
            observaciones: Value(observaciones),
          ),
        );

        final companions = todosDetalles
            .map((d) => VentaDetallesCompanion.insert(
                  ventaId: ventaId,
                  productoId: d.productoId,
                  loteId: d.loteId,
                  cantidad: d.cantidad,
                  precioVenta: d.precioVenta,
                  precioCosto: d.precioCosto,
                ))
            .toList();

        for (final c in companions) {
          await _detallesDao.insert(c);
        }

        return Success(ventaId);
      });
    } catch (e) {
      return Failure('Error al crear venta: $e', Exception(e.toString()));
    }
  }
}
