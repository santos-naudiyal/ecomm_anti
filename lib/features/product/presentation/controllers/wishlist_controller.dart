import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/services/trending_service.dart';

part 'wishlist_controller.g.dart';

@Riverpod(keepAlive: true)
class WishlistController extends _$WishlistController {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Stream<List<String>> build() {
    // In a real app, use the authenticated user's ID
    const userId = 'user_123';
    return _firestore
        .collection('users')
        .doc(userId)
        .collection('wishlist')
        .snapshots()
        .map((snapshot) => snapshot.docs.map((doc) => doc.id).toList());
  }

  Future<void> toggleWishlist(ProductEntity product) async {
    const userId = 'user_123';
    final wishlistDoc = _firestore
        .collection('users')
        .doc(userId)
        .collection('wishlist')
        .doc(product.id);

    final doc = await wishlistDoc.get();

    if (doc.exists) {
      await wishlistDoc.delete();
    } else {
      await wishlistDoc.set({
        'addedAt': FieldValue.serverTimestamp(),
        'productId': product.id,
        'category': product.category,
      });

      // Track trending activity
      ref.read(trendingServiceProvider.notifier).trackActivity(
            productId: product.id,
            type: TrendingActivityType.wishlist,
            location: 'Mumbai',
          );
    }
  }

  /// Shareable collection link generator
  String getShareableLink() {
    const userId = 'user_123';
    const username = 'santosh';
    return 'https://yourapp.com/user/$username/collection/minimal-fashion';
  }
}
