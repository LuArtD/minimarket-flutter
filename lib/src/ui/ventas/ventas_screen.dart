import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../notifiers/ventas_notifier.dart';
import '../../providers/database_provider.dart';
import '../../theme/formatters.dart';
import '../../theme/spacing.dart';
import '../shared/widgets/empty_state.dart';
import '../shared/widgets/error_banner.dart';
import '../shared/widgets/shimmer_loading.dart';

class VentasScreen extends ConsumerWidget {
  const VentasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ventasNotifierProvider);
    final ventasAsync = ref.watch(ventasStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Ventas')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final date = await showDatePicker(context: context, initialDate: state.fechaInicio, firstDate: DateTime(2020), lastDate: DateTime.now());
                      if (date != null) ref.read(ventasNotifierProvider.notifier).setFechaRange(date, state.fechaFin);
                    },
                    icon: const Icon(Icons.calendar_today, size: 18),
                    label: Text(AppFormatters.formatDate(state.fechaInicio)),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                const Text('→'),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () async {
                      final date = await showDatePicker(context: context, initialDate: state.fechaFin, firstDate: DateTime(2020), lastDate: DateTime.now());
                      if (date != null) ref.read(ventasNotifierProvider.notifier).setFechaRange(state.fechaInicio, date);
                    },
                    icon: const Icon(Icons.calendar_today, size: 18),
                    label: Text(AppFormatters.formatDate(state.fechaFin)),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: ventasAsync.when(
              data: (ventas) {
                if (ventas.isEmpty) {
                  return const EmptyState(icon: Icons.point_of_sale_outlined, title: 'No hay ventas en este período', subtitle: 'Registra una nueva venta con el botón +');
                }
                return ListView.builder(
                  itemCount: ventas.length,
                  itemBuilder: (context, index) {
                    final venta = ventas[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xs),
                      child: ListTile(
                        onTap: () => context.push('/ventas/${venta.id}'),
                        leading: CircleAvatar(backgroundColor: Theme.of(context).colorScheme.primaryContainer, child: Icon(Icons.receipt, color: Theme.of(context).colorScheme.onPrimaryContainer)),
                        title: Text(AppFormatters.formatCurrency(venta.total)),
                        subtitle: Text('${venta.metodoPago.toUpperCase()} · ${AppFormatters.formatDateTimeShort(venta.fecha)}'),
                        trailing: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('Ganancia: ${AppFormatters.formatCurrency(venta.total - venta.costoTotal)}', style: Theme.of(context).textTheme.labelSmall?.copyWith(color: Theme.of(context).colorScheme.primary, fontWeight: FontWeight.w600)),
                            Text('Costo: ${AppFormatters.formatCurrency(venta.costoTotal)}', style: Theme.of(context).textTheme.labelSmall),
                          ],
                        ),
                      ),
                    );
                  },
                );
              },
              loading: () => const ShimmerList(),
              error: (e, _) => ErrorBanner(message: 'Error: $e', onRetry: () => ref.invalidate(ventasStreamProvider)),
            ),
          ),
        ],
      ),
    );
  }

}
