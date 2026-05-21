import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../database/app_database.dart';
import '../../navigation/routes.dart';
import '../../notifiers/ajustes_notifier.dart';
import '../../providers/database_provider.dart';
import '../../theme/constants.dart';
import '../../theme/formatters.dart';
import '../../theme/spacing.dart';
import '../shared/dialogs/product_picker_dialog.dart';
import '../shared/widgets/empty_state.dart';
import '../shared/widgets/error_banner.dart';
import '../shared/widgets/shimmer_loading.dart';

class AjustesScreen extends ConsumerStatefulWidget {
  const AjustesScreen({super.key});

  @override
  ConsumerState<AjustesScreen> createState() => _AjustesScreenState();
}

class _AjustesScreenState extends ConsumerState<AjustesScreen> {
  int? _productoId;
  String _productoNombre = '';
  String _tipo = 'entrada';
  String _motivo = 'conteo físico';
  final _cantidadCtrl = TextEditingController(text: '1');
  bool _ajusteExpanded = false;

  @override
  void dispose() {
    _cantidadCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final ajustesAsync = ref.watch(ajustesStreamProvider);
    final productosAsync = ref.watch(productosStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Configuración')),
      body: Column(
        children: [
          _buildSection(context),
          const Divider(height: 1),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(AppSpacing.lg, AppSpacing.md, AppSpacing.lg, 0),
                  child: Text('Historial de ajustes', style: Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w600)),
                ),
                Expanded(
                  child: ajustesAsync.when(
                    data: (ajustes) {
                      if (ajustes.isEmpty) return const EmptyState(icon: Icons.history, title: 'Sin ajustes registrados');

                      return productosAsync.when(
                        data: (productos) {
                          return ListView.builder(
                            itemCount: ajustes.length,
                            itemBuilder: (context, index) {
                              final ajuste = ajustes[index];
                              final producto = productos.where((p) => p.id == ajuste.productoId).firstOrNull ??
                                  Producto(id: 0, nombre: 'Desconocido', descripcion: null, categoriaId: 0, precioVenta: 0, margenGananciaPct: 0, stockMinimo: 0, stockActual: 0, activo: 1, creadoEn: '', actualizadoEn: '');

                              return ListTile(
                                leading: Icon(ajuste.tipo == 'entrada' ? Icons.add_circle : Icons.remove_circle, color: ajuste.tipo == 'entrada' ? Theme.of(context).colorScheme.tertiary : Theme.of(context).colorScheme.error),
                                title: Text(producto.nombre),
                                subtitle: Text('${ajuste.motivo} · ${AppFormatters.formatDateTimeShort(ajuste.fecha)}'),
                                trailing: Text('${ajuste.tipo == 'entrada' ? '+' : '-'}${ajuste.cantidad}', style: TextStyle(color: ajuste.tipo == 'entrada' ? Theme.of(context).colorScheme.tertiary : Theme.of(context).colorScheme.error, fontWeight: FontWeight.w700)),
                              );
                            },
                          );
                        },
                        loading: () => const ShimmerList(),
                        error: (e, _) => ErrorBanner(message: 'Error: $e', onRetry: () => ref.invalidate(productosStreamProvider)),
                      );
                    },
                    loading: () => const ShimmerList(),
                    error: (e, _) => ErrorBanner(message: 'Error: $e', onRetry: () => ref.invalidate(ajustesStreamProvider)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        children: [
          _ConfigCard(
            icon: Icons.inventory_2,
            iconColor: Theme.of(context).colorScheme.primary,
            title: 'Ajustes de Inventario',
            subtitle: 'Registrar entradas o salidas de stock',
            onTap: () => setState(() => _ajusteExpanded = !_ajusteExpanded),
            expanded: _ajusteExpanded,
            child: _buildAjusteForm(context),
          ),
          const SizedBox(height: AppSpacing.sm),
          _ConfigCard(
            icon: Icons.category,
            iconColor: Theme.of(context).colorScheme.tertiary,
            title: 'Categorías',
            subtitle: 'Organizar productos por categoría',
            onTap: () => context.push(AppRoutes.categorias),
          ),
          const SizedBox(height: AppSpacing.sm),
          _ConfigCard(
            icon: Icons.local_shipping,
            iconColor: Theme.of(context).colorScheme.secondary,
            title: 'Proveedores',
            subtitle: 'Gestionar proveedores de compra',
            onTap: () => context.push(AppRoutes.proveedores),
          ),
        ],
      ),
    );
  }

  Widget _buildAjusteForm(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.md),
      child: Column(
        children: [
          OutlinedButton.icon(
            onPressed: () async {
              final producto = await showProductPickerDialog(context);
              if (producto != null) setState(() { _productoId = producto.id; _productoNombre = producto.nombre; });
            },
            icon: const Icon(Icons.inventory_2),
            label: Text(_productoNombre.isEmpty ? 'Seleccionar producto' : _productoNombre),
          ),
          if (_productoId != null) ...[
            const SizedBox(height: AppSpacing.md),
            SegmentedButton<String>(
              segments: AppConstants.adjustmentTypes.map((t) => ButtonSegment(value: t, label: Text(AppConstants.adjustmentTypeLabels[t] ?? t), icon: Icon(t == 'entrada' ? Icons.add : Icons.remove))).toList(),
              selected: {_tipo},
              onSelectionChanged: (s) => setState(() => _tipo = s.first),
            ),
            const SizedBox(height: AppSpacing.md),
            TextField(controller: _cantidadCtrl, decoration: const InputDecoration(labelText: 'Cantidad'), keyboardType: const TextInputType.numberWithOptions(decimal: true)),
            const SizedBox(height: AppSpacing.md),
            DropdownButtonFormField<String>(
              initialValue: _motivo,
              decoration: const InputDecoration(labelText: 'Motivo'),
              items: AppConstants.adjustmentMotivos.map((m) => DropdownMenuItem(value: m, child: Text(m))).toList(),
              onChanged: (v) { if (v != null) setState(() => _motivo = v); },
            ),
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: () async {
                  if (_productoId == null) { ErrorBanner.show(context, 'Selecciona un producto'); return; }
                  final cantidad = double.tryParse(_cantidadCtrl.text);
                  if (cantidad == null || cantidad <= 0) { ErrorBanner.show(context, 'Ingresa una cantidad válida'); return; }
                  final result = await ref.read(ajustesNotifierProvider.notifier).registrar(productoId: _productoId!, tipo: _tipo, cantidad: cantidad, motivo: _motivo);
                  if (result.isSuccess && context.mounted) {
                    ErrorBanner.success(context, 'Ajuste registrado');
                    setState(() { _productoId = null; _productoNombre = ''; _cantidadCtrl.text = '1'; });
                  } else if (result.isFailure && context.mounted) {
                    ErrorBanner.show(context, result.errorMessage);
                  }
                },
                icon: const Icon(Icons.save),
                label: const Text('REGISTRAR AJUSTE'),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _ConfigCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final String title;
  final String subtitle;
  final VoidCallback onTap;
  final bool expanded;
  final Widget? child;

  const _ConfigCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.subtitle,
    required this.onTap,
    this.expanded = false,
    this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        children: [
          InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: iconColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(icon, color: iconColor),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(title, style: Theme.of(context).textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w600)),
                        Text(subtitle, style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).colorScheme.onSurfaceVariant)),
                      ],
                    ),
                  ),
                  if (child != null)
                    AnimatedRotation(
                      turns: expanded ? 0.5 : 0,
                      duration: const Duration(milliseconds: 200),
                      child: Icon(Icons.expand_more, color: Theme.of(context).colorScheme.onSurfaceVariant),
                    ),
                ],
              ),
            ),
          ),
          if (expanded && child != null) child!,
        ],
      ),
    );
  }
}
