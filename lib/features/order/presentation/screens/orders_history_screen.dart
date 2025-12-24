import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../providers/my_orders_provider.dart';
import '../../domain/entities/order_entity.dart';
import '../../domain/services/invoice_service.dart';
import '../../../cart/presentation/controllers/address_controller.dart';

class OrdersHistoryScreen extends ConsumerWidget {
  const OrdersHistoryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ordersAsync = ref.watch(myOrdersProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Orders')),
      body: ordersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),

        error: (e, _) => Center(child: Text('Failed to load orders')),

        data: (orders) {
          if (orders.isEmpty) {
            return const Center(child: Text('No orders found'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final OrderEntity order = orders[index];

              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: ExpansionTile(
                  title: Text(
                    'Order #${_shortOrderId(order.id)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${DateFormat('MMM d, yyyy').format(order.createdAt)}'
                    '\nStatus: ${order.status.toUpperCase()}'
                    '\nTotal: ₹${(order.totalAmount / 100).toStringAsFixed(2)}',
                  ),
                  children: [
                    ...order.items.map((item) {
                      return ListTile(
                        leading: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Image.network(
                            item.imageUrl,
                            width: 48,
                            height: 48,
                            fit: BoxFit.cover,
                            errorBuilder: (_, __, ___) =>
                                const Icon(Icons.image_not_supported),
                          ),
                        ),
                        title: Text(item.name),
                        subtitle: Text('Qty: ${item.quantity}'),
                        trailing: Text(
                          '₹${((item.price * item.quantity) / 100).toStringAsFixed(2)}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      );
                    }),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8.0,
                      ),
                      child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton.icon(
                          onPressed: () async {
                            final addresses =
                                ref
                                    .read(addressControllerProvider)
                                    .valueOrNull ??
                                [];
                            final address = addresses.firstWhere(
                              (a) => a.id == order.addressId,
                              orElse: () =>
                                  throw Exception('Address not found'),
                            );

                            try {
                              await ref
                                  .read(invoiceServiceProvider)
                                  .generateAndDownloadInvoice(
                                    order: order,
                                    address: address,
                                  );
                            } catch (e) {
                              if (context.mounted) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      'Could not generate invoice: $e',
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                          icon: const Icon(Icons.download),
                          label: const Text('Download Invoice'),
                        ),
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

  String _shortOrderId(String id) {
    return id.length > 6 ? id.substring(id.length - 6) : id;
  }
}
