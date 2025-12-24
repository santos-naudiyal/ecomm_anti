import 'package:antigravity/features/order/domain/entities/order_entity.dart';
import 'package:antigravity/features/order/presentation/providers/my_orders_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:go_router/go_router.dart';

import '../../../cart/presentation/controllers/cart_controller.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/app_text_styles.dart';

class OrdersScreen extends ConsumerWidget {
  const OrdersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(myOrdersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: ordersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) =>
            const Center(child: Text('Failed to load orders')),
        data: (orders) {
          if (orders.isEmpty) {
            return const _EmptyOrders();
          }

          return ListView.builder(
            padding: const EdgeInsets.all(AppSpacing.md),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return _OrderCard(order: order);
            },
          );
        },
      ),
    );
  }
}

/// ------------------------------------------------------------
/// EMPTY STATE
/// ------------------------------------------------------------
class _EmptyOrders extends StatelessWidget {
  const _EmptyOrders();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.receipt_long, size: 72),
          const SizedBox(height: AppSpacing.md),
          const Text('No orders yet'),
          const SizedBox(height: AppSpacing.md),
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
/// ORDER CARD
/// ------------------------------------------------------------
class _OrderCard extends ConsumerWidget {
  final OrderEntity order;

  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: ExpansionTile(
        title: Text(
          'Order #${_shortId(order.id)}',
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          '${DateFormat('MMM d, yyyy').format(order.createdAt)}'
          '\nTotal: ₹${(order.totalAmount / 100).toStringAsFixed(2)}',
        ),
        trailing: _StatusBadge(status: order.status),
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// TIMELINE
                _OrderTimeline(status: order.status),

                const SizedBox(height: AppSpacing.lg),

                /// ITEMS
                 Text(
                  'Items',
                  style: AppTextStyles.headingMedium,
                ),
                const SizedBox(height: AppSpacing.sm),

                ...order.items.map(
                  (item) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            item.imageUrl,
                            width: 40,
                            height: 40,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.image_not_supported),
                          ),
                        ),
                        const SizedBox(width: AppSpacing.md),
                        Expanded(
                          child: Text(
                            '${item.quantity} × ${item.name}',
                            style: AppTextStyles.body,
                          ),
                        ),
                        Text(
                          '₹${((item.price * item.quantity) / 100).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.lg),

                /// REORDER
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: () {
                      final cartNotifier =
                          ref.read(cartControllerProvider.notifier);

                      for (final item in order.items) {
                        cartNotifier.addItemFromOrder(item);
                      }

                      context.push('/cart');
                    },
                    child: const Text('Reorder'),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _shortId(String id) {
    return id.length > 6 ? id.substring(id.length - 6) : id;
  }
}

/// ------------------------------------------------------------
/// STATUS BADGE
/// ------------------------------------------------------------
class _StatusBadge extends StatelessWidget {
  final String status;

  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: _colorForStatus(status),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status.toUpperCase(),
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  Color _colorForStatus(String status) {
    switch (status) {
      case 'placed':
        return Colors.blue;
      case 'shipped':
        return Colors.orange;
      case 'delivered':
        return Colors.green;
      case 'cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}

/// ------------------------------------------------------------
/// ORDER TIMELINE
/// ------------------------------------------------------------
class _OrderTimeline extends StatelessWidget {
  final String status;

  const _OrderTimeline({required this.status});

  @override
  Widget build(BuildContext context) {
    final steps = ['placed', 'shipped', 'delivered'];
    final currentIndex =
        steps.indexOf(status).clamp(0, steps.length - 1);

    return Row(
      children: List.generate(steps.length, (index) {
        final isCompleted = index <= currentIndex;

        return Expanded(
          child: Column(
            children: [
              Container(
                height: 4,
                color: isCompleted
                    ? AppColors.primary
                    : AppColors.border,
              ),
              const SizedBox(height: 6),
              Text(
                steps[index].toUpperCase(),
                style: TextStyle(
                  fontSize: 11,
                  color: isCompleted
                      ? AppColors.primary
                      : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
