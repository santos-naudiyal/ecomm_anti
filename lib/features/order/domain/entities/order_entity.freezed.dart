// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'order_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

OrderItem _$OrderItemFromJson(Map<String, dynamic> json) {
  return _OrderItem.fromJson(json);
}

/// @nodoc
mixin _$OrderItem {
  String get productId => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Price per unit in paise
  int get price => throw _privateConstructorUsedError;
  int get quantity => throw _privateConstructorUsedError;
  String get imageUrl => throw _privateConstructorUsedError;

  /// Optional category snapshot (helps analytics & reorder)
  String? get category => throw _privateConstructorUsedError;

  /// Serializes this OrderItem to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderItemCopyWith<OrderItem> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderItemCopyWith<$Res> {
  factory $OrderItemCopyWith(OrderItem value, $Res Function(OrderItem) then) =
      _$OrderItemCopyWithImpl<$Res, OrderItem>;
  @useResult
  $Res call({
    String productId,
    String name,
    int price,
    int quantity,
    String imageUrl,
    String? category,
  });
}

/// @nodoc
class _$OrderItemCopyWithImpl<$Res, $Val extends OrderItem>
    implements $OrderItemCopyWith<$Res> {
  _$OrderItemCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? name = null,
    Object? price = null,
    Object? quantity = null,
    Object? imageUrl = null,
    Object? category = freezed,
  }) {
    return _then(
      _value.copyWith(
            productId: null == productId
                ? _value.productId
                : productId // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as int,
            quantity: null == quantity
                ? _value.quantity
                : quantity // ignore: cast_nullable_to_non_nullable
                      as int,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            category: freezed == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderItemImplCopyWith<$Res>
    implements $OrderItemCopyWith<$Res> {
  factory _$$OrderItemImplCopyWith(
    _$OrderItemImpl value,
    $Res Function(_$OrderItemImpl) then,
  ) = __$$OrderItemImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String productId,
    String name,
    int price,
    int quantity,
    String imageUrl,
    String? category,
  });
}

/// @nodoc
class __$$OrderItemImplCopyWithImpl<$Res>
    extends _$OrderItemCopyWithImpl<$Res, _$OrderItemImpl>
    implements _$$OrderItemImplCopyWith<$Res> {
  __$$OrderItemImplCopyWithImpl(
    _$OrderItemImpl _value,
    $Res Function(_$OrderItemImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? productId = null,
    Object? name = null,
    Object? price = null,
    Object? quantity = null,
    Object? imageUrl = null,
    Object? category = freezed,
  }) {
    return _then(
      _$OrderItemImpl(
        productId: null == productId
            ? _value.productId
            : productId // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as int,
        quantity: null == quantity
            ? _value.quantity
            : quantity // ignore: cast_nullable_to_non_nullable
                  as int,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        category: freezed == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderItemImpl implements _OrderItem {
  const _$OrderItemImpl({
    required this.productId,
    required this.name,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    this.category,
  });

  factory _$OrderItemImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderItemImplFromJson(json);

  @override
  final String productId;
  @override
  final String name;

  /// Price per unit in paise
  @override
  final int price;
  @override
  final int quantity;
  @override
  final String imageUrl;

  /// Optional category snapshot (helps analytics & reorder)
  @override
  final String? category;

  @override
  String toString() {
    return 'OrderItem(productId: $productId, name: $name, price: $price, quantity: $quantity, imageUrl: $imageUrl, category: $category)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderItemImpl &&
            (identical(other.productId, productId) ||
                other.productId == productId) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            (identical(other.category, category) ||
                other.category == category));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    productId,
    name,
    price,
    quantity,
    imageUrl,
    category,
  );

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderItemImplCopyWith<_$OrderItemImpl> get copyWith =>
      __$$OrderItemImplCopyWithImpl<_$OrderItemImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderItemImplToJson(this);
  }
}

abstract class _OrderItem implements OrderItem {
  const factory _OrderItem({
    required final String productId,
    required final String name,
    required final int price,
    required final int quantity,
    required final String imageUrl,
    final String? category,
  }) = _$OrderItemImpl;

  factory _OrderItem.fromJson(Map<String, dynamic> json) =
      _$OrderItemImpl.fromJson;

  @override
  String get productId;
  @override
  String get name;

  /// Price per unit in paise
  @override
  int get price;
  @override
  int get quantity;
  @override
  String get imageUrl;

  /// Optional category snapshot (helps analytics & reorder)
  @override
  String? get category;

  /// Create a copy of OrderItem
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderItemImplCopyWith<_$OrderItemImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

OrderEntity _$OrderEntityFromJson(Map<String, dynamic> json) {
  return _OrderEntity.fromJson(json);
}

/// @nodoc
mixin _$OrderEntity {
  String get id => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;

  /// Snapshot of items at purchase time
  List<OrderItem> get items => throw _privateConstructorUsedError;

  /// Total amount in paise (₹ = paise / 100)
  int get totalAmount => throw _privateConstructorUsedError;

  /// Address document ID
  String get addressId => throw _privateConstructorUsedError;

  /// Payment method: COD / UPI / CARD
  String get paymentMethod => throw _privateConstructorUsedError;

  /// placed → shipped → delivered → cancelled
  String get status => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime get createdAt => throw _privateConstructorUsedError;

  /// Optional admin / logistics fields (future-proof)
  String? get trackingId => throw _privateConstructorUsedError;
  String? get cancelReason => throw _privateConstructorUsedError;

  /// Serializes this OrderEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of OrderEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OrderEntityCopyWith<OrderEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OrderEntityCopyWith<$Res> {
  factory $OrderEntityCopyWith(
    OrderEntity value,
    $Res Function(OrderEntity) then,
  ) = _$OrderEntityCopyWithImpl<$Res, OrderEntity>;
  @useResult
  $Res call({
    String id,
    String userId,
    List<OrderItem> items,
    int totalAmount,
    String addressId,
    String paymentMethod,
    String status,
    @TimestampConverter() DateTime createdAt,
    String? trackingId,
    String? cancelReason,
  });
}

/// @nodoc
class _$OrderEntityCopyWithImpl<$Res, $Val extends OrderEntity>
    implements $OrderEntityCopyWith<$Res> {
  _$OrderEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of OrderEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? items = null,
    Object? totalAmount = null,
    Object? addressId = null,
    Object? paymentMethod = null,
    Object? status = null,
    Object? createdAt = null,
    Object? trackingId = freezed,
    Object? cancelReason = freezed,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            userId: null == userId
                ? _value.userId
                : userId // ignore: cast_nullable_to_non_nullable
                      as String,
            items: null == items
                ? _value.items
                : items // ignore: cast_nullable_to_non_nullable
                      as List<OrderItem>,
            totalAmount: null == totalAmount
                ? _value.totalAmount
                : totalAmount // ignore: cast_nullable_to_non_nullable
                      as int,
            addressId: null == addressId
                ? _value.addressId
                : addressId // ignore: cast_nullable_to_non_nullable
                      as String,
            paymentMethod: null == paymentMethod
                ? _value.paymentMethod
                : paymentMethod // ignore: cast_nullable_to_non_nullable
                      as String,
            status: null == status
                ? _value.status
                : status // ignore: cast_nullable_to_non_nullable
                      as String,
            createdAt: null == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime,
            trackingId: freezed == trackingId
                ? _value.trackingId
                : trackingId // ignore: cast_nullable_to_non_nullable
                      as String?,
            cancelReason: freezed == cancelReason
                ? _value.cancelReason
                : cancelReason // ignore: cast_nullable_to_non_nullable
                      as String?,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$OrderEntityImplCopyWith<$Res>
    implements $OrderEntityCopyWith<$Res> {
  factory _$$OrderEntityImplCopyWith(
    _$OrderEntityImpl value,
    $Res Function(_$OrderEntityImpl) then,
  ) = __$$OrderEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String userId,
    List<OrderItem> items,
    int totalAmount,
    String addressId,
    String paymentMethod,
    String status,
    @TimestampConverter() DateTime createdAt,
    String? trackingId,
    String? cancelReason,
  });
}

/// @nodoc
class __$$OrderEntityImplCopyWithImpl<$Res>
    extends _$OrderEntityCopyWithImpl<$Res, _$OrderEntityImpl>
    implements _$$OrderEntityImplCopyWith<$Res> {
  __$$OrderEntityImplCopyWithImpl(
    _$OrderEntityImpl _value,
    $Res Function(_$OrderEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of OrderEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = null,
    Object? items = null,
    Object? totalAmount = null,
    Object? addressId = null,
    Object? paymentMethod = null,
    Object? status = null,
    Object? createdAt = null,
    Object? trackingId = freezed,
    Object? cancelReason = freezed,
  }) {
    return _then(
      _$OrderEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        userId: null == userId
            ? _value.userId
            : userId // ignore: cast_nullable_to_non_nullable
                  as String,
        items: null == items
            ? _value._items
            : items // ignore: cast_nullable_to_non_nullable
                  as List<OrderItem>,
        totalAmount: null == totalAmount
            ? _value.totalAmount
            : totalAmount // ignore: cast_nullable_to_non_nullable
                  as int,
        addressId: null == addressId
            ? _value.addressId
            : addressId // ignore: cast_nullable_to_non_nullable
                  as String,
        paymentMethod: null == paymentMethod
            ? _value.paymentMethod
            : paymentMethod // ignore: cast_nullable_to_non_nullable
                  as String,
        status: null == status
            ? _value.status
            : status // ignore: cast_nullable_to_non_nullable
                  as String,
        createdAt: null == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime,
        trackingId: freezed == trackingId
            ? _value.trackingId
            : trackingId // ignore: cast_nullable_to_non_nullable
                  as String?,
        cancelReason: freezed == cancelReason
            ? _value.cancelReason
            : cancelReason // ignore: cast_nullable_to_non_nullable
                  as String?,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$OrderEntityImpl implements _OrderEntity {
  const _$OrderEntityImpl({
    required this.id,
    required this.userId,
    required final List<OrderItem> items,
    required this.totalAmount,
    required this.addressId,
    required this.paymentMethod,
    required this.status,
    @TimestampConverter() required this.createdAt,
    this.trackingId,
    this.cancelReason,
  }) : _items = items;

  factory _$OrderEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$OrderEntityImplFromJson(json);

  @override
  final String id;
  @override
  final String userId;

  /// Snapshot of items at purchase time
  final List<OrderItem> _items;

  /// Snapshot of items at purchase time
  @override
  List<OrderItem> get items {
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_items);
  }

  /// Total amount in paise (₹ = paise / 100)
  @override
  final int totalAmount;

  /// Address document ID
  @override
  final String addressId;

  /// Payment method: COD / UPI / CARD
  @override
  final String paymentMethod;

  /// placed → shipped → delivered → cancelled
  @override
  final String status;
  @override
  @TimestampConverter()
  final DateTime createdAt;

  /// Optional admin / logistics fields (future-proof)
  @override
  final String? trackingId;
  @override
  final String? cancelReason;

  @override
  String toString() {
    return 'OrderEntity(id: $id, userId: $userId, items: $items, totalAmount: $totalAmount, addressId: $addressId, paymentMethod: $paymentMethod, status: $status, createdAt: $createdAt, trackingId: $trackingId, cancelReason: $cancelReason)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OrderEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.totalAmount, totalAmount) ||
                other.totalAmount == totalAmount) &&
            (identical(other.addressId, addressId) ||
                other.addressId == addressId) &&
            (identical(other.paymentMethod, paymentMethod) ||
                other.paymentMethod == paymentMethod) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.trackingId, trackingId) ||
                other.trackingId == trackingId) &&
            (identical(other.cancelReason, cancelReason) ||
                other.cancelReason == cancelReason));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    userId,
    const DeepCollectionEquality().hash(_items),
    totalAmount,
    addressId,
    paymentMethod,
    status,
    createdAt,
    trackingId,
    cancelReason,
  );

  /// Create a copy of OrderEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OrderEntityImplCopyWith<_$OrderEntityImpl> get copyWith =>
      __$$OrderEntityImplCopyWithImpl<_$OrderEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OrderEntityImplToJson(this);
  }
}

abstract class _OrderEntity implements OrderEntity {
  const factory _OrderEntity({
    required final String id,
    required final String userId,
    required final List<OrderItem> items,
    required final int totalAmount,
    required final String addressId,
    required final String paymentMethod,
    required final String status,
    @TimestampConverter() required final DateTime createdAt,
    final String? trackingId,
    final String? cancelReason,
  }) = _$OrderEntityImpl;

  factory _OrderEntity.fromJson(Map<String, dynamic> json) =
      _$OrderEntityImpl.fromJson;

  @override
  String get id;
  @override
  String get userId;

  /// Snapshot of items at purchase time
  @override
  List<OrderItem> get items;

  /// Total amount in paise (₹ = paise / 100)
  @override
  int get totalAmount;

  /// Address document ID
  @override
  String get addressId;

  /// Payment method: COD / UPI / CARD
  @override
  String get paymentMethod;

  /// placed → shipped → delivered → cancelled
  @override
  String get status;
  @override
  @TimestampConverter()
  DateTime get createdAt;

  /// Optional admin / logistics fields (future-proof)
  @override
  String? get trackingId;
  @override
  String? get cancelReason;

  /// Create a copy of OrderEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OrderEntityImplCopyWith<_$OrderEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
