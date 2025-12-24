// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../product/domain/entities/product_entity.dart';

part 'cart_item.freezed.dart';
part 'cart_item.g.dart';

@freezed
class CartItem with _$CartItem {
  const factory CartItem({
    required String id,

    /// Product snapshot (stored fully for safety)
    @JsonKey(fromJson: _productFromJson, toJson: _productToJson)
    required ProductEntity product,

    @Default(1) int quantity,
  }) = _CartItem;

  /// Firestore → Dart
  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  /// Empty helper (used internally by CartController)
  factory CartItem.empty() => CartItem(
    id: '',
    product: ProductEntity(
      id: '',
      name: '',
      price: 0,
      imageUrl: '',
      category: 'unknown',
      stock: 0,
      description: null,
      brand: null,
      additionalImages: const [],
      originalPrice: null,
      rating: 0,
      reviewCount: 0,
      isFeatured: false,
    ),
    quantity: 0,
  );
}

/// ---------------- JSON HELPERS ----------------

ProductEntity _productFromJson(Map<String, dynamic> json) =>
    ProductEntity.fromJson(json);

Map<String, dynamic> _productToJson(ProductEntity product) => product.toJson();
