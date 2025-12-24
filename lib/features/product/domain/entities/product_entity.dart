import 'package:freezed_annotation/freezed_annotation.dart';

part 'product_entity.freezed.dart';
part 'product_entity.g.dart';

@freezed
class ProductEntity with _$ProductEntity {
  const factory ProductEntity({
    /// Core identifiers
    required String id,
    required String name,

    /// Pricing (PAISE, not double)
    @JsonKey(fromJson: _readPrice) @Default(0) int price, // selling price
    int? originalPrice, // MRP (optional)
    /// Media
    required String imageUrl,
    @Default([]) List<String> additionalImages,

    /// Inventory
    @Default(0) int stock, // 0 = out of stock
    /// Classification
    required String category,
    String? brand,

    /// Optional content
    String? description,

    /// Social proof (optional)
    @Default(0.0) double rating,
    @Default(0) int reviewCount,

    /// Flags
    @Default(false) bool isFeatured,
  }) = _ProductEntity;

  factory ProductEntity.fromJson(Map<String, dynamic> json) =>
      _$ProductEntityFromJson(json);
}

int _readPrice(dynamic value) {
  if (value is int) return value;
  if (value is double) return (value * 100).round();
  return 0;
}
