import 'dart:math';
import '../entities/product_entity.dart';

class ProductScoringService {
  /// product_score = 
  ///    (0.3 * similarity) 
  ///  + (0.2 * popularity) 
  ///  + (0.2 * recency) 
  ///  + (0.2 * user_interest) 
  ///  + (0.1 * discount_weight)

  static double calculateScore({
    required ProductEntity product,
    required List<String> userInterests, // Tags user has interacted with
    required List<String> userPurchaseHistory, // IDs of products user bought
    String? userLocation,
  }) {
    double similarity = _calculateSimilarity(product, userInterests);
    double popularity = _calculatePopularity(product);
    double recency = _calculateRecency(product);
    double userInterest = _calculateUserInterest(product, userPurchaseHistory);
    double discountWeight = _calculateDiscountWeight(product);
    double locationWeight = _calculateLocationWeight(product, userLocation);

    // Apply the formula with an extra boost for location
    double baseScore = (0.3 * similarity) +
        (0.2 * popularity) +
        (0.2 * recency) +
        (0.2 * userInterest) +
        (0.1 * discountWeight);

    // Location boost (hyperlocal factor)
    if (locationWeight > 0) {
      baseScore += 0.1 * locationWeight;
    }

    return baseScore;
  }

  static double _calculateSimilarity(ProductEntity product, List<String> userInterests) {
    if (userInterests.isEmpty) return 0.5; // Neutral
    int matches = product.tags.where((tag) => userInterests.contains(tag)).length;
    return min(1.0, matches / max(1, userInterests.length));
  }

  static double _calculatePopularity(ProductEntity product) {
    // Combine sales and views
    double salesFactor = min(1.0, product.salesCount / 1000.0);
    double viewsFactor = min(1.0, product.viewCount / 5000.0);
    return (salesFactor * 0.7) + (viewsFactor * 0.3);
  }

  static double _calculateRecency(ProductEntity product) {
    if (product.createdAt == null) return 0.0;
    final ageInDays = DateTime.now().difference(product.createdAt!).inDays;
    // Decays over 30 days
    return max(0.0, (30 - ageInDays) / 30.0);
  }

  static double _calculateUserInterest(ProductEntity product, List<String> userPurchaseHistory) {
    if (userPurchaseHistory.contains(product.category)) return 1.0;
    return 0.0;
  }

  static double _calculateDiscountWeight(ProductEntity product) {
    if (product.originalPrice == null || product.originalPrice! <= product.price) return 0.0;
    double discount = (product.originalPrice! - product.price) / product.originalPrice!;
    return min(1.0, discount * 2); // Boost products with higher discounts
  }

  static double _calculateLocationWeight(ProductEntity product, String? userLocation) {
    if (userLocation == null || product.location == null) return 0.0;
    return product.location!.toLowerCase() == userLocation.toLowerCase() ? 1.0 : 0.0;
  }
}
