import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../database/app_database.dart';
import '../../providers/database_provider.dart';
import '../../theme/spacing.dart';
import '../shared/dialogs/confirm_dialog.dart';
import '../shared/widgets/empty_state.dart';
import '../shared/widgets/error_banner.dart';
import '../shared/widgets/shimmer_loading.dart';

class ProveedoresScreen extends ConsumerWidget {
  const ProveedoresScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final proveedoresAsync = ref.watch(proveedoresStreamProvider);
    final repo = ref.watch(proveedoresRepositoryProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Proveedores')),
      body: proveedoresAsync.when(
        data: (proveedores) {
          if (proveedores.isEmpty) {
            return EmptyState(
              icon: Icons.local_shipping_outlined,
              title: 'Sin proveedores',
              subtitle: 'Agrega proveedores para registrar compras',
              action: FilledButton.icon(
                onPressed: () => _showForm(context, ref),
                icon: const Icon(Icons.add),
                label: const Text('Nuevo proveedor'),
              ),
            );
          }

          return ListView.builder(
            itemCount: proveedores.length,
            itemBuilder: (context, index) {
              final prov = proveedores[index];
              return Card(
                margin: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.xs),
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: prov.activo == 1
                        ? Theme.of(context).colorScheme.primaryContainer
                        : Theme.of(context).colorScheme.surfaceContainerHighest,
                    child: Icon(Icons.local_shipping, color: prov.activo == 1
                        ? Theme.of(context).colorScheme.onPrimaryContainer
                        : Theme.of(context).colorScheme.outline),
                  ),
                  title: Text(prov.nombre),
                  subtitle: _buildSubtitle(prov),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (prov.activo == 0)
                        IconButton(
                          icon: Icon(Icons.restore, color: Theme.of(context).colorScheme.tertiary),
                          onPressed: () => repo.toggleActive(prov.id, true),
                        ),
                      PopupMenuButton<String>(
                        icon: const Icon(Icons.more_vert, size: 20),
                        onSelected: (value) async {
                          switch (value) {
                            case 'edit':
                              _showForm(context, ref, proveedor: prov);
                            case 'toggle':
                              await repo.toggleActive(prov.id, prov.activo != 1);
                            case 'delete':
                              final confirm = await showConfirmDialog(
                                context: context,
                                title: 'Eliminar proveedor',
                                message: '¿Estás seguro de eliminar "${prov.nombre}"?',
                              );
                              if (confirm) {
                                final result = await repo.delete(prov.id);
                                if (result.isFailure && context.mounted) {
                                  ErrorBanner.show(context, result.errorMessage);
                                }
                              }
                          }
                        },
                        itemBuilder: (context) => [
                          const PopupMenuItem(value: 'edit', child: Text('Editar')),
                          PopupMenuItem(value: 'toggle', child: Text(prov.activo == 1 ? 'Desactivar' : 'Activar')),
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
        error: (e, _) => ErrorBanner(message: 'Error: $e', onRetry: () => ref.invalidate(proveedoresStreamProvider)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showForm(context, ref),
        child: const Icon(Icons.add),
      ),
    );
  }

  static Widget _buildSubtitle(Proveedore prov) {
    final parts = <Widget>[];
    if (prov.contacto != null && prov.contacto!.isNotEmpty) {
      parts.add(Text('Contacto: ${prov.contacto}'));
    }
    if (prov.telefono != null && prov.telefono!.isNotEmpty) {
      parts.add(Text('Tel: ${prov.telefono}'));
    }
    if (parts.isEmpty) {
      parts.add(const Text('Sin datos de contacto'));
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: parts,
    );
  }

  void _showForm(BuildContext context, WidgetRef ref, {Proveedore? proveedor}) {
    showDialog(
      context: context,
      builder: (dialogContext) => _ProveedorFormDialog(proveedor: proveedor, ref: ref),
    );
  }
}

class _ProveedorFormDialog extends StatefulWidget {
  final Proveedore? proveedor;
  final WidgetRef ref;

  const _ProveedorFormDialog({this.proveedor, required this.ref});

  @override
  State<_ProveedorFormDialog> createState() => _ProveedorFormDialogState();
}

class _ProveedorFormDialogState extends State<_ProveedorFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nombreCtrl;
  late TextEditingController _contactoCtrl;
  late TextEditingController _telefonoCtrl;
  late TextEditingController _emailCtrl;
  late TextEditingController _direccionCtrl;

  @override
  void initState() {
    super.initState();
    _nombreCtrl = TextEditingController(text: widget.proveedor?.nombre ?? '');
    _contactoCtrl = TextEditingController(text: widget.proveedor?.contacto ?? '');
    _telefonoCtrl = TextEditingController(text: widget.proveedor?.telefono ?? '');
    _emailCtrl = TextEditingController(text: widget.proveedor?.email ?? '');
    _direccionCtrl = TextEditingController(text: widget.proveedor?.direccion ?? '');
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _contactoCtrl.dispose();
    _telefonoCtrl.dispose();
    _emailCtrl.dispose();
    _direccionCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.proveedor != null;

    return AlertDialog(
      title: Text(isEdit ? 'Editar proveedor' : 'Nuevo proveedor'),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nombreCtrl,
                decoration: const InputDecoration(labelText: 'Nombre *'),
                validator: (v) => v == null || v.trim().isEmpty ? 'Campo requerido' : null,
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _contactoCtrl,
                decoration: const InputDecoration(labelText: 'Contacto'),
                textCapitalization: TextCapitalization.words,
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _telefonoCtrl,
                decoration: const InputDecoration(labelText: 'Teléfono'),
                keyboardType: TextInputType.phone,
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _emailCtrl,
                decoration: const InputDecoration(labelText: 'Email'),
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _direccionCtrl,
                decoration: const InputDecoration(labelText: 'Dirección'),
                maxLines: 2,
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancelar')),
        FilledButton(
          onPressed: () async {
            if (!_formKey.currentState!.validate()) return;
            final repo = widget.ref.read(proveedoresRepositoryProvider);
            final result = isEdit
                ? await repo.update(
                    id: widget.proveedor!.id,
                    nombre: _nombreCtrl.text.trim(),
                    contacto: _contactoCtrl.text.trim().isEmpty ? null : _contactoCtrl.text.trim(),
                    telefono: _telefonoCtrl.text.trim().isEmpty ? null : _telefonoCtrl.text.trim(),
                    email: _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(),
                    direccion: _direccionCtrl.text.trim().isEmpty ? null : _direccionCtrl.text.trim(),
                  )
                : await repo.insert(
                    nombre: _nombreCtrl.text.trim(),
                    contacto: _contactoCtrl.text.trim().isEmpty ? null : _contactoCtrl.text.trim(),
                    telefono: _telefonoCtrl.text.trim().isEmpty ? null : _telefonoCtrl.text.trim(),
                    email: _emailCtrl.text.trim().isEmpty ? null : _emailCtrl.text.trim(),
                    direccion: _direccionCtrl.text.trim().isEmpty ? null : _direccionCtrl.text.trim(),
                  );
            if (context.mounted) {
              if (result.isSuccess) {
                Navigator.pop(context);
                ErrorBanner.success(context, isEdit ? 'Proveedor actualizado' : 'Proveedor creado');
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
