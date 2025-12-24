import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../order/domain/entities/order_entity.dart';
import '../../../order/data/repositories/order_repository_impl.dart';

/// ------------------------------------------------------------
/// ADMIN: FETCH ALL ORDERS
/// ------------------------------------------------------------
final adminOrdersProvider =
    FutureProvider.autoDispose<List<OrderEntity>>((ref) {
  return ref.read(orderRepositoryProvider).getAllOrders();
});

class AdminOrdersListScreen extends ConsumerWidget {
  const AdminOrdersListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(adminOrdersProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Orders'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.invalidate(adminOrdersProvider),
          ),
        ],
      ),
      body: ordersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (e, _) => const Center(
          child: Text('Failed to load orders'),
        ),

        data: (orders) {
          if (orders.isEmpty) {
            return const Center(child: Text('No orders yet.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 12),
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
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Items',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),

                          /// ORDER ITEMS (SNAPSHOT)
                          ...order.items.map(
                            (item) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 4),
                              child: Text(
                                '• ${item.quantity} × ${item.name}',
                              ),
                            ),
                          ),

                          const SizedBox(height: 16),

                          const Text(
                            'Update Status',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 8),

                          Wrap(
                            spacing: 8,
                            children: const [
                              'placed',
                              'shipped',
                              'delivered',
                              'cancelled',
                            ].map((status) {
                              return _StatusActionChip(
                                status: status,
                              );
                            }).toList(),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
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
        color: _statusColor(status),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        status.toUpperCase(),
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
    );
  }

  Color _statusColor(String status) {
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
/// STATUS ACTION CHIP
/// ------------------------------------------------------------
class _StatusActionChip extends ConsumerWidget {
  final String status;

  const _StatusActionChip({required this.status});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ActionChip(
      label: Text(status.toUpperCase()),
      onPressed: () async {
        final order = ref
            .read(adminOrdersProvider)
            .maybeWhen(data: (orders) => orders, orElse: () => null);

        if (order == null) return;

        await ref.read(orderRepositoryProvider).updateOrderStatus(
              orderId: order.first.id,
              newStatus: status,
            );

        ref.invalidate(adminOrdersProvider);
      },
    );
  }
}
