import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../database/app_database.dart';
import '../../notifiers/productos_notifier.dart';
import '../../providers/database_provider.dart';
import '../shared/widgets/error_banner.dart';

class ProductoFormScreen extends ConsumerStatefulWidget {
  final int? productoId;

  const ProductoFormScreen({super.key, this.productoId});

  @override
  ConsumerState<ProductoFormScreen> createState() => _ProductoFormScreenState();
}

class _ProductoFormScreenState extends ConsumerState<ProductoFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nombreCtrl;
  late final TextEditingController _descripcionCtrl;
  late final TextEditingController _margenCtrl;
  late final TextEditingController _stockMinimoCtrl;
  int? _categoriaId;

  @override
  void initState() {
    super.initState();
    _nombreCtrl = TextEditingController();
    _descripcionCtrl = TextEditingController();
    _margenCtrl = TextEditingController();
    _stockMinimoCtrl = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadProduct());
  }

  void _loadProduct() async {
    if (widget.productoId == null) return;
    final dao = ref.read(productosDaoProvider);
    final product = await dao.getById(widget.productoId!);
    if (product != null && mounted) {
      _nombreCtrl.text = product.nombre;
      _descripcionCtrl.text = product.descripcion ?? '';
      _margenCtrl.text = product.margenGananciaPct.toStringAsFixed(1);
      _stockMinimoCtrl.text = product.stockMinimo.toStringAsFixed(0);
      setState(() {
        _categoriaId = product.categoriaId;
      });
    }
  }

  @override
  void dispose() {
    _nombreCtrl.dispose();
    _descripcionCtrl.dispose();
    _margenCtrl.dispose();
    _stockMinimoCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productosNotifierProvider);
    final notifier = ref.read(productosNotifierProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.productoId == null ? 'Nuevo Producto' : 'Editar Producto'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: _nombreCtrl,
              decoration: const InputDecoration(labelText: 'Nombre *'),
              validator: (v) => v == null || v.isEmpty ? 'Campo requerido' : null,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descripcionCtrl,
              decoration: const InputDecoration(labelText: 'Descripción'),
              maxLines: 2,
            ),
            const SizedBox(height: 16),
            StreamBuilder<List<Categoria>>(
              stream: ref.watch(categoriasRepositoryProvider).watchAll(),
              builder: (context, snapshot) {
                final categorias = snapshot.data ?? [];
                final validId = _categoriaId != null && categorias.any((c) => c.id == _categoriaId) ? _categoriaId : null;
                return DropdownButtonFormField<int?>(
                  initialValue: validId,
                  decoration: const InputDecoration(labelText: 'Categoría *'),
                  items: categorias.map((c) => DropdownMenuItem(value: c.id, child: Text(c.nombre))).toList(),
                  onChanged: (v) => setState(() => _categoriaId = v),
                  validator: (v) => v == null ? 'Selecciona una categoría' : null,
                );
              },
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _margenCtrl,
                    decoration: const InputDecoration(labelText: 'Margen ganancia (%)'),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: TextFormField(
                    controller: _stockMinimoCtrl,
                    decoration: const InputDecoration(labelText: 'Stock mínimo'),
                    keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: state.actionState.maybeWhen(
                loading: () => null,
                orElse: () => () async {
                  if (_formKey.currentState!.validate() && _categoriaId != null) {
                    final result = widget.productoId != null
                        ? await notifier.update(
                            id: widget.productoId!,
                            nombre: _nombreCtrl.text.trim(),
                            categoriaId: _categoriaId!,
                            descripcion: _descripcionCtrl.text.trim().isEmpty ? null : _descripcionCtrl.text.trim(),
                            margenGananciaPct: double.tryParse(_margenCtrl.text) ?? 0,
                            stockMinimo: double.tryParse(_stockMinimoCtrl.text) ?? 0,
                          )
                        : await notifier.create(
                            nombre: _nombreCtrl.text.trim(),
                            categoriaId: _categoriaId!,
                            descripcion: _descripcionCtrl.text.trim().isEmpty ? null : _descripcionCtrl.text.trim(),
                            margenGananciaPct: double.tryParse(_margenCtrl.text) ?? 0,
                            stockMinimo: double.tryParse(_stockMinimoCtrl.text) ?? 0,
                          );
                    if (result.isSuccess && context.mounted) {
                      context.pop();
                    } else if (result.isFailure && context.mounted) {
                      ErrorBanner.show(context, result.errorMessage);
                    }
                  }
                },
              ),
              icon: const Icon(Icons.save),
              label: const Text('GUARDAR'),
            ),
          ],
        ),
      ),
    );
  }
}
