import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../product/domain/entities/product_entity.dart';
import '../../../product/data/repositories/product_repository_impl.dart';
import '../../../product/presentation/controllers/product_controller.dart';

class AdminAddEditProductScreen extends ConsumerStatefulWidget {
  /// If product == null → Add
  /// If product != null → Edit
  final ProductEntity? product;

  const AdminAddEditProductScreen({super.key, this.product});

  @override
  ConsumerState<AdminAddEditProductScreen> createState() =>
      _AdminAddEditProductScreenState();
}

class _AdminAddEditProductScreenState
    extends ConsumerState<AdminAddEditProductScreen> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameCtrl;
  late final TextEditingController _descCtrl;
  late final TextEditingController _priceCtrl;
  late final TextEditingController _stockCtrl;
  late final TextEditingController _imageCtrl;
  late final TextEditingController _brandCtrl;

  String _category = 'Men';
  final List<String> _categories = const [
    'Men',
    'Women',
    'Electronics',
    'Footwear',
    'Accessories',
  ];

  bool _isLoading = false;
  bool _isFeatured = false;

  @override
  void initState() {
    super.initState();
    final p = widget.product;

    _nameCtrl = TextEditingController(text: p?.name ?? '');
    _descCtrl = TextEditingController(text: p?.description ?? '');
    _priceCtrl = TextEditingController(
      text: p != null ? (p.price / 100).toStringAsFixed(2) : '',
    );
    _stockCtrl = TextEditingController(text: p?.stock.toString() ?? '0');
    _imageCtrl = TextEditingController(
      text: p?.imageUrl ?? 'https://via.placeholder.com/300',
    );
    _brandCtrl = TextEditingController(text: p?.brand ?? '');

    if (p != null && _categories.contains(p.category)) {
      _category = p.category;
    }
    _isFeatured = p?.isFeatured ?? false;
  }

  @override
  void dispose() {
    _nameCtrl.dispose();
    _descCtrl.dispose();
    _priceCtrl.dispose();
    _stockCtrl.dispose();
    _imageCtrl.dispose();
    _brandCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final id =
          widget.product?.id ??
          DateTime.now().millisecondsSinceEpoch.toString();

      /// Convert ₹ → paise
      final pricePaise = (double.parse(_priceCtrl.text) * 100).round();

      final stock = int.parse(_stockCtrl.text);

      final product = ProductEntity(
        id: id,
        name: _nameCtrl.text.trim(),
        description: _descCtrl.text.trim(),
        price: pricePaise,
        originalPrice: null,
        imageUrl: _imageCtrl.text.trim(),
        additionalImages: const [],
        stock: stock,
        category: _category,
        brand: _brandCtrl.text.trim().isEmpty ? null : _brandCtrl.text.trim(),
        rating: widget.product?.rating ?? 0,
        reviewCount: widget.product?.reviewCount ?? 0,
        isFeatured: _isFeatured,
      );

      final repo = ref.read(productRepositoryProvider);

      if (widget.product == null) {
        await repo.createProduct(product);
      } else {
        await repo.updateProduct(product);
      }

      ref.invalidate(featuredProductsProvider);
      ref.invalidate(productsByCategoryProvider('All'));

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Product saved successfully')),
        );
        context.pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.product != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit Product' : 'Add Product')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              _field(_nameCtrl, 'Product Name'),
              const SizedBox(height: 16),

              _field(_descCtrl, 'Description', maxLines: 3),
              const SizedBox(height: 16),

              Row(
                children: [
                  Expanded(
                    child: _field(
                      _priceCtrl,
                      'Price (₹)',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: _field(
                      _stockCtrl,
                      'Stock',
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              DropdownButtonFormField<String>(
                value: _category,
                decoration: const InputDecoration(
                  labelText: 'Category',
                  border: OutlineInputBorder(),
                ),
                items: _categories
                    .map((c) => DropdownMenuItem(value: c, child: Text(c)))
                    .toList(),
                onChanged: (v) => setState(() => _category = v!),
              ),
              const SizedBox(height: 16),

              _field(_brandCtrl, 'Brand (optional)'),
              const SizedBox(height: 16),

              SwitchListTile(
                contentPadding: EdgeInsets.zero,
                title: const Text('Featured Product'),
                value: _isFeatured,
                onChanged: (v) => setState(() => _isFeatured = v),
              ),
              const SizedBox(height: 16),

              _field(_imageCtrl, 'Image URL'),
              const SizedBox(height: 24),

              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: _isLoading ? null : _save,
                  child: _isLoading
                      ? const CircularProgressIndicator(color: Colors.white)
                      : Text(isEdit ? 'Update Product' : 'Create Product'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      maxLines: maxLines,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (v) => v == null || v.trim().isEmpty ? 'Required' : null,
    );
  }
}
