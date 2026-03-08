import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import '../../domain/entities/product_entity.dart';

part 'trending_service.g.dart';

@Riverpod(keepAlive: true)
class TrendingService extends _$TrendingService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void build() {}

  /// Track activity to update trending scores
  Future<void> trackActivity({
    required String productId,
    required TrendingActivityType type,
    String? location,
  }) async {
    final trendingDoc = _firestore.collection('trending_products').doc(productId);
    final statsDoc = _firestore.collection('product_stats').doc(productId);

    int scoreIncrement = 1;
    switch (type) {
      case TrendingActivityType.view:
        scoreIncrement = 1;
        break;
      case TrendingActivityType.addToCart:
        scoreIncrement = 5;
        break;
      case TrendingActivityType.wishlist:
        scoreIncrement = 3;
        break;
      case TrendingActivityType.purchase:
        scoreIncrement = 10;
        break;
    }

    final batch = _firestore.batch();

    // Global trending
    batch.set(trendingDoc, {
      'score': FieldValue.increment(scoreIncrement),
      'lastUpdated': FieldValue.serverTimestamp(),
      'productId': productId,
    }, SetOptions(merge: true));

    // Location-based trending
    if (location != null) {
      final locationDoc = _firestore
          .collection('trending_by_location')
          .doc(location)
          .collection('products')
          .doc(productId);
      
      batch.set(locationDoc, {
        'score': FieldValue.increment(scoreIncrement),
        'lastUpdated': FieldValue.serverTimestamp(),
      }, SetOptions(merge: true));
    }

    // Update product views/sales for AI scoring
    if (type == TrendingActivityType.view) {
      batch.set(statsDoc, {'viewCount': FieldValue.increment(1)}, SetOptions(merge: true));
    } else if (type == TrendingActivityType.purchase) {
      batch.set(statsDoc, {'salesCount': FieldValue.increment(1)}, SetOptions(merge: true));
    }

    await batch.commit();
  }

  /// Get trending products stream
  Stream<List<String>> getTrendingProductIds({String? location}) {
    Query query;
    if (location != null) {
      query = _firestore
          .collection('trending_by_location')
          .doc(location)
          .collection('products')
          .orderBy('score', descending: true)
          .limit(10);
    } else {
      query = _firestore
          .collection('trending_products')
          .orderBy('score', descending: true)
          .limit(10);
    }

    return query.snapshots().map((snapshot) {
      return snapshot.docs.map((doc) => doc.id).toList();
    });
  }
}

enum TrendingActivityType {
  view,
  addToCart,
  wishlist,
  purchase,
}
