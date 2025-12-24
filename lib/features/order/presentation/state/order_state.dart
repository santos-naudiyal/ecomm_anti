import 'package:antigravity/core/errors/app_failure.dart';

import '../../domain/entities/order_entity.dart';

class OrderState {
  final bool isPlacingOrder;
  final AppFailure? failure;
  final String? orderId;
  final List<OrderEntity> orders;

  const OrderState({
    this.isPlacingOrder = false,
    this.failure,
    this.orderId,
    this.orders = const [],
  });

  OrderState copyWith({
    bool? isPlacingOrder,
    AppFailure? failure,
    String? orderId,
    List<OrderEntity>? orders,
  }) {
    return OrderState(
      isPlacingOrder: isPlacingOrder ?? this.isPlacingOrder,
      failure: failure,
      orderId: orderId,
      orders: orders ?? this.orders,
    );
  }
}
