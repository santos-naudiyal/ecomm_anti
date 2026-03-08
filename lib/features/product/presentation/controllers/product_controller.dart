import 'dart:async';
import 'package:antigravity/core/errors/app_failure.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/services/product_scoring_service.dart';
import '../../data/repositories/product_repository_impl.dart';

part 'product_controller.g.dart';

/// ------------------------------------------------------------
/// FEATURED PRODUCTS
/// ------------------------------------------------------------
@riverpod
class FeaturedProducts extends _$FeaturedProducts {
  @override
  Future<List<ProductEntity>> build() async {
    try {
      return await ref
          .watch(productRepositoryProvider)
          .getFeaturedProducts();
    } catch (e) {
      throw AppFailure.fromException(e);
    }
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}

/// ------------------------------------------------------------
/// CATEGORIES
/// ------------------------------------------------------------
@riverpod
class Categories extends _$Categories {
  @override
  Future<List<String>> build() async {
    try {
      return await ref
          .watch(productRepositoryProvider)
          .getCategories();
    } catch (e) {
      throw AppFailure.fromException(e);
    }
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}

/// ------------------------------------------------------------
/// PRODUCT DETAILS (BY ID)
/// ------------------------------------------------------------
@riverpod
class ProductDetails extends _$ProductDetails {
  @override
  Future<ProductEntity?> build(String id) async {
    try {
      return await ref
          .watch(productRepositoryProvider)
          .getProductById(id);
    } catch (e) {
      throw AppFailure.fromException(e);
    }
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}

/// ------------------------------------------------------------
/// PRODUCTS BY CATEGORY
/// ------------------------------------------------------------
@riverpod
class ProductsByCategory extends _$ProductsByCategory {
  @override
  Future<List<ProductEntity>> build(String category) async {
    try {
      return await ref
          .watch(productRepositoryProvider)
          .getProductsByCategory(category);
    } catch (e) {
      throw AppFailure.fromException(e);
    }
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}
/// ------------------------------------------------------------
/// SMART FEED PRODUCTS (AI RANKED)
/// ------------------------------------------------------------
@riverpod
class SmartFeedProducts extends _$SmartFeedProducts {
  @override
  Future<List<ProductEntity>> build() async {
    try {
      final products =
          await ref.watch(productRepositoryProvider).getFeaturedProducts();

      // In a real app, these would come from the user's profile/history
      // For now, we use dummy data for personalization
      final userInterests = ['electronics', 'fashion'];
      final userPurchaseHistory = ['Electronics'];
      const userLocation = 'Mumbai';

      // Apply scoring
      final scoredProducts = products.map((product) {
        final score = ProductScoringService.calculateScore(
          product: product,
          userInterests: userInterests,
          userPurchaseHistory: userPurchaseHistory,
          userLocation: userLocation,
        );
        return MapEntry(product, score);
      }).toList();

      // Sort by score descending
      scoredProducts.sort((a, b) => b.value.compareTo(a.value));

      return scoredProducts.map((e) => e.key).toList();
    } catch (e) {
      throw AppFailure.fromException(e);
    }
  }

  Future<void> refresh() async {
    ref.invalidateSelf();
  }
}
