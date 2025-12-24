import 'package:antigravity/core/errors/app_failure.dart';
import 'package:antigravity/features/order/presentation/state/order_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/order_entity.dart';
import '../../data/repositories/order_repository_impl.dart';

part 'order_controller.g.dart';

@riverpod
class OrderController extends _$OrderController {
  @override
  OrderState build() {
    return const OrderState();
  }

  /// PLACE ORDER (SAFE)
  Future<void> placeOrder({
    required String addressId,
    required String paymentMethod,
  }) async {
    if (state.isPlacingOrder) return; // 🔒 prevent double tap

    state = state.copyWith(isPlacingOrder: true, failure: null);

    try {
      final orderId = await ref
          .read(orderRepositoryProvider)
          .placeOrder(addressId: addressId, paymentMethod: paymentMethod);

      state = state.copyWith(isPlacingOrder: false, orderId: orderId);

      // refresh order list
      await fetchMyOrders();
    } catch (e, stack) {
      // 🐞 DEBUGGING: Print the exact error
      print('🔴 ORDER FAILURE: $e');
      print('🔴 STACK TRACE: $stack');

      state = state.copyWith(
        isPlacingOrder: false,
        failure: AppFailure.fromException(e),
      );
    }
  }

  /// FETCH ORDERS
  Future<void> fetchMyOrders() async {
    try {
      final orders = await ref.read(orderRepositoryProvider).getMyOrders();
      state = state.copyWith(orders: orders);
    } catch (e) {
      state = state.copyWith(failure: AppFailure.fromException(e));
    }
  }

  void clearOrderResult() {
    state = state.copyWith(orderId: null);
  }
}
