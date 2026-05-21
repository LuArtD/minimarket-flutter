import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../database/app_database.dart';
import '../../dao/views_dao.dart';
import '../../providers/database_provider.dart';
import '../../theme/constants.dart';
import '../../theme/formatters.dart';
import '../../theme/spacing.dart';
import '../shared/widgets/currency_text.dart';
import '../shared/widgets/empty_state.dart';
import '../shared/widgets/error_banner.dart';
import '../shared/widgets/shimmer_loading.dart';
import '../shared/widgets/stock_badge.dart';

class ProductoDetalleScreen extends ConsumerStatefulWidget {
  final int productoId;

  const ProductoDetalleScreen({super.key, required this.productoId});

  @override
  ConsumerState<ProductoDetalleScreen> createState() => _ProductoDetalleScreenState();
}

class _ProductoDetalleScreenState extends ConsumerState<ProductoDetalleScreen> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final productAsync = ref.watch(productosRepositoryProvider).watchById(widget.productoId);

    return Scaffold(
      appBar: AppBar(title: const Text('Detalle del Producto')),
      body: StreamBuilder<Producto?>(
        stream: productAsync,
        builder: (context, snapshot) {
          final producto = snapshot.data;
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Padding(padding: EdgeInsets.all(16), child: ShimmerCard(height: 400));
          }
          if (producto == null) {
            return const EmptyState(icon: Icons.inventory_2_outlined, title: 'Producto no encontrado');
          }

          final categoriaAsync = ref.watch(categoriasStreamProvider);
          final stockOk = producto.stockActual > producto.stockMinimo;

          return categoriaAsync.when(
            data: (categorias) {
              final categoria = categorias.where((c) => c.id == producto.categoriaId).firstOrNull;
              return _buildContent(theme, producto, categoria, stockOk);
            },
            loading: () => const ShimmerCard(height: 300),
            error: (e, _) => ErrorBanner(message: 'Error: $e', onRetry: () => ref.invalidate(categoriasStreamProvider)),
          );
        },
      ),
    );
  }

  Widget _buildContent(ThemeData theme, Producto producto, Categoria? categoria, bool stockOk) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _HeaderSection(producto: producto, categoria: categoria, stockOk: stockOk),
          const SizedBox(height: AppSpacing.lg),
          _InfoCard(producto: producto, theme: theme),
          const SizedBox(height: AppSpacing.lg),
          _LotesSection(productoId: widget.productoId, theme: theme),
          const SizedBox(height: AppSpacing.lg),
          _HistorialMargenesSection(productoId: widget.productoId, theme: theme),
          const SizedBox(height: AppSpacing.lg),
          _AjustesSection(productoId: widget.productoId, theme: theme),
        ],
      ),
    );
  }
}

class _HeaderSection extends StatelessWidget {
  final Producto producto;
  final Categoria? categoria;
  final bool stockOk;

  const _HeaderSection({
    required this.producto,
    required this.categoria,
    required this.stockOk,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: stockOk
                  ? theme.colorScheme.primaryContainer
                  : theme.colorScheme.errorContainer,
              child: Text(
                producto.nombre[0].toUpperCase(),
                style: TextStyle(
                  fontSize: 24,
                  color: stockOk
                      ? theme.colorScheme.onPrimaryContainer
                      : theme.colorScheme.onErrorContainer,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(producto.nombre, style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  if (categoria != null)
                    Text(categoria!.nombre, style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      StockBadge(stockOk ? AppConstants.stockStatusOk : AppConstants.stockStatusReponer),
                      const SizedBox(width: AppSpacing.sm),
                      Icon(producto.activo == 1 ? Icons.check_circle_outline : Icons.cancel_outlined,
                          size: 14, color: producto.activo == 1 ? theme.colorScheme.tertiary : theme.colorScheme.error),
                      const SizedBox(width: 4),
                      Text(producto.activo == 1 ? 'Activo' : 'Inactivo',
                          style: theme.textTheme.labelSmall?.copyWith(
                              color: producto.activo == 1 ? theme.colorScheme.tertiary : theme.colorScheme.error)),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final Producto producto;
  final ThemeData theme;

  const _InfoCard({required this.producto, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Información', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
            const Divider(),
            _infoRow('Precio de venta', AppFormatters.formatCurrency(producto.precioVenta), theme),
            _infoRow('Margen de ganancia', '${producto.margenGananciaPct.toStringAsFixed(1)}%', theme),
            _infoRow('Stock actual', AppFormatters.formatNumber(producto.stockActual), theme),
            _infoRow('Stock mínimo', AppFormatters.formatNumber(producto.stockMinimo), theme),
            if (producto.descripcion != null && producto.descripcion!.isNotEmpty) ...[
              const SizedBox(height: AppSpacing.sm),
              Text('Descripción', style: theme.textTheme.labelMedium),
              const SizedBox(height: 4),
              Text(producto.descripcion!, style: theme.textTheme.bodyMedium),
            ],
          ],
        ),
      ),
    );
  }

  Widget _infoRow(String label, String value, ThemeData theme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
          Text(value, style: theme.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}

class _LotesSection extends ConsumerWidget {
  final int productoId;
  final ThemeData theme;

  const _LotesSection({required this.productoId, required this.theme});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final lotesAsync = ref.watch(viewsDaoProvider).watchLotesDisponiblesByProducto(productoId);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Lotes FIFO disponibles', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
            const Divider(),
            StreamBuilder<List<LoteDisponible>>(
              stream: lotesAsync,
              builder: (context, snapshot) {
                final lotes = snapshot.data ?? [];
                if (lotes.isEmpty) return const Padding(padding: EdgeInsets.all(8), child: EmptyState(icon: Icons.inventory_outlined, title: 'Sin lotes disponibles'));

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: lotes.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final lote = lotes[index];
                    final pctVendido = lote.cantidadOriginal > 0
                        ? ((lote.cantidadOriginal - lote.cantidadRestante) / lote.cantidadOriginal * 100).toStringAsFixed(0)
                        : '0';
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 6),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(lote.proveedor, style: theme.textTheme.labelMedium?.copyWith(fontWeight: FontWeight.w600)),
                              Text('${AppFormatters.formatNumber(lote.cantidadRestante)}/${AppFormatters.formatNumber(lote.cantidadOriginal)} u.',
                                  style: theme.textTheme.labelSmall),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(AppFormatters.formatDateShort(lote.fechaCompra), style: theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                              Text('$pctVendido% vendido', style: theme.textTheme.labelSmall),
                            ],
                          ),
                          const SizedBox(height: 2),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Costo: ${AppFormatters.formatCurrency(lote.precioCosto)}', style: theme.textTheme.labelSmall),
                              CurrencyText(lote.precioVentaLote, style: theme.textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w600)),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

}

class _HistorialMargenesSection extends ConsumerWidget {
  final int productoId;
  final ThemeData theme;

  const _HistorialMargenesSection({required this.productoId, required this.theme});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historialStream = ref.watch(viewsDaoProvider).watchHistorialMargenesByProducto(productoId);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Historial de márgenes', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
            const Divider(),
            StreamBuilder<List<HistorialMargenProducto>>(
              stream: historialStream,
              builder: (context, snapshot) {
                final items = snapshot.data ?? [];
                if (items.isEmpty) return const Padding(padding: EdgeInsets.all(8), child: EmptyState(icon: Icons.trending_up_outlined, title: 'Sin cambios registrados'));

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final h = items[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${h.margenPctAntes.toStringAsFixed(1)}% → ${h.margenPctDespues.toStringAsFixed(1)}%',
                                    style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600)),
                                Text('${AppFormatters.formatCurrency(h.precioAntes)} → ${AppFormatters.formatCurrency(h.precioDespues)}',
                                    style: theme.textTheme.labelSmall),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(h.motivo, style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.onSurfaceVariant)),
                              Text(AppFormatters.formatDateShort(h.fecha), style: theme.textTheme.labelSmall),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

}

class _AjustesSection extends ConsumerWidget {
  final int productoId;
  final ThemeData theme;

  const _AjustesSection({required this.productoId, required this.theme});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ajustesStream = ref.watch(viewsDaoProvider).watchAjustesByProducto(productoId);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Ajustes de inventario', style: theme.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
            const Divider(),
            StreamBuilder<List<AjusteProducto>>(
              stream: ajustesStream,
              builder: (context, snapshot) {
                final items = snapshot.data ?? [];
                if (items.isEmpty) return const Padding(padding: EdgeInsets.all(8), child: EmptyState(icon: Icons.tune_outlined, title: 'Sin ajustes registrados'));

                return ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  separatorBuilder: (_, _) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final a = items[index];
                    final isEntrada = a.tipo == 'entrada';
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Icon(
                            isEntrada ? Icons.add_circle_outline : Icons.remove_circle_outline,
                            size: 20,
                            color: isEntrada ? theme.colorScheme.tertiary : theme.colorScheme.error,
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('${isEntrada ? 'Entrada' : 'Salida'}: ${AppFormatters.formatNumber(a.cantidad)} u.',
                                    style: theme.textTheme.bodySmall?.copyWith(fontWeight: FontWeight.w600)),
                                Text(a.motivo, style: theme.textTheme.labelSmall),
                              ],
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text('${AppFormatters.formatNumber(a.stockAntes)} → ${AppFormatters.formatNumber(a.stockDespues)}',
                                  style: theme.textTheme.labelSmall),
                              Text(AppFormatters.formatDateShort(a.fecha), style: theme.textTheme.labelSmall),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }

}
