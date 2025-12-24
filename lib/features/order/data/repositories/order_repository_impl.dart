import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/order_entity.dart';
import '../../domain/repositories/order_repository.dart';

part 'order_repository_impl.g.dart';

class OrderRepositoryImpl implements OrderRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String get _uid {
    final uid = _auth.currentUser?.uid;
    if (uid == null || uid.isEmpty) {
      throw Exception('User not authenticated');
    }
    return uid;
  }

  /// ------------------------------------------------------------
  /// PLACE ORDER (CORRECT & TRANSACTION SAFE)
  /// ------------------------------------------------------------
  @override
  Future<String> placeOrder({
    required String addressId,
    required String paymentMethod,
  }) async {
    final userId = _uid;

    /// ✅ STEP 1: READ CART OUTSIDE TRANSACTION
    final cartQuery = await _firestore
        .collection('users')
        .doc(userId)
        .collection('cartItems') // Correct collection name
        .get();

    if (cartQuery.docs.isEmpty) {
      throw Exception('Cart is empty');
    }

    /// Convert cart to usable data
    final cartDocs = cartQuery.docs;

    return _firestore.runTransaction<String>((transaction) async {
      int totalAmount = 0;
      final List<OrderItem> orderItems = [];

      /// --------------------------------------------------------
      /// PHASE 1: READ ALL PRODUCTS (Sequentially)
      /// --------------------------------------------------------
      // We must fetch all product snapshots before performing ANY writes.
      // We'll store them in a list to use in Phase 2.
      final List<DocumentSnapshot> productSnaps = [];

      for (final cartDoc in cartDocs) {
        final data = cartDoc.data();
        final String productId = data['id']; // Correct field name
        final productRef = _firestore.collection('products').doc(productId);

        final snapshot = await transaction.get(productRef);
        productSnaps.add(snapshot);
      }

      /// --------------------------------------------------------
      /// PHASE 2: VALIDATE & CALCULATE (No Writes yet)
      /// --------------------------------------------------------
      // Now we iterate again to validate stock and build order items.
      // We also prepare the stock updates.

      for (int i = 0; i < cartDocs.length; i++) {
        final cartDoc = cartDocs[i];
        final productSnap = productSnaps[i];

        final cartData = cartDoc.data();
        final String productId = cartData['id'];
        final int quantity = cartData['quantity'];

        if (!productSnap.exists) {
          throw Exception('Product not found: $productId');
        }

        final productData = productSnap.data() as Map<String, dynamic>;

        // Robust parsing
        final int stock = (productData['stock'] as num?)?.toInt() ?? 0;

        // Handle price being int or double
        final rawPrice = productData['price'];
        int price = 0;
        if (rawPrice is int) {
          price = rawPrice;
        } else if (rawPrice is double) {
          price = (rawPrice * 100).toInt();
        }

        final String name = productData['name'] ?? 'Unknown Product';
        final String imageUrl = productData['imageUrl'] ?? '';

        if (stock < quantity) {
          throw Exception('Product out of stock: $name');
        }

        totalAmount += price * quantity;

        orderItems.add(
          OrderItem(
            productId: productId,
            name: name,
            price: price,
            quantity: quantity,
            imageUrl: imageUrl,
          ),
        );

        /// --------------------------------------------------------
        /// PHASE 3: COLLECT WRITES (Update Stock)
        /// --------------------------------------------------------
        // We perform the actual update later, or we can do it here
        // IF we are sure no more reads will happen.
        // Since we did all reads in Phase 1, we can safe modify here?
        // NO, "all reads must be executed before all writes".
        // Use the transaction to update.
        transaction.update(productSnap.reference, {'stock': stock - quantity});
      }

      /// --------------------------------------------------------
      /// PHASE 4: FINAL WRITES (Order & Cart)
      /// --------------------------------------------------------
      final orderRef = _firestore.collection('orders').doc();

      final order = OrderEntity(
        id: orderRef.id,
        userId: userId,
        addressId: addressId,
        paymentMethod: paymentMethod,
        totalAmount: totalAmount,
        status: 'placed',
        items: orderItems,
        createdAt: DateTime.now(),
      );

      // Deep convert items to JSON to avoid "Instance of _$OrderItemImpl" error
      final orderJson = order.toJson();
      final itemsJson = orderItems.map((item) => item.toJson()).toList();

      // Create a mutable map and update items
      final finalData = Map<String, dynamic>.from(orderJson);
      finalData['items'] = itemsJson;

      transaction.set(orderRef, finalData);

      // Clear Cart
      for (final cartDoc in cartDocs) {
        transaction.delete(cartDoc.reference);
      }

      return orderRef.id;
    });
  }

  /// ------------------------------------------------------------
  /// GET USER ORDERS
  /// ------------------------------------------------------------
  @override
  Future<List<OrderEntity>> getMyOrders() async {
    final snapshot = await _firestore
        .collection('orders')
        .where('userId', isEqualTo: _uid)
        // .orderBy('createdAt', descending: true) // REMOVED to avoid index error
        .get();

    final orders = snapshot.docs
        .map((doc) => OrderEntity.fromJson(doc.data()))
        .toList();

    // Sort client-side
    orders.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return orders;
  }

  /// ------------------------------------------------------------
  /// ADMIN: GET ALL ORDERS
  /// ------------------------------------------------------------
  @override
  Future<List<OrderEntity>> getAllOrders() async {
    final snapshot = await _firestore
        .collection('orders')
        // .orderBy('createdAt', descending: true) // Consider removing here too if needed
        .get();

    final orders = snapshot.docs
        .map((doc) => OrderEntity.fromJson(doc.data()))
        .toList();

    orders.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return orders;
  }

  /// ------------------------------------------------------------
  /// UPDATE ORDER STATUS (ADMIN)
  /// ------------------------------------------------------------
  @override
  Future<void> updateOrderStatus({
    required String orderId,
    required String newStatus,
  }) async {
    await _firestore.collection('orders').doc(orderId).update({
      'status': newStatus,
    });
  }
}

@Riverpod(keepAlive: true)
OrderRepository orderRepository(OrderRepositoryRef ref) {
  return OrderRepositoryImpl();
}
