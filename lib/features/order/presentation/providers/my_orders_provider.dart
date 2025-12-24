import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/order_entity.dart';
import '../../data/repositories/order_repository_impl.dart';

part 'my_orders_provider.g.dart';

@riverpod
Future<List<OrderEntity>> myOrders(MyOrdersRef ref) {
  return ref.watch(orderRepositoryProvider).getMyOrders();
}
