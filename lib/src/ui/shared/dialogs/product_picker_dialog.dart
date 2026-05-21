import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../database/app_database.dart';
import '../../../providers/database_provider.dart';
import '../../../theme/spacing.dart';
import '../widgets/empty_state.dart';

Future<Producto?> showProductPickerDialog(BuildContext context) async {
  return showDialog<Producto>(
    context: context,
    builder: (context) => const _ProductPickerDialog(),
  );
}

class _ProductPickerDialog extends ConsumerStatefulWidget {
  const _ProductPickerDialog();

  @override
  ConsumerState<_ProductPickerDialog> createState() => _ProductPickerDialogState();
}

class _ProductPickerDialogState extends ConsumerState<_ProductPickerDialog> {
  String _search = '';

  @override
  Widget build(BuildContext context) {
    final productosStream = ref.watch(productosRepositoryProvider).watchAll();

    return Dialog(
      child: SizedBox(
        width: double.infinity,
        height: 400,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: TextField(
                autofocus: true,
                decoration: const InputDecoration(hintText: 'Buscar producto...', prefixIcon: Icon(Icons.search), isDense: true),
                onChanged: (value) => setState(() => _search = value.toLowerCase()),
              ),
            ),
            const Divider(height: 1),
            Expanded(
              child: StreamBuilder<List<Producto>>(
                stream: productosStream,
                builder: (context, snapshot) {
                  final productos = snapshot.data ?? [];
                  final filtered = _search.isEmpty ? productos : productos.where((p) => p.nombre.toLowerCase().contains(_search)).toList();

                  if (filtered.isEmpty) {
                    return const EmptyState(icon: Icons.search_off, title: 'No se encontraron productos');
                  }

                  return ListView.builder(
                    itemCount: filtered.length,
                    itemBuilder: (context, index) {
                      final producto = filtered[index];
                      return ListTile(
                        leading: CircleAvatar(child: Text(producto.nombre[0].toUpperCase())),
                        title: Text(producto.nombre),
                        subtitle: Text('Stock: ${producto.stockActual}'),
                        onTap: () => Navigator.of(context).pop(producto),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
