// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ProductEntityImpl _$$ProductEntityImplFromJson(Map<String, dynamic> json) =>
    _$ProductEntityImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      price: json['price'] == null ? 0 : _readPrice(json['price']),
      originalPrice: (json['originalPrice'] as num?)?.toInt(),
      imageUrl: json['imageUrl'] as String,
      additionalImages:
          (json['additionalImages'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      stock: (json['stock'] as num?)?.toInt() ?? 0,
      category: json['category'] as String,
      brand: json['brand'] as String?,
      tags:
          (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      salesCount: (json['salesCount'] as num?)?.toInt() ?? 0,
      viewCount: (json['viewCount'] as num?)?.toInt() ?? 0,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      location: json['location'] as String?,
      description: json['description'] as String?,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      reviewCount: (json['reviewCount'] as num?)?.toInt() ?? 0,
      isFeatured: json['isFeatured'] as bool? ?? false,
    );

Map<String, dynamic> _$$ProductEntityImplToJson(_$ProductEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'price': instance.price,
      'originalPrice': instance.originalPrice,
      'imageUrl': instance.imageUrl,
      'additionalImages': instance.additionalImages,
      'stock': instance.stock,
      'category': instance.category,
      'brand': instance.brand,
      'tags': instance.tags,
      'salesCount': instance.salesCount,
      'viewCount': instance.viewCount,
      'createdAt': instance.createdAt?.toIso8601String(),
      'location': instance.location,
      'description': instance.description,
      'rating': instance.rating,
      'reviewCount': instance.reviewCount,
      'isFeatured': instance.isFeatured,
    };
