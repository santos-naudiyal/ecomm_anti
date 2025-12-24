import 'package:antigravity/core/errors/app_failure.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/product_entity.dart';
import '../controllers/product_controller.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_loading_view.dart';

class ProductListScreen extends ConsumerStatefulWidget {
  const ProductListScreen({super.key});

  @override
  ConsumerState<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends ConsumerState<ProductListScreen> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productsAsync = ref.watch(featuredProductsProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('All Products')),
      body: Column(
        children: [
          _SearchBar(
            controller: _searchController,
            onChanged: () => setState(() {}),
          ),
          Expanded(
            child: productsAsync.when(
              loading: () =>
                  const AppLoadingView(message: 'Loading products...'),

              error: (error, _) => AppErrorView(
                failure: error is AppFailure
                    ? error
                    : AppFailure.fromException(error),
                onRetry: () =>
                    ref.read(featuredProductsProvider.notifier).refresh(),
              ),

              data: (products) {
                final filtered = _filterProducts(
                  products,
                  _searchController.text,
                );

                if (filtered.isEmpty) {
                  return const Center(child: Text('No products found'));
                }

                return GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.7,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final product = filtered[index];

                    return GestureDetector(
                      onTap: () =>
                          context.push('/explore/product/${product.id}'),
                      child: _ProductCard(product: product),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<ProductEntity> _filterProducts(
    List<ProductEntity> products,
    String query,
  ) {
    if (query.isEmpty) return products;

    final lowerQuery = query.toLowerCase();

    return products
        .where((p) => p.name.toLowerCase().contains(lowerQuery))
        .toList();
  }
}

/// ------------------------------------------------------------
/// SEARCH BAR (EXTRACTED WIDGET)
/// ------------------------------------------------------------
class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  final VoidCallback onChanged;

  const _SearchBar({required this.controller, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: TextField(
        controller: controller,
        onChanged: (_) => onChanged(),
        decoration: InputDecoration(
          hintText: 'Search products...',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// PRODUCT CARD
/// ------------------------------------------------------------
class _ProductCard extends StatelessWidget {
  final ProductEntity product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [
          BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(12),
              ),
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (_, __, ___) =>
                    const Center(child: Icon(Icons.broken_image)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                Text(
                  '₹${(product.price / 100).toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Color(0xFF1A237E),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
