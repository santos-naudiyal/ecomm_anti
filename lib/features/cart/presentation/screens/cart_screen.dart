import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../domain/entities/cart_item.dart';
import '../controllers/cart_controller.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartAsync = ref.watch(cartControllerProvider);
    final cartNotifier = ref.read(cartControllerProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: cartAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (items) {
          if (items.isEmpty) {
            return const _EmptyCart();
          }

          return Stack(
            children: [
              /// ---------------- CART ITEMS ----------------
              ListView.builder(
                padding: const EdgeInsets.only(
                  left: AppSpacing.md,
                  right: AppSpacing.md,
                  bottom: 160,
                  top: AppSpacing.md,
                ),
                itemCount: items.length,
                itemBuilder: (context, index) {
                  final item = items[index];
                  return _CartItemCard(
                    item: item,
                    onIncrease: () =>
                        cartNotifier.incrementQuantity(item.product.id),
                    onDecrease: () =>
                        cartNotifier.decrementQuantity(item.product.id),
                    onRemove: () =>
                        cartNotifier.removeFromCart(item.product.id),
                  );
                },
              ),

              /// ---------------- PRICE SUMMARY + CTA ----------------
              _CheckoutSummary(
                subtotal: cartNotifier.subtotal ?? 0,
                deliveryFee: 0,
                total: cartNotifier.totalAmount ?? 0,
                onCheckout: () => context.push('/cart/checkout'),
              ),
            ],
          );
        },
      ),
    );
  }
}

/// ------------------------------------------------------------
/// EMPTY CART
/// ------------------------------------------------------------
class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.shopping_cart_outlined, size: 80),
          const SizedBox(height: 16),
          const Text('Your cart is empty'),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () => context.go('/home'),
            child: const Text('Start Shopping'),
          ),
        ],
      ),
    );
  }
}

/// ------------------------------------------------------------
/// CART ITEM CARD
/// ------------------------------------------------------------
class _CartItemCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback onIncrease;
  final VoidCallback onDecrease;
  final VoidCallback onRemove;

  const _CartItemCard({
    required this.item,
    required this.onIncrease,
    required this.onDecrease,
    required this.onRemove,
  });

  @override
  Widget build(BuildContext context) {
    final int price = item.product.price;

    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                item.product.imageUrl,
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) =>
                    const Icon(Icons.image_not_supported),
              ),
            ),
            const SizedBox(width: AppSpacing.md),

            /// PRODUCT INFO
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: AppTextStyles.body,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '₹${(price / 100).toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),

            /// QUANTITY STEPPER
            Column(
              children: [
                Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.remove_circle_outline),
                      onPressed: onDecrease,
                    ),
                    Text(item.quantity.toString(), style: AppTextStyles.body),
                    IconButton(
                      icon: const Icon(Icons.add_circle_outline),
                      onPressed: onIncrease,
                    ),
                  ],
                ),
                TextButton(
                  onPressed: onRemove,
                  child: const Text(
                    'Remove',
                    style: TextStyle(color: AppColors.error),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// ------------------------------------------------------------
/// CHECKOUT SUMMARY (STICKY)
/// ------------------------------------------------------------
class _CheckoutSummary extends StatelessWidget {
  final int subtotal;
  final int deliveryFee;
  final int total;
  final VoidCallback onCheckout;

  const _CheckoutSummary({
    required this.subtotal,
    required this.deliveryFee,
    required this.total,
    required this.onCheckout,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.08), blurRadius: 10),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _PriceRow('Subtotal', subtotal),
            _PriceRow('Delivery', deliveryFee),
            const Divider(),
            _PriceRow('Total', total, isTotal: true),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: onCheckout,
                child: const Text('Proceed to Checkout'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _PriceRow(String label, int amount, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: isTotal ? AppTextStyles.headingMedium : AppTextStyles.body,
          ),
          Text(
            '₹${(amount / 100).toStringAsFixed(2)}',
            style: isTotal
                ? const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)
                : AppTextStyles.body,
          ),
        ],
      ),
    );
  }
}
