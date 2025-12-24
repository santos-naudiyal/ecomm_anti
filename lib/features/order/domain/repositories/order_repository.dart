import '../entities/order_entity.dart';

abstract class OrderRepository {
  /// ------------------------------------------------------------
  /// USER: PLACE ORDER (SAFE & TRANSACTIONAL)
  /// ------------------------------------------------------------
  Future<String> placeOrder({
    required String addressId,
    required String paymentMethod,
  });

  /// ------------------------------------------------------------
  /// USER: GET MY ORDERS
  /// ------------------------------------------------------------
  Future<List<OrderEntity>> getMyOrders();

  /// ------------------------------------------------------------
  /// ADMIN: GET ALL ORDERS
  /// ------------------------------------------------------------
  Future<List<OrderEntity>> getAllOrders();

  /// ------------------------------------------------------------
  /// ADMIN: UPDATE ORDER STATUS
  /// ------------------------------------------------------------
  Future<void> updateOrderStatus({
    required String orderId,
    required String newStatus,
  });
}
