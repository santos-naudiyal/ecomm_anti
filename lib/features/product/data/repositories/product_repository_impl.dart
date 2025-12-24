import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';

part 'product_repository_impl.g.dart';

class ProductRepositoryImpl implements ProductRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _products =>
      _firestore.collection('products');

  /// ------------------------------------------------------------
  /// FEATURED PRODUCTS
  /// ------------------------------------------------------------
  @override
  Future<List<ProductEntity>> getFeaturedProducts() async {
    final snapshot = await _products
        .where('isFeatured', isEqualTo: true)
        .limit(10)
        .get();

    return snapshot.docs
        .map((doc) => ProductEntity.fromJson(doc.data()))
        .toList();
  }

  /// ------------------------------------------------------------
  /// PRODUCTS BY CATEGORY
  /// ------------------------------------------------------------
  @override
  Future<List<ProductEntity>> getProductsByCategory(String category) async {
    Query<Map<String, dynamic>> query = _products;

    if (category != 'All') {
      query = query.where('category', isEqualTo: category);
    }

    final snapshot = await query.get();

    return snapshot.docs
        .map((doc) => ProductEntity.fromJson(doc.data()))
        .toList();
  }

  /// ------------------------------------------------------------
  /// GET ALL CATEGORIES
  /// ------------------------------------------------------------
  @override
  Future<List<String>> getCategories() async {
    // Static categories (best practice unless you need dynamic admin control)
    return const [
      'All',
      'Men',
      'Women',
      'Electronics',
      'Footwear',
      'Accessories',
    ];
  }

  /// ------------------------------------------------------------
  /// GET PRODUCT BY ID
  /// ------------------------------------------------------------
  @override
  Future<ProductEntity?> getProductById(String id) async {
    final doc = await _products.doc(id).get();
    if (!doc.exists || doc.data() == null) return null;
    return ProductEntity.fromJson(doc.data()!);
  }

  /// ------------------------------------------------------------
  /// SEARCH PRODUCTS (CLIENT-SIDE FILTER)
  /// ------------------------------------------------------------
  @override
  Future<List<ProductEntity>> searchProducts(String query) async {
    final snapshot = await _products.get();

    final products = snapshot.docs
        .map((doc) => ProductEntity.fromJson(doc.data()))
        .toList();

    return products
        .where(
          (p) => p.name.toLowerCase().contains(query.toLowerCase()),
        )
        .toList();
  }

  /// ------------------------------------------------------------
  /// CREATE PRODUCT (ADMIN)
  /// ------------------------------------------------------------
  @override
  Future<void> createProduct(ProductEntity product) async {
    await _products.doc(product.id).set(product.toJson());
  }

  /// ------------------------------------------------------------
  /// UPDATE PRODUCT (ADMIN)
  /// ------------------------------------------------------------
  @override
  Future<void> updateProduct(ProductEntity product) async {
    await _products.doc(product.id).update(product.toJson());
  }

  /// ------------------------------------------------------------
  /// DELETE PRODUCT (ADMIN)
  /// ------------------------------------------------------------
  @override
  Future<void> deleteProduct(String id) async {
    await _products.doc(id).delete();
  }
}

/// ------------------------------------------------------------
/// RIVERPOD PROVIDER
/// ------------------------------------------------------------
@Riverpod(keepAlive: true)
ProductRepository productRepository(ProductRepositoryRef ref) {
  return ProductRepositoryImpl();
}
