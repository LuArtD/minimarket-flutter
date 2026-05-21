import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../database/app_database.dart';
import '../../providers/database_provider.dart';
import '../../theme/spacing.dart';
import '../shared/dialogs/confirm_dialog.dart';
import '../shared/widgets/empty_state.dart';
import '../shared/widgets/error_banner.dart';
import '../shared/widgets/shimmer_loading.dart';

class CategoriasScreen extends ConsumerWidget {
  const CategoriasScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriasAsync = ref.watch(categoriasStreamProvider);
    final repo = ref.watch(categoriasRepositoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Categorías')),
      body: categoriasAsync.when(
        data: (categorias) {
          if (categorias.isEmpty) {
            return EmptyState(
              icon: Icons.category_outlined,
              title: 'Sin categorías',
              subtitle: 'Agrega categorías para organizar tus productos',
              action: FilledButton.icon(
                onPressed: () => _showForm(context, ref),
                icon: const Icon(Icons.add),
                label: const Text('Nueva categoría'),
              ),
            );
          }

          return ListView.builder(
            itemCount: categorias.length,
            itemBuilder: (context, index) {
              final cat = categorias[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xs),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: cat.activa == 1
                        ? Theme.of(context).colorScheme.primaryContainer
                        : Theme.of(context).colorScheme.surfaceContainerHighest,
                    child: Icon(Icons.category, color: cat.activa == 1
                        ? Theme.of(context).colorScheme.onPrimaryContainer
                        : Theme.of(context).colorScheme.outline),
                  ),
                  title: Text(cat.nombre),
                  subtitle: cat.descripcion != null && cat.descripcion!.isNotEmpty
                      ? Text(cat.descripcion!)
                      : const Text('Sin descripción'),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (cat.activa == 0)
                        IconButton(
                          icon: Icon(Icons.restore, color: Theme.of(context).colorScheme.tertiary),
                          onPressed: () => repo.toggleActive(cat.id, true),
                        ),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert, size: 20),
                        onSelected: (value) async {
                          switch (value) {
                            case 'edit':
                              _showForm(context, ref, categoria: cat);
                            case 'toggle':
                              await repo.toggleActive(cat.id, cat.activa != 1);
                            case 'delete':
                              final confirm = await showConfirmDialog(
                                context: context,
                                title: 'Eliminar categoría',
                                message: '¿Estás seguro de eliminar "${cat.nombre}"?',
                              );
                              if (confirm) {
                                final result = await repo.delete(cat.id);
                                if (result.isFailure && context.mounted) {
                                  ErrorBanner.show(context, result.errorMessage);
                                }
                              }
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(value: 'edit', child: Text('Editar')),
                          PopupMenuItem(value: 'toggle', child: Text(cat.activa == 1 ? 'Desactivar' : 'Activar')),
                          const PopupMenuItem(value: 'delete', child: Text('Eliminar')),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
        loading: () => const ShimmerList(),
        error: (e, _) => ErrorBanner(message: 'Error: $e', onRetry: () => ref.invalidate(categoriasStreamProvider)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showForm(BuildContext context, WidgetRef ref, {Categoria? categoria}) {
    showDialog(
      context: context,
      builder: (dialogContext) => _CategoriaFormDialog(categoria: categoria, ref: ref),
    );
  }
}

class _CategoriaFormDialog extends StatefulWidget {
  final Categoria? categoria;
  final WidgetRef ref;

  const _CategoriaFormDialog({this.categoria, required this.ref});

  @override
  State<_CategoriaFormDialog> createState() => _CategoriaFormDialogState();
}

class _CategoriaFormDialogState extends State<_CategoriaFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreCtrl;
  late TextEditingController _descCtrl;

  @override
  void initState() {
    super.initState();
    _nombreCtrl = TextEditingController(text: widget.categoria?.nombre ?? '');
    _descCtrl = TextEditingController(text: widget.categoria?.descripcion ?? '');
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _descCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.categoria != null;

    return AlertDialog(
      title: Text(isEdit ? 'Editar categoría' : 'Nueva categoría'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _nombreCtrl,
              decoration: const InputDecoration(labelText: 'Nombre *'),
              validator: (v) => v == null || v.trim().isEmpty ? 'Campo requerido' : null,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: AppSpacing.md),
            TextFormField(
              controller: _descCtrl,
              decoration: const InputDecoration(labelText: 'Descripción'),
              maxLines: 2,
              textCapitalization: TextCapitalization.sentences,
            ),
          ],
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
        FilledButton(
          onPressed: () async {
            if (!_formKey.currentState!.validate()) return;
            final repo = widget.ref.read(categoriasRepositoryProvider);
            final result = isEdit
                ? await repo.update(
                    id: widget.categoria!.id,
                    nombre: _nombreCtrl.text.trim(),
                    descripcion: _descCtrl.text.trim().isEmpty ? null : _descCtrl.text.trim(),
                  )
                : await repo.insert(
                    nombre: _nombreCtrl.text.trim(),
                    descripcion: _descCtrl.text.trim().isEmpty ? null : _descCtrl.text.trim(),
                  );
            if (context.mounted) {
              if (result.isSuccess) {
                Navigator.pop(context);
                ErrorBanner.success(context, isEdit ? 'Categoría actualizada' : 'Categoría creada');
              } else {
                ErrorBanner.show(context, result.errorMessage);
              }
            }
          },
          child: Text(isEdit ? 'Guardar' : 'Crear'),
        ),
      ],
    );
  }
}
