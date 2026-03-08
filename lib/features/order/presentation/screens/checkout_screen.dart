import 'package:antigravity/features/order/presentation/state/order_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../controllers/order_controller.dart';
import '../../../cart/presentation/controllers/cart_controller.dart';
import '../../../cart/presentation/controllers/address_controller.dart';
import '../../../cart/domain/entities/address_entity.dart';
import '../widgets/checkout_address_selector.dart';
import '../widgets/checkout_payment_selector.dart';
import '../widgets/checkout_order_summary.dart';
import '../widgets/payment_inputs.dart'; // Import Payment Inputs
import '../widgets/smart_coupon_widget.dart';
import '../../../../core/payment/payment_service.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  const CheckoutScreen({super.key});

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  AddressEntity? _selectedAddress;
  String _selectedPaymentMethod = 'COD'; // Default
  bool _isProcessingPayment = false;
  bool _isPaymentValid = true; // Default true for COD

  @override
  Widget build(BuildContext context) {
    /// ✅ LISTEN FOR ORDER RESULT
    ref.listen<OrderState>(orderControllerProvider, (prev, next) {
      if (prev?.isPlacingOrder == true &&
          next.isPlacingOrder == false &&
          next.orderId != null) {
        _showSuccessDialog();
        ref.read(orderControllerProvider.notifier).clearOrderResult();
      }

      if (next.failure != null) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(next.failure!.message)));
      }
    });

    final orderState = ref.watch(orderControllerProvider);
    final cartState = ref.watch(cartControllerProvider); // Access cart items
    final addressesAsync = ref.watch(addressControllerProvider);

    // Calculate Invoices
    final cartItems = cartState.value ?? [];
    final subtotal = ref.read(cartControllerProvider.notifier).subtotal;
    const deliveryFee = 4000; // ₹40.00
    final tax = (subtotal * 0.05).toInt(); // 5% Tax
    final totalToPay = subtotal + deliveryFee + tax;

    return Scaffold(
      backgroundColor: Colors.grey.shade50,
      appBar: AppBar(
        title: const Text('Checkout'),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        foregroundColor: Colors.black,
      ),
      body: cartItems.isEmpty
          ? const Center(child: Text("Your cart is empty"))
          : CustomScrollView(
              slivers: [
                const SliverToBoxAdapter(child: SizedBox(height: 20)),

                // 1. ADDRESS SELECTOR
                SliverToBoxAdapter(
                  child: addressesAsync.when(
                    data: (addresses) {
                      if (addresses.isEmpty) {
                        return Center(
                          child: ElevatedButton(
                            onPressed: () => context.push('/add-address'),
                            child: const Text('Add Address'),
                          ),
                        );
                      }
                      // Initialize selection if needed
                      if (_selectedAddress == null && addresses.isNotEmpty) {
                        // Use default or first
                        _selectedAddress = addresses.firstWhere(
                          (a) => a.isDefault,
                          orElse: () => addresses.first,
                        );
                      }

                      return CheckoutAddressSelector(
                        addresses: addresses,
                        selectedAddress: _selectedAddress,
                        onAddressSelected: (addr) {
                          setState(() => _selectedAddress = addr);
                        },
                      );
                    },
                    loading: () =>
                        const Center(child: CircularProgressIndicator()),
                    error: (e, _) =>
                        const Center(child: Text('Error loading addresses')),
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 32)),

                // 2. PAYMENT SELECTOR
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      CheckoutPaymentSelector(
                        selectedMethod: _selectedPaymentMethod,
                        onMethodSelected: (method) {
                          setState(() {
                            _selectedPaymentMethod = method;
                            _isPaymentValid =
                                method == 'COD' ||
                                method ==
                                    'GPay'; // Default valid for simpler methods
                          });
                        },
                      ),
                      if (_selectedPaymentMethod == 'Card')
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          child: CardInputWidget(
                            onValidationChanged: (isValid) {
                              // Only update if changed to avoid unnecessary rebuilds
                              if (_isPaymentValid != isValid) {
                                // Using SchedulerBinding/postFrameCallback usually safe, but simple boolean toggle ok here inside setState in callback
                                // However, we are in build/callback cycle. State management approach is better.
                                // Since this callback happens on form change:
                                WidgetsBinding.instance.addPostFrameCallback((
                                  _,
                                ) {
                                  if (mounted)
                                    setState(() => _isPaymentValid = isValid);
                                });
                              }
                            },
                          ),
                        ),
                      if (_selectedPaymentMethod == 'UPI')
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          child: UPIInputWidget(
                            onValidationChanged: (isValid) {
                              if (_isPaymentValid != isValid) {
                                WidgetsBinding.instance.addPostFrameCallback((
                                  _,
                                ) {
                                  if (mounted)
                                    setState(() => _isPaymentValid = isValid);
                                });
                              }
                            },
                          ),
                        ),
                    ],
                  ),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 32)),

                // SMART COUPON
                SliverToBoxAdapter(
                  child: SmartCouponWidget(subtotal: subtotal),
                ),

                const SliverToBoxAdapter(child: SizedBox(height: 32)),

                // 3. ORDER SUMMARY
                SliverToBoxAdapter(
                  child: CheckoutOrderSummary(
                    items: cartItems,
                    subtotal: subtotal,
                    deliveryFee: deliveryFee,
                    tax: tax,
                  ),
                ),

                const SliverToBoxAdapter(
                  child: SizedBox(height: 100),
                ), // Bottom padding
              ],
            ),
      bottomSheet: cartItems.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    offset: const Offset(0, -4),
                    blurRadius: 16,
                  ),
                ],
              ),
              child: SafeArea(
                child: Row(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total',
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                        Text(
                          '₹${(totalToPay / 100).toStringAsFixed(2)}',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      width: 200,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Theme.of(context).primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                          elevation: 0,
                        ),
                        onPressed:
                            orderState.isPlacingOrder ||
                                _isProcessingPayment ||
                                !_isPaymentValid
                            ? null
                            : () async {
                                if (_selectedAddress == null) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Please select an address'),
                                    ),
                                  );
                                  return;
                                }

                                setState(() => _isProcessingPayment = true);

                                try {
                                  // Process Payment
                                  final txnId = await ref
                                      .read(paymentServiceProvider)
                                      .processPayment(
                                        method: _selectedPaymentMethod,
                                        amount: totalToPay / 100.0,
                                      );

                                  if (txnId != null) {
                                    // If payment success, place order
                                    // Append Txn ID to method or store in backend
                                    // For now appending to method string as quick integration
                                    final methodWithTxn =
                                        '$_selectedPaymentMethod ($txnId)';

                                    if (mounted) {
                                      ref
                                          .read(
                                            orderControllerProvider.notifier,
                                          )
                                          .placeOrder(
                                            addressId: _selectedAddress!.id,
                                            paymentMethod: methodWithTxn,
                                          );
                                    }
                                  }
                                } catch (e) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text('Payment Failed: $e'),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                } finally {
                                  if (mounted) {
                                    setState(
                                      () => _isProcessingPayment = false,
                                    );
                                  }
                                }
                              },
                        child: orderState.isPlacingOrder || _isProcessingPayment
                            ? const SizedBox(
                                height: 24,
                                width: 24,
                                child: CircularProgressIndicator(
                                  color: Colors.white,
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                'Place Order',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void _showSuccessDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            const Icon(Icons.check_circle, color: Colors.green, size: 80),
            const SizedBox(height: 24),
            const Text(
              'Order Placed!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(
              'Your order has been successfully placed. You can track it in the orders section.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey.shade600),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                  context.go('/home');
                },
                child: const Text('Continue Shopping'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
