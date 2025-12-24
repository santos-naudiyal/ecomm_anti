import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/product_entity.dart';
import '../controllers/product_controller.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../cart/presentation/controllers/cart_controller.dart';

class ProductDetailsScreen extends ConsumerWidget {
  final String productId;

  const ProductDetailsScreen({super.key, required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productDetailsProvider(productId));

    return Scaffold(
      body: productAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Center(child: Text('Failed to load product')),
        data: (product) {
          if (product == null) {
            return const Center(child: Text('Product not found'));
          }

          return Stack(
            children: [
              /// MAIN CONTENT
              CustomScrollView(
                slivers: [
                  _ProductImageSliver(product: product),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      child: _ProductInfo(product: product),
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 120)),
                ],
              ),

              /// STICKY BOTTOM CTA
              _BottomCTA(product: product),
            ],
          );
        },
      ),
    );
  }
}

/// ------------------------------------------------------------
/// IMAGE SLIVER
/// ------------------------------------------------------------
class _ProductImageSliver extends StatelessWidget {
  final ProductEntity product;

  const _ProductImageSliver({required this.product});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 360,
      pinned: true,
      backgroundColor: AppColors.surface,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => context.pop(),
      ),
      flexibleSpace: FlexibleSpaceBar(
        background: Image.network(
          product.imageUrl,
          fit: BoxFit.cover,
          errorBuilder: (_, __, ___) =>
              const Icon(Icons.image_not_supported, size: 64),
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// PRODUCT INFO
/// ------------------------------------------------------------
class _ProductInfo extends StatelessWidget {
  final ProductEntity product;

  const _ProductInfo({required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(product.name, style: AppTextStyles.headingLarge),
        const SizedBox(height: AppSpacing.sm),

        Text(
          '₹${(product.price / 100).toStringAsFixed(2)}',
          style: const TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),

        const SizedBox(height: AppSpacing.md),

        _InfoRow(icon: Icons.local_shipping, text: 'Free Delivery'),
        _InfoRow(icon: Icons.verified, text: '100% Genuine Product'),

        const SizedBox(height: AppSpacing.lg),

        Text('Description', style: AppTextStyles.headingMedium),
        const SizedBox(height: AppSpacing.sm),

        Text(
          product.description ?? 'No description available',
          style: AppTextStyles.bodySecondary,
        ),
      ],
    );
  }
}

/// ------------------------------------------------------------
/// BOTTOM CTA
/// ------------------------------------------------------------
class _BottomCTA extends ConsumerWidget {
  final ProductEntity product;

  const _BottomCTA({required this.product});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartNotifier = ref.read(cartControllerProvider.notifier);

    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10),
          ],
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton(
                onPressed: () {
                  cartNotifier.addToCart(product);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Added to cart')),
                  );
                },
                child: const Text('Add to Cart'),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  cartNotifier.addToCart(product);
                  context.push('/cart');
                },
                child: const Text('Buy Now'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// SMALL INFO ROW
/// ------------------------------------------------------------
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String text;

  const _InfoRow({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Icon(icon, size: 18, color: AppColors.primary),
          const SizedBox(width: 8),
          Text(text, style: AppTextStyles.body),
        ],
      ),
    );
  }
}
