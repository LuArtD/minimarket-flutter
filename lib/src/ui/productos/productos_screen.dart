import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../database/app_database.dart';
import '../../navigation/routes.dart';
import '../../notifiers/productos_notifier.dart';
import '../../providers/database_provider.dart';
import '../../theme/formatters.dart';
import '../../theme/spacing.dart';
import '../shared/dialogs/confirm_dialog.dart';
import '../shared/widgets/empty_state.dart';
import '../shared/widgets/error_banner.dart';
import '../shared/widgets/shimmer_loading.dart';
import '../shared/widgets/stock_badge.dart';

class ProductosScreen extends ConsumerStatefulWidget {
  const ProductosScreen({super.key});

  @override
  ConsumerState<ProductosScreen> createState() => _ProductosScreenState();
}

class _ProductosScreenState extends ConsumerState<ProductosScreen> {
  List<Categoria> _categorias = [];

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productosNotifierProvider);
    final notifier = ref.read(productosNotifierProvider.notifier);
    final productosAsync = ref.watch(productosStreamProvider);
    final categoriasAsync = ref.watch(categoriasStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Productos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.category_outlined),
            tooltip: 'Categorías',
            onPressed: () => context.push(AppRoutes.categorias),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
            child: TextField(
              decoration: const InputDecoration(hintText: 'Buscar producto...', prefixIcon: Icon(Icons.search), isDense: true),
              onChanged: notifier.search,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: Row(
              children: [
                categoriasAsync.when(
                  data: (categorias) {
                    _categorias = categorias;
                    return Expanded(
                      child: DropdownButtonFormField<int?>(
                        isDense: true,
                        decoration: const InputDecoration(hintText: 'Categoría', isDense: true, contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8)),
                        initialValue: state.categoriaFiltro,
                        items: [const DropdownMenuItem(value: null, child: Text('Todas')), ...categorias.map((c) => DropdownMenuItem(value: c.id, child: Text(c.nombre)))],
                        onChanged: notifier.filterByCategoria,
                      ),
                    );
                  },
                  loading: () => const Expanded(child: Center(child: SizedBox(height: 40, child: ShimmerCard(height: 40)))),
                  error: (_, _) => const Expanded(child: SizedBox.shrink()),
                ),
                const SizedBox(width: AppSpacing.sm),
                FilterChip(label: const Text('Stock bajo'), selected: state.soloStockBajo, onSelected: (_) => notifier.toggleStockBajo()),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: productosAsync.when(
              data: (productos) {
                var filtered = productos;
                if (state.busqueda.isNotEmpty) {
                  final search = state.busqueda.toLowerCase();
                  filtered = filtered.where((p) => p.nombre.toLowerCase().contains(search)).toList();
                }
                if (state.categoriaFiltro != null) {
                  filtered = filtered.where((p) => p.categoriaId == state.categoriaFiltro).toList();
                }
                if (state.soloStockBajo) {
                  filtered = filtered.where((p) => p.stockActual <= p.stockMinimo).toList();
                }

                if (filtered.isEmpty) {
                  return const EmptyState(icon: Icons.inventory_2_outlined, title: 'No se encontraron productos', subtitle: 'Intenta cambiar los filtros o agrega un nuevo producto');
                }

                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final producto = filtered[index];
                    final stockOk = producto.stockActual > producto.stockMinimo;
                    final categoria = _categorias.where((c) => c.id == producto.categoriaId).firstOrNull ?? Categoria(id: 0, nombre: 'Sin categoría', descripcion: null, activa: 1, creadoEn: '');

                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xs),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(12),
                        onTap: () => context.push('/productos/${producto.id}'),
                        child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CircleAvatar(
                              backgroundColor: stockOk ? Theme.of(context).colorScheme.primaryContainer : Theme.of(context).colorScheme.errorContainer,
                              child: Text(producto.nombre[0].toUpperCase(), style: TextStyle(color: stockOk ? Theme.of(context).colorScheme.onPrimaryContainer : Theme.of(context).colorScheme.onErrorContainer)),
                            ),
                            const SizedBox(width: AppSpacing.md),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(producto.nombre, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                                  const SizedBox(height: 2),
                                  Text(categoria.nombre, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                                  const SizedBox(height: 4),
                                  Row(
                                    children: [
                                      StockBadge(stockOk ? 'OK' : 'REPONER'),
                                      const SizedBox(width: AppSpacing.sm),
                                      Text(AppFormatters.formatCurrency(producto.precioVenta), style: Theme.of(context).textTheme.labelLarge?.copyWith(fontWeight: FontWeight.w600, color: Theme.of(context).colorScheme.primary)),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            PopupMenuButton<String>(
                              icon: const Icon(Icons.more_vert, size: 20),
                              onSelected: (value) async {
                                switch (value) {
                                  case 'edit':
                                    context.push('/productos/${producto.id}/editar');
                                  case 'toggle':
                                    await notifier.toggleActive(producto.id, producto.activo != 1);
                                  case 'delete':
                                    final confirm = await showConfirmDialog(context: context, title: 'Eliminar producto', message: '¿Estás seguro de eliminar "${producto.nombre}"?');
                                    if (confirm) {
                                      final result = await notifier.update(id: producto.id, nombre: producto.nombre, activo: false);
                                      if (result.isFailure && context.mounted) ErrorBanner.show(context, result.errorMessage);
                                    }
                                }
                              },
                              itemBuilder: (context) => [
                                const PopupMenuItem(value: 'edit', child: Text('Editar')),
                                PopupMenuItem(value: 'toggle', child: Text(producto.activo == 1 ? 'Desactivar' : 'Activar')),
                                const PopupMenuItem(value: 'delete', child: Text('Eliminar')),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                  },
                );
              },
              loading: () => const ShimmerList(),
              error: (e, _) => ErrorBanner(message: 'Error: $e', onRetry: () => ref.invalidate(productosStreamProvider)),
            ),
          ),
        ],
      ),
    );
  }
}
