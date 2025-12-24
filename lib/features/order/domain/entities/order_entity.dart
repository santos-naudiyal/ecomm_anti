import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'order_entity.freezed.dart';
part 'order_entity.g.dart';

/// ------------------------------------------------------------
/// FIRESTORE TIMESTAMP CONVERTER
/// ------------------------------------------------------------
class TimestampConverter implements JsonConverter<DateTime, Object?> {
  const TimestampConverter();

  @override
  DateTime fromJson(Object? json) {
    if (json is Timestamp) {
      return json.toDate();
    }
    if (json is String) {
      return DateTime.tryParse(json) ?? DateTime.now();
    }
    return DateTime.now();
  }

  @override
  Object toJson(DateTime object) {
    return Timestamp.fromDate(object);
  }
}

/// ------------------------------------------------------------
/// ORDER ITEM SNAPSHOT (IMMUTABLE & SAFE)
/// ------------------------------------------------------------
@freezed
class OrderItem with _$OrderItem {
  const factory OrderItem({
    required String productId,
    required String name,

    /// Price per unit in paise
    required int price,

    required int quantity,
    required String imageUrl,

    /// Optional category snapshot (helps analytics & reorder)
    String? category,
  }) = _OrderItem;

  factory OrderItem.fromJson(Map<String, dynamic> json) =>
      _$OrderItemFromJson(json);
}

/// ------------------------------------------------------------
/// ORDER ENTITY (SOURCE OF TRUTH)
/// ------------------------------------------------------------
@freezed
class OrderEntity with _$OrderEntity {
  const factory OrderEntity({
    required String id,
    required String userId,

    /// Snapshot of items at purchase time
    required List<OrderItem> items,

    /// Total amount in paise (₹ = paise / 100)
    required int totalAmount,

    /// Address document ID
    required String addressId,

    /// Payment method: COD / UPI / CARD
    required String paymentMethod,

    /// placed → shipped → delivered → cancelled
    required String status,

    @TimestampConverter() required DateTime createdAt,

    /// Optional admin / logistics fields (future-proof)
    String? trackingId,
    String? cancelReason,
  }) = _OrderEntity;

  factory OrderEntity.fromJson(Map<String, dynamic> json) =>
      _$OrderEntityFromJson(json);
}
