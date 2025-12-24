import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/cart_item.dart';
import '../../domain/repositories/cart_repository.dart';

part 'cart_repository_impl.g.dart';

class CartRepositoryImpl implements CartRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _uid => _auth.currentUser?.uid ?? '';

  CollectionReference<Map<String, dynamic>> _getCartCollection() {
    if (_uid.isEmpty) {
      throw Exception('User must be logged in to access cart');
    }
    return _firestore.collection('users').doc(_uid).collection('cartItems');
  }

  @override
  Stream<List<CartItem>> watchCart() {
    if (_uid.isEmpty) return Stream.value([]);

    return _getCartCollection().snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => CartItem.fromJson(doc.data())).toList();
    });
  }

  @override
  Future<void> addToCart(CartItem item) async {
    final collection = _getCartCollection();
    // We use product ID as document ID to prevent duplicates easily
    await collection.doc(item.product.id).set(item.toJson());
  }

  @override
  Future<void> removeFromCart(String productId) async {
    await _getCartCollection().doc(productId).delete();
  }

  @override
  Future<void> updateQuantity(String productId, int quantity) async {
    if (quantity <= 0) {
      await removeFromCart(productId);
    } else {
      await _getCartCollection().doc(productId).update({'quantity': quantity});
    }
  }

  @override
  Future<void> clearCart() async {
    final collection = _getCartCollection();
    final snapshot = await collection.get();
    final batch = _firestore.batch();
    for (final doc in snapshot.docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}

@Riverpod(keepAlive: true)
CartRepository cartRepository(CartRepositoryRef ref) {
  return CartRepositoryImpl();
}
