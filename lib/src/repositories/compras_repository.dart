import 'package:drift/drift.dart';

import '../dao/compra_detalles_dao.dart';
import '../dao/compras_dao.dart';
import '../database/app_database.dart';
import '../models/result.dart';

class CompraDetalleEntry {
  final int productoId;
  final double cantidad;
  final double precioCosto;

  const CompraDetalleEntry({
    required this.productoId,
    required this.cantidad,
    required this.precioCosto,
  });
}

class ComprasRepository {
  final ComprasDao _comprasDao;
  final CompraDetallesDao _detallesDao;
  final AppDatabase _db;

  ComprasRepository(this._comprasDao, this._detallesDao, this._db);

  Stream<List<Compra>> watchAll() {
    return _comprasDao.watchAll();
  }

  Stream<Compra?> watchById(int id) {
    return _comprasDao.watchById(id);
  }

  Stream<List<Compra>> watchByProveedor(int proveedorId) {
    return _comprasDao.watchByProveedor(proveedorId);
  }

  Stream<List<CompraDetalle>> watchDetallesByCompra(int compraId) {
    return _detallesDao.watchByCompraId(compraId);
  }

  Future<Result<List<Compra>>> getAll() async {
    try {
      final result = await _comprasDao.getAll();
      return Success(result);
    } catch (e) {
      return Failure('Error al obtener compras', Exception(e.toString()));
    }
  }

  Future<Result<Compra?>> getById(int id) async {
    try {
      final result = await _comprasDao.getById(id);
      if (result == null) {
        return Failure('Compra no encontrada: $id', PurchaseNotFoundException(id));
      }
      return Success(result);
    } catch (e) {
      return Failure('Error al obtener compra', Exception(e.toString()));
    }
  }

  Future<Result<int>> crearCompra({
    required int proveedorId,
    String? nroFactura,
    String? observaciones,
    List<CompraDetalleEntry>? detalles,
  }) async {
    try {
      final ahora = DateTime.now().toIso8601String().replaceAll('T', ' ').split('.').first;
      double totalCalculado = 0;
      if (detalles != null) {
        for (final d in detalles) {
          totalCalculado += d.cantidad * d.precioCosto;
        }
      }

      return await _db.transaction(() async {
        final compraId = await _comprasDao.insert(
          ComprasCompanion.insert(
            proveedorId: proveedorId,
            fecha: Value(ahora),
            total: Value(totalCalculado),
            nroFactura: Value(nroFactura),
            observaciones: Value(observaciones),
          ),
        );

        if (detalles != null && detalles.isNotEmpty) {
          for (final detalle in detalles) {
            await _detallesDao.insert(
              CompraDetallesCompanion.insert(
                compraId: compraId,
                productoId: detalle.productoId,
                cantidad: detalle.cantidad,
                cantidadRestante: detalle.cantidad,
                precioCosto: detalle.precioCosto,
              ),
            );
          }
        }

        return Success(compraId);
      });
    } catch (e) {
      return Failure('Error al crear compra: $e', Exception(e.toString()));
    }
  }
}
