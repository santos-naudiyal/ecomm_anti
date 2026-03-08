import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/cart_item.dart';
import '../../../product/domain/entities/product_entity.dart';
import '../../data/repositories/cart_repository_impl.dart';
import '../../../order/domain/entities/order_entity.dart';
import '../../../product/domain/services/trending_service.dart';

part 'cart_controller.g.dart';

@Riverpod(keepAlive: true)
class CartController extends _$CartController {
  @override
  Stream<List<CartItem>> build() {
    return ref.watch(cartRepositoryProvider).watchCart();
  }

  /// ------------------------------------------------------------
  /// ADD PRODUCT TO CART
  /// ------------------------------------------------------------
  Future<void> addToCart(ProductEntity product) async {
    final items = state.value ?? [];

    final existing = items.firstWhere(
      (item) => item.product.id == product.id,
      orElse: () => CartItem.empty(),
    );

    if (existing.id.isNotEmpty) {
      await incrementQuantity(product.id);
    } else {
      final newItem = CartItem(
        id: product.id, // stable ID
        product: product,
        quantity: 1,
      );
      await ref.read(cartRepositoryProvider).addToCart(newItem);
    }
  }

  /// ------------------------------------------------------------
  /// REMOVE ITEM
  /// ------------------------------------------------------------
  Future<void> removeFromCart(String productId) async {
    await ref.read(cartRepositoryProvider).removeFromCart(productId);
  }

  /// ------------------------------------------------------------
  /// INCREMENT / DECREMENT
  /// ------------------------------------------------------------
  Future<void> incrementQuantity(String productId) async {
    final items = state.value ?? [];
    final item = items.firstWhere(
      (i) => i.product.id == productId,
    );

    await ref
        .read(cartRepositoryProvider)
        .updateQuantity(productId, item.quantity + 1);

    // Track trending activity
    ref.read(trendingServiceProvider.notifier).trackActivity(
      productId: productId,
      type: TrendingActivityType.addToCart,
      location: 'Mumbai',
    );
  }

  Future<void> decrementQuantity(String productId) async {
    final items = state.value ?? [];
    final item = items.firstWhere(
      (i) => i.product.id == productId,
    );

    if (item.quantity <= 1) {
      await removeFromCart(productId);
    } else {
      await ref
          .read(cartRepositoryProvider)
          .updateQuantity(productId, item.quantity - 1);
    }
  }

  /// ------------------------------------------------------------
  /// REORDER SUPPORT (FROM ORDER SNAPSHOT)
  /// ------------------------------------------------------------
  Future<void> addItemFromOrder(OrderItem item) async {
    final product = ProductEntity(
      id: item.productId,
      name: item.name,
      price: item.price, // int (paise)
      imageUrl: item.imageUrl,
      category: item.category ?? 'general',
      stock: 999, // assume available (validated at checkout)
      description: null,
      brand: null,
      additionalImages: const [],
      originalPrice: null,
      rating: 0,
      reviewCount: 0,
      isFeatured: false,
    );

    final items = state.value ?? [];

    final existing = items.firstWhere(
      (i) => i.product.id == product.id,
      orElse: () => CartItem.empty(),
    );

    if (existing.id.isNotEmpty) {
      await ref.read(cartRepositoryProvider).updateQuantity(
            product.id,
            existing.quantity + item.quantity,
          );
    } else {
      final newItem = CartItem(
        id: product.id,
        product: product,
        quantity: item.quantity,
      );
      await ref.read(cartRepositoryProvider).addToCart(newItem);
    }
  }

  /// ------------------------------------------------------------
  /// PRICE CALCULATIONS (INT – PAISE)
  /// ------------------------------------------------------------
  int get subtotal {
    return state.value?.fold<int>(
          0,
          (sum, item) =>
              sum + (item.product.price * item.quantity),
        ) ??
        0;
  }

  int get totalAmount => subtotal; // tax / delivery later

  /// ------------------------------------------------------------
  /// CLEAR CART
  /// ------------------------------------------------------------
  Future<void> clearCart() async {
    await ref.read(cartRepositoryProvider).clearCart();
  }
}
