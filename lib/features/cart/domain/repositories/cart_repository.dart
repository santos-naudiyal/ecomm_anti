import '../entities/cart_item.dart';

abstract class CartRepository {
  Stream<List<CartItem>> watchCart();
  Future<void> addToCart(CartItem item);
  Future<void> removeFromCart(String productId);
  Future<void> updateQuantity(String productId, int quantity);
  Future<void> clearCart();
}
