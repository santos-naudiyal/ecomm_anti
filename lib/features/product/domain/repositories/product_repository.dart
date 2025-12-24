import 'package:antigravity/features/product/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<ProductEntity>> getFeaturedProducts();
  Future<List<ProductEntity>> getProductsByCategory(String category);
  Future<List<String>> getCategories();
  Future<ProductEntity?> getProductById(String id);
  Future<List<ProductEntity>> searchProducts(String query);

  // Admin methods
  Future<void> createProduct(ProductEntity product);
  Future<void> updateProduct(ProductEntity product);
  Future<void> deleteProduct(String id);
}
