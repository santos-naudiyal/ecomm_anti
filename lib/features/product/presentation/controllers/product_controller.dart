import 'dart:async';
import 'package:antigravity/core/errors/app_failure.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/product_entity.dart';
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
