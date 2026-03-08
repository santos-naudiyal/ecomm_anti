import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../controllers/wishlist_controller.dart';
import '../controllers/product_controller.dart';

class WishlistScreen extends ConsumerWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final wishlistAsync = ref.watch(wishlistControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Collection'),
        actions: [
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {
              final link = ref.read(wishlistControllerProvider.notifier).getShareableLink();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Link copied: $link')),
              );
            },
          ),
        ],
      ),
      body: wishlistAsync.when(
        data: (ids) {
          if (ids.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.favorite_border, size: 64, color: Colors.grey[400]),
                  const SizedBox(height: 16),
                  Text('Your wishlist is empty', style: AppTextStyles.headingMedium),
                  const SizedBox(height: 8),
                  Text('Start adding products you love!', style: AppTextStyles.bodySecondary),
                ],
              ),
            );
          }

          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: 0.75,
            ),
            itemCount: ids.length,
            itemBuilder: (context, index) {
              return _WishlistItem(productId: ids[index]);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }
}

class _WishlistItem extends ConsumerWidget {
  final String productId;
  const _WishlistItem({required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productDetailsProvider(productId));

    return productAsync.when(
      data: (product) {
        if (product == null) return const SizedBox.shrink();
        return GestureDetector(
          onTap: () => context.push('/product/${product.id}'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        product.imageUrl,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: IconButton(
                        icon: const Icon(Icons.favorite, color: AppColors.error),
                        onPressed: () => ref.read(wishlistControllerProvider.notifier).toggleWishlist(product),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 8),
              Text(
                product.name,
                style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '₹${(product.price / 100).toStringAsFixed(0)}',
                style: AppTextStyles.body.copyWith(color: AppColors.primary),
              ),
            ],
          ),
        );
      },
      loading: () => Container(color: Colors.grey[200]),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}
