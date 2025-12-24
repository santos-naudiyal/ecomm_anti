import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pay/pay.dart';

class PaymentService {
  late final Pay _payClient; // In real app, initialize with profiles

  // Real world: You would fetch this from a secure backend
  // final _paymentItems = ... (unused for now)

  /// Initialize Payment Clients (Google Pay / Apple Pay)
  Future<void> initialize() async {
    try {
      // Use PaymentConfiguration.fromAsset to avoid Pay.withAssets/fromAsset ambiguity
      final gpayConfig = await PaymentConfiguration.fromAsset(
        'payment_configurations/gpay.json',
      );
      _payClient = Pay({PayProvider.google_pay: gpayConfig});
    } catch (e) {
      print('Error initializing PaymentService: $e');
    }
  }

  /// Process Payment based on method
  /// Returns Transaction ID if successful, null otherwise
  Future<String?> processPayment({
    required String method, // 'COD', 'UPI', 'Card', 'GPay'
    required double amount,
  }) async {
    try {
      switch (method) {
        case 'COD':
          return 'COD-${DateTime.now().millisecondsSinceEpoch}';

        case 'UPI':
          // SIMULATED UPI FLOW
          await Future.delayed(const Duration(seconds: 2));
          // Randomize success/failure for realism if desired, but for now Success
          return 'UPI-${DateTime.now().millisecondsSinceEpoch}';

        case 'Card':
          // SIMULATED CARD FLOW
          await Future.delayed(const Duration(seconds: 3));
          return 'CARD-${DateTime.now().millisecondsSinceEpoch}';

        case 'GPay':
          // GOOGLE PAY FLOW
          if (await isGPayAvailable) {
            try {
              final result = await _payClient
                  .showPaymentSelector(PayProvider.google_pay, [
                    PaymentItem(
                      label: 'Order Total',
                      amount: amount.toStringAsFixed(2),
                      status: PaymentItemStatus.final_price,
                    ),
                  ]);
              print('GPay Result: $result');
              // In real implementation, handle result
              return 'GPAY-${DateTime.now().millisecondsSinceEpoch}';
            } catch (e) {
              print('GPay Error: $e');
              // Fallback or user release
              if (e.toString().contains('Canceled')) return null;
              rethrow;
            }
          } else {
            throw Exception('Google Pay is not available on this device');
          }

        default:
          throw Exception('Unknown payment method');
      }
    } catch (e) {
      print('Payment Failed: $e');
      rethrow;
    }
  }

  /// Check if Google Pay is available
  Future<bool> get isGPayAvailable async {
    try {
      return await _payClient.userCanPay(PayProvider.google_pay);
    } catch (e) {
      return false;
    }
  }
}

// Singleton Provider
final paymentServiceProvider = Provider<PaymentService>((ref) {
  return PaymentService();
});
