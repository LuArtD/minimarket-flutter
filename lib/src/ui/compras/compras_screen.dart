import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../database/app_database.dart';
import '../../navigation/routes.dart';
import '../../providers/database_provider.dart';
import '../../theme/formatters.dart';
import '../../theme/spacing.dart';
import '../shared/widgets/empty_state.dart';

class ComprasScreen extends ConsumerWidget {
  const ComprasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final comprasAsync = ref.watch(comprasStreamProvider);
    final proveedoresAsync = ref.watch(proveedoresStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Compras'),
        actions: [
          IconButton(
            icon: const Icon(Icons.local_shipping_outlined),
            tooltip: 'Proveedores',
            onPressed: () => context.push(AppRoutes.proveedores),
          ),
        ],
      ),
      body: comprasAsync.when(
        data: (compras) {
          if (compras.isEmpty) {
            return const EmptyState(
              icon: Icons.shopping_cart_outlined,
              title: 'No hay compras registradas',
              subtitle: 'Registra una nueva compra con el botón +',
            );
          }
          return proveedoresAsync.when(
            data: (proveedores) {
              return ListView.builder(
                itemCount: compras.length,
                itemBuilder: (context, index) {
                  final compra = compras[index];
                  final proveedor = proveedores.where((p) => p.id == compra.proveedorId).firstOrNull ??
                      Proveedore(id: 0, nombre: 'Desconocido', contacto: null, telefono: null, email: null, direccion: null, activo: 1, creadoEn: '');

                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xs),
                    child: ListTile(
                      onTap: () => context.push('/compras/${compra.id}'),
                      leading: CircleAvatar(backgroundColor: Theme.of(context).colorScheme.secondaryContainer, child: Icon(Icons.local_shipping, color: Theme.of(context).colorScheme.onSecondaryContainer)),
                      title: Text(AppFormatters.formatCurrency(compra.total)),
                      subtitle: Text('${proveedor.nombre} · ${_formatFecha(compra.fecha)}'),
                      trailing: compra.nroFactura != null ? Text('Fact: ${compra.nroFactura}', style: Theme.of(context).textTheme.labelSmall) : null,
                    ),
                  );
                },
              );
            },
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Error: $e')),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  static String _formatFecha(String fecha) {
    if (fecha.length >= 16) return fecha.substring(0, 16);
    return fecha;
  }
}
