import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../database/app_database.dart';
import '../../dao/views_dao.dart';
import '../../providers/database_provider.dart';
import '../../theme/formatters.dart';
import '../../theme/spacing.dart';
import '../shared/widgets/currency_text.dart';
import '../shared/widgets/empty_state.dart';

class CompraDetalleScreen extends ConsumerWidget {
  final int compraId;

  const CompraDetalleScreen({super.key, required this.compraId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final compraAsync = ref.watch(comprasRepositoryProvider).watchById(compraId);
    final detallesStream = ref.watch(viewsDaoProvider).watchCompraDetallesView(compraId);
    final proveedoresAsync = ref.watch(proveedoresStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle de Compra')),
      body: StreamBuilder<Compra?>(
        stream: compraAsync,
        builder: (context, snapshot) {
          final compra = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (compra == null) {
            return const Center(child: Text('Compra no encontrada'));
          }

          return StreamBuilder<List<CompraDetalleView>>(
            stream: detallesStream,
            builder: (context, detSnapshot) {
              final detalles = detSnapshot.data ?? [];
              return proveedoresAsync.when(
                data: (proveedores) {
                  final proveedor = proveedores.where((p) => p.id == compra.proveedorId).firstOrNull;
                  return SingleChildScrollView(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _HeaderCard(compra: compra, proveedor: proveedor, theme: theme),
                        const SizedBox(height: AppSpacing.lg),
                        _ProductosCard(detalles: detalles, theme: theme),
                        const SizedBox(height: AppSpacing.lg),
                        _TotalesCard(detalles: detalles, compra: compra, theme: theme),
                      ],
                    ),
                  );
                },
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
              );
            },
          );
        },
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  final Compra compra;
  final Proveedore? proveedor;
  final ThemeData theme;

  const _HeaderCard({required this.compra, required this.proveedor, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: theme.colorScheme.secondaryContainer,
                  child: Icon(Icons.local_shipping, color: theme.colorScheme.onSecondaryContainer),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Compra #${compra.id}', style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 2),
                      Text(compra.fecha.length >= 16 ? compra.fecha.substring(0, 16) : compra.fecha,
                          style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            if (proveedor != null) ...[
              _infoRow('Proveedor', proveedor!.nombre, theme),
              if (proveedor!.contacto != null) _infoRow('Contacto', proveedor!.contacto!, theme),
            ],
            if (compra.nroFactura != null) _infoRow('Factura N°', compra.nroFactura!, theme),
            if (compra.observaciones != null && compra.observaciones!.isNotEmpty) _infoRow('Observaciones', compra.observaciones!, theme),
            const Divider(height: 20),
            _infoRow('Total', AppFormatters.formatCurrency(compra.total), theme, bold: true),
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value, ThemeData theme, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          Text(value, style: bold ? theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600) : theme.textTheme.bodySmall),
        ],
      ),
    );
  }
}

class _ProductosCard extends StatelessWidget {
  final List<CompraDetalleView> detalles;
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
            Text('Productos comprados (${detalles.length})', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
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

  Widget _productoItem(CompraDetalleView d, ThemeData theme) {
    final vendido = d.cantidad - d.cantidadRestante;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 16,
            backgroundColor: theme.colorScheme.tertiaryContainer,
            child: Text(d.productoNombre[0].toUpperCase(), style: const TextStyle(fontSize: 12)),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(d.productoNombre, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
                const SizedBox(height: 2),
                Text('${AppFormatters.formatNumber(d.cantidad)} × ${AppFormatters.formatCurrency(d.precioCosto)}',
                    style: theme.textTheme.labelSmall),
                Text('Restante: ${AppFormatters.formatNumber(d.cantidadRestante)} u. (vendido: ${AppFormatters.formatNumber(vendido)} u.)',
                    style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
              ],
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              CurrencyText(d.subtotal, style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600)),
              if (d.precioVentaLote > 0)
                Text('Venta: ${AppFormatters.formatCurrency(d.precioVentaLote)}',
                    style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.primary)),
            ],
          ),
        ],
      ),
    );
  }
}

class _TotalesCard extends StatelessWidget {
  final List<CompraDetalleView> detalles;
  final Compra compra;
  final ThemeData theme;

  const _TotalesCard({required this.detalles, required this.compra, required this.theme});

  @override
  Widget build(BuildContext context) {
    final totalUnidades = detalles.fold(0.0, (sum, d) => sum + d.cantidad);
    final totalRestante = detalles.fold(0.0, (sum, d) => sum + d.cantidadRestante);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Resumen', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
            const Divider(),
            _totalRow('Unidades compradas', AppFormatters.formatNumber(totalUnidades), theme),
            _totalRow('Unidades disponibles', AppFormatters.formatNumber(totalRestante), theme),
            _totalRow('Unidades vendidas', AppFormatters.formatNumber(totalUnidades - totalRestante), theme),
            const Divider(height: 16),
            _totalRow('Total compra', AppFormatters.formatCurrency(compra.total), theme, bold: true),
          ],
        ),
      ),
    );
  }

  Widget _totalRow(String label, String value, ThemeData theme, {bool bold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          Text(value, style: bold ? theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600) : theme.textTheme.bodyMedium),
        ],
      ),
    );
  }
}
