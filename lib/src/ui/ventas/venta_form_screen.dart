import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../notifiers/venta_form_notifier.dart';
import '../../theme/constants.dart';
import '../../theme/formatters.dart';
import '../../theme/spacing.dart';
import '../shared/dialogs/product_picker_dialog.dart';
import '../shared/widgets/empty_state.dart';
import '../shared/widgets/error_banner.dart';
import '../shared/widgets/loading_indicator.dart';

class VentaFormScreen extends ConsumerWidget {
  const VentaFormScreen({super.key});

  String _formatCantidad(double cantidad) {
    if (cantidad == cantidad.truncateToDouble()) {
      return cantidad.truncate().toString();
    }
    return cantidad.toString();
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ventaFormNotifierProvider);
    final notifier = ref.read(ventaFormNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Nueva Venta'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: OutlinedButton.icon(
              onPressed: () async {
                final producto = await showProductPickerDialog(context);
                if (producto != null && producto.activo == 1) {
                  notifier.addProducto(
                    producto.id,
                    producto.nombre,
                    producto.precioVenta,
                    producto.stockActual,
                  );
                }
              },
              icon: const Icon(Icons.add_shopping_cart),
              label: const Text('Agregar producto'),
            ),
          ),
          if (state.productos.isEmpty)
            const Expanded(
              child: EmptyState(
                icon: Icons.shopping_cart_outlined,
                title: 'Carrito vacío',
                subtitle: 'Agrega productos para iniciar la venta',
              ),
            )
          else
            Expanded(
              child: ListView.builder(
                itemCount: state.productos.length,
                itemBuilder: (context, index) {
                  final item = state.productos[index];
                  final cantidadCtrl = TextEditingController(text: _formatCantidad(item.cantidad));
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xs),
                    child: ListTile(
                      leading: CircleAvatar(child: Text(item.nombre[0].toUpperCase())),
                      title: Text(item.nombre),
                      subtitle: Text(
                        'Stock: ${_formatCantidad(item.stockDisponible)} · ${AppFormatters.formatCurrency(item.precioVenta)} c/u',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove_circle_outline),
                            onPressed: item.cantidad <= 1
                                ? () => notifier.removeProducto(item.productoId)
                                : () => notifier.updateCantidad(item.productoId, item.cantidad - 1),
                          ),
                          SizedBox(
                            width: 50,
                            child: TextField(
                              textAlign: TextAlign.center,
                              keyboardType: TextInputType.number,
                              controller: cantidadCtrl,
                              onSubmitted: (v) {
                                final val = double.tryParse(v);
                                if (val != null) notifier.updateCantidad(item.productoId, val);
                              },
                              decoration: const InputDecoration(
                                isDense: true,
                                contentPadding: EdgeInsets.symmetric(vertical: 8),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.add_circle_outline),
                            onPressed: item.cantidad < item.stockDisponible
                                ? () => notifier.updateCantidad(item.productoId, item.cantidad + 1)
                                : null,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          if (state.productos.isNotEmpty) ...[
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
                  const SizedBox(height: AppSpacing.md),
                  Text('Método de pago:', style: Theme.of(context).textTheme.labelLarge),
                  const SizedBox(height: AppSpacing.sm),
                  Wrap(
                    spacing: AppSpacing.sm,
                    children: AppConstants.paymentMethods.map((metodo) {
                      final selected = state.metodoPago == metodo;
                      return ChoiceChip(
                        label: Text(AppConstants.paymentMethodLabels[metodo] ?? metodo),
                        selected: selected,
                        onSelected: (_) => notifier.setMetodoPago(metodo),
                      );
                    }).toList(),
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
                            ErrorBanner.success(context, 'Venta registrada exitosamente');
                            context.pop();
                          } else if (result.isFailure && context.mounted) {
                            ErrorBanner.show(context, result.errorMessage);
                          }
                        },
                        icon: const Icon(Icons.check),
                        label: const Text('CONFIRMAR VENTA'),
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
