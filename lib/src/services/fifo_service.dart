import 'package:drift/drift.dart';

import '../dao/views_dao.dart';
import '../database/app_database.dart';
import '../models/result.dart';

class VentaDetalleEntry {
  final int ventaId;
  final int productoId;
  final int loteId;
  final double cantidad;
  final double precioVenta;
  final double precioCosto;

  const VentaDetalleEntry({
    required this.ventaId,
    required this.productoId,
    required this.loteId,
    required this.cantidad,
    required this.precioVenta,
    required this.precioCosto,
  });

  VentaDetallesCompanion toCompanion() {
    return VentaDetallesCompanion(
      ventaId: Value(ventaId),
      productoId: Value(productoId),
      loteId: Value(loteId),
      cantidad: Value(cantidad),
      precioVenta: Value(precioVenta),
      precioCosto: Value(precioCosto),
    );
  }
}

class FifoService {
  Future<Result<double>> validarStock(
    int productoId,
    double cantidadSolicitada,
    double stockDisponible,
  ) async {
    if (stockDisponible < cantidadSolicitada) {
      final cantidadStr = cantidadSolicitada == cantidadSolicitada.truncateToDouble()
          ? cantidadSolicitada.truncate().toString()
          : cantidadSolicitada.toStringAsFixed(2);
      final stockStr = stockDisponible == stockDisponible.truncateToDouble()
          ? stockDisponible.truncate().toString()
          : stockDisponible.toStringAsFixed(2);
      return Failure(
        'Stock insuficiente. Solicitado: $cantidadStr, Disponible: $stockStr',
        InsufficientStockException(
          productId: productoId,
          requested: cantidadSolicitada,
          available: stockDisponible,
        ),
      );
    }
    return Success(stockDisponible);
  }

  List<VentaDetalleEntry> calcularVentaFIFO({
    required int ventaId,
    required int productoId,
    required double cantidad,
    required List<LoteDisponible> lotes,
  }) {
    final detalles = <VentaDetalleEntry>[];
    double restante = cantidad;

    for (final lote in lotes) {
      if (restante <= 0) break;

      final tomar = restante <= lote.cantidadRestante
          ? restante
          : lote.cantidadRestante;

      detalles.add(VentaDetalleEntry(
        ventaId: ventaId,
        productoId: productoId,
        loteId: lote.loteId,
        cantidad: tomar,
        precioVenta: lote.precioVentaLote,
        precioCosto: lote.precioCosto,
      ));

      restante -= tomar;
    }

    if (restante > 0) {
      throw InsufficientStockException(
        productId: productoId,
        requested: cantidad,
        available: cantidad - restante,
      );
    }

    return detalles;
  }

  double calcularTotalVenta(List<VentaDetalleEntry> detalles) {
    return detalles.fold(0, (sum, d) => sum + (d.cantidad * d.precioVenta));
  }

  double calcularCostoTotal(List<VentaDetalleEntry> detalles) {
    return detalles.fold(0, (sum, d) => sum + (d.cantidad * d.precioCosto));
  }
}
