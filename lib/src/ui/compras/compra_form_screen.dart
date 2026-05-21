import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../database/app_database.dart';
import '../../notifiers/compra_form_notifier.dart';
import '../../providers/database_provider.dart';
import '../../theme/formatters.dart';
import '../../theme/spacing.dart';
import '../shared/dialogs/product_picker_dialog.dart';
import '../shared/widgets/empty_state.dart';
import '../shared/widgets/error_banner.dart';
import '../shared/widgets/loading_indicator.dart';

class CompraFormScreen extends ConsumerWidget {
  const CompraFormScreen({super.key});

  String _formatCantidad(double cantidad) {
    if (cantidad == cantidad.truncateToDouble()) {
      return cantidad.truncate().toString();
    }
    return cantidad.toString();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(compraFormNotifierProvider);
    final notifier = ref.read(compraFormNotifierProvider.notifier);
    final proveedoresStream = ref.watch(proveedoresRepositoryProvider).watchAll();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Compra'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.sm),
            child: LayoutBuilder(
              builder: (context, constraints) {
                return ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: constraints.maxWidth),
                  child: StreamBuilder<List<Proveedore>>(
                    stream: proveedoresStream,
                    builder: (context, snapshot) {
                      final provs = snapshot.data ?? [];
                      return DropdownButtonFormField<int>(
                        isExpanded: true,
                        initialValue: state.proveedorId,
                        decoration: const InputDecoration(
                          labelText: 'Proveedor *',
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                        items: provs.map((p) {
                          return DropdownMenuItem(value: p.id, child: Text(p.nombre));
                        }).toList(),
                        onChanged: (v) {
                          if (v != null) notifier.setProveedor(v);
                        },
                      );
                    },
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg),
            child: TextFormField(
              decoration: const InputDecoration(labelText: 'N° Factura'),
              onChanged: notifier.setNroFactura,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: OutlinedButton.icon(
              onPressed: () async {
                final producto = await showProductPickerDialog(context);
                if (producto != null) {
                  notifier.addProducto(producto.id, producto.nombre);
                }
              },
              icon: const Icon(Icons.add),
              label: const Text('Agregar producto'),
            ),
          ),
          if (state.detalles.isEmpty)
            const Expanded(
              child: EmptyState(
                icon: Icons.receipt_long,
                title: 'Sin productos',
                subtitle: 'Agrega productos a la compra',
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: state.detalles.length,
                itemBuilder: (context, index) {
                  final item = state.detalles[index];
                  return _DetalleCard(
                    item: item,
                    formatCantidad: _formatCantidad,
                    onUpdateCantidad: (v) {
                      final val = double.tryParse(v);
                      if (val != null) notifier.updateDetalle(item.productoId, cantidad: val);
                    },
                    onUpdatePrecio: (v) {
                      final val = double.tryParse(v);
                      if (val != null) notifier.updateDetalle(item.productoId, precioCosto: val);
                    },
                    onRemove: () => notifier.removeDetalle(item.productoId),
                  );
                },
              ),
            ),
          if (state.detalles.isNotEmpty) ...[
            const Divider(),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total:', style: Theme.of(context).textTheme.titleMedium),
                      Text(
                        AppFormatters.formatCurrency(state.total),
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.w700,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  SizedBox(
                    width: double.infinity,
                    child: state.submitState.maybeWhen(
                      loading: () => const LoadingIndicator(),
                      orElse: () => FilledButton.icon(
                        onPressed: () async {
                          final result = await notifier.save();
                          if (result.isSuccess && context.mounted) {
                            ErrorBanner.success(context, 'Compra registrada exitosamente');
                            context.pop();
                          } else if (result.isFailure && context.mounted) {
                            ErrorBanner.show(context, result.errorMessage);
                          }
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('CONFIRMAR COMPRA'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _DetalleCard extends StatefulWidget {
  final CompraDetalleItem item;
  final String Function(double) formatCantidad;
  final void Function(String) onUpdateCantidad;
  final void Function(String) onUpdatePrecio;
  final VoidCallback onRemove;

  const _DetalleCard({
    required this.item,
    required this.formatCantidad,
    required this.onUpdateCantidad,
    required this.onUpdatePrecio,
    required this.onRemove,
  });

  @override
  State<_DetalleCard> createState() => _DetalleCardState();
}

class _DetalleCardState extends State<_DetalleCard> {
  late TextEditingController _cantidadCtrl;
  late TextEditingController _precioCtrl;
  final FocusNode _cantidadFocus = FocusNode();
  final FocusNode _precioFocus = FocusNode();

  @override
  void initState() {
    super.initState();
    _cantidadCtrl = TextEditingController(text: widget.formatCantidad(widget.item.cantidad));
    _precioCtrl = TextEditingController(text: widget.item.precioCosto.toStringAsFixed(2));
  }

  @override
  void didUpdateWidget(_DetalleCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.item.cantidad != oldWidget.item.cantidad && !_cantidadFocus.hasFocus) {
      _cantidadCtrl.text = widget.formatCantidad(widget.item.cantidad);
    }
    if (widget.item.precioCosto != oldWidget.item.precioCosto && !_precioFocus.hasFocus) {
      _precioCtrl.text = widget.item.precioCosto.toStringAsFixed(2);
    }
  }

  @override
  void dispose() {
    _cantidadCtrl.dispose();
    _precioCtrl.dispose();
    _cantidadFocus.dispose();
    _precioFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xs),
      child: ListTile(
        title: Text(widget.item.nombre),
        subtitle: Text('Subtotal: ${AppFormatters.formatCurrency(widget.item.subtotal)}'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 70,
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: TextInputType.number,
                controller: _cantidadCtrl,
                focusNode: _cantidadFocus,
                onChanged: widget.onUpdateCantidad,
                decoration: const InputDecoration(labelText: 'Cant.', isDense: true),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 80,
              child: TextField(
                textAlign: TextAlign.center,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                controller: _precioCtrl,
                focusNode: _precioFocus,
                onChanged: widget.onUpdatePrecio,
                decoration: const InputDecoration(labelText: 'Costo', isDense: true),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline),
              onPressed: widget.onRemove,
            ),
          ],
        ),
      ),
    );
  }
}
