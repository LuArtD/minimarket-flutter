import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../database/app_database.dart';
import '../../dao/views_dao.dart';
import '../../providers/database_provider.dart';
import '../../theme/formatters.dart';
import '../../theme/spacing.dart';
import '../shared/widgets/currency_text.dart';
import '../shared/widgets/empty_state.dart';
import '../shared/widgets/shimmer_loading.dart';

class VentaDetalleScreen extends ConsumerWidget {
  final int ventaId;

  const VentaDetalleScreen({super.key, required this.ventaId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final ventaAsync = ref.watch(ventasRepositoryProvider).watchById(ventaId);
    final detallesStream = ref.watch(viewsDaoProvider).watchVentaDetallesView(ventaId);

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de Venta')),
      body: StreamBuilder<Venta?>(
        stream: ventaAsync,
        builder: (context, snapshot) {
          final venta = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(padding: EdgeInsets.all(16), child: ShimmerCard(height: 400));
          }
          if (venta == null) {
            return const EmptyState(icon: Icons.receipt_long_outlined, title: 'Venta no encontrada');
          }

          return StreamBuilder<List<VentaDetalleView>>(
            stream: detallesStream,
            builder: (context, detSnapshot) {
              final detalles = detSnapshot.data ?? [];
              return SingleChildScrollView(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _HeaderCard(venta: venta, theme: theme),
                    const SizedBox(height: AppSpacing.lg),
                    _ProductosCard(detalles: detalles, theme: theme),
                    const SizedBox(height: AppSpacing.lg),
                    _TotalesCard(venta: venta, theme: theme),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final Venta venta;
  final ThemeData theme;

  const _HeaderCard({required this.venta, required this.theme});

  @override
  Widget build(BuildContext context) {
    final metodoLabel = switch (venta.metodoPago) {
      'efectivo' => 'Efectivo',
      'tarjeta' => 'Tarjeta',
      'transferencia' => 'Transferencia',
      _ => venta.metodoPago,
    };

    final metodoIcon = switch (venta.metodoPago) {
      'efectivo' => Icons.money,
      'tarjeta' => Icons.credit_card,
      'transferencia' => Icons.account_balance,
      _ => Icons.receipt,
    };

    final ganancia = venta.total - venta.costoTotal;
    final margen = venta.total > 0 ? (ganancia / venta.total * 100) : 0.0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: theme.colorScheme.primaryContainer,
                  child: Icon(Icons.receipt, color: theme.colorScheme.onPrimaryContainer),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Venta #${venta.id}', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text(venta.fecha.length >= 16 ? venta.fecha.substring(0, 16) : venta.fecha,
                          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                    ],
                  ),
                ),
                Chip(
                  avatar: Icon(metodoIcon, size: 16),
                  label: Text(metodoLabel, style: const TextStyle(fontSize: 12)),
                ),
              ],
            ),
            if (venta.observaciones != null && venta.observaciones!.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              Text('Obs: ${venta.observaciones}', style: theme.textTheme.bodySmall),
            ],
            const Divider(height: 24),
            _row('Total', AppFormatters.formatCurrency(venta.total), theme, bold: true),
            _row('Costo total', AppFormatters.formatCurrency(venta.costoTotal), theme),
            _row('Ganancia bruta', AppFormatters.formatCurrency(ganancia), theme,
                color: ganancia >= 0 ? theme.colorScheme.tertiary : theme.colorScheme.error, bold: true),
            _row('Margen', '${margen.toStringAsFixed(1)}%', theme,
                color: margen >= 0 ? theme.colorScheme.tertiary : theme.colorScheme.error),
          ],
        ),
      ),
    );
  }

  Widget _row(String label, String value, ThemeData theme, {bool bold = false, Color? color}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          Text(value, style: (bold ? theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600) : theme.textTheme.bodyMedium)?.copyWith(color: color)),
        ],
      ),
    );
  }
}

class _ProductosCard extends StatelessWidget {
  final List<VentaDetalleView> detalles;
  final ThemeData theme;

  const _ProductosCard({required this.detalles, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Productos vendidos (${detalles.length})', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
            const Divider(),
            if (detalles.isEmpty)
              const EmptyState(icon: Icons.inventory_2_outlined, title: 'Sin productos')
            else
              ...detalles.map((d) => _productoItem(d, theme)),
          ],
        ),
      ),
    );
  }

  Widget _productoItem(VentaDetalleView d, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: theme.colorScheme.secondaryContainer,
            child: Text(d.productoNombre[0].toUpperCase(), style: const TextStyle(fontSize: 12)),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(d.productoNombre, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text('${AppFormatters.formatNumber(d.cantidad)} × ${AppFormatters.formatCurrency(d.precioVenta)}',
                    style: theme.textTheme.labelSmall),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CurrencyText(d.subtotal, style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600)),
              Text('Gan: ${AppFormatters.formatCurrency(d.ganancia)}',
                  style: theme.textTheme.labelSmall?.copyWith(
                      color: d.ganancia >= 0 ? theme.colorScheme.tertiary : theme.colorScheme.error)),
            ],
          ),
        ],
      ),
    );
  }
}

class _TotalesCard extends StatelessWidget {
  final Venta venta;
  final ThemeData theme;

  const _TotalesCard({required this.venta, required this.theme});

  @override
  Widget build(BuildContext context) {
    final ganancia = venta.total - venta.costoTotal;
    final margen = venta.total > 0 ? (ganancia / venta.total * 100) : 0.0;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Resumen', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
            const Divider(),
            _totalRow('Subtotal', venta.total, theme, bold: true),
            _totalRow('Costo', venta.costoTotal, theme),
            const Divider(height: 16),
            _totalRow('Ganancia', ganancia, theme, color: ganancia >= 0 ? theme.colorScheme.tertiary : theme.colorScheme.error, bold: true),
            _totalRow('Margen', margen, theme, isPercentage: true, color: margen >= 0 ? theme.colorScheme.tertiary : theme.colorScheme.error),
          ],
        ),
      ),
    );
  }

  Widget _totalRow(String label, double value, ThemeData theme, {bool bold = false, Color? color, bool isPercentage = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          Text(
            isPercentage ? '${value.toStringAsFixed(1)}%' : AppFormatters.formatCurrency(value),
            style: (bold ? theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600) : theme.textTheme.bodyMedium)?.copyWith(color: color),
          ),
        ],
      ),
    );
  }
}
