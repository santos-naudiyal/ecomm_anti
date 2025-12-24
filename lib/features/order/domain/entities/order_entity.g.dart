// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$OrderItemImpl _$$OrderItemImplFromJson(Map<String, dynamic> json) =>
    _$OrderItemImpl(
      productId: json['productId'] as String,
      name: json['name'] as String,
      price: (json['price'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
      imageUrl: json['imageUrl'] as String,
      category: json['category'] as String?,
    );

Map<String, dynamic> _$$OrderItemImplToJson(_$OrderItemImpl instance) =>
    <String, dynamic>{
      'productId': instance.productId,
      'name': instance.name,
      'price': instance.price,
      'quantity': instance.quantity,
      'imageUrl': instance.imageUrl,
      'category': instance.category,
    };

_$OrderEntityImpl _$$OrderEntityImplFromJson(Map<String, dynamic> json) =>
    _$OrderEntityImpl(
      id: json['id'] as String,
      userId: json['userId'] as String,
      items: (json['items'] as List<dynamic>)
          .map((e) => OrderItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalAmount: (json['totalAmount'] as num).toInt(),
      addressId: json['addressId'] as String,
      paymentMethod: json['paymentMethod'] as String,
      status: json['status'] as String,
      createdAt: const TimestampConverter().fromJson(json['createdAt']),
      trackingId: json['trackingId'] as String?,
      cancelReason: json['cancelReason'] as String?,
    );

Map<String, dynamic> _$$OrderEntityImplToJson(_$OrderEntityImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'items': instance.items,
      'totalAmount': instance.totalAmount,
      'addressId': instance.addressId,
      'paymentMethod': instance.paymentMethod,
      'status': instance.status,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'trackingId': instance.trackingId,
      'cancelReason': instance.cancelReason,
    };
