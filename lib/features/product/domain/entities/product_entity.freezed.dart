// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'product_entity.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

ProductEntity _$ProductEntityFromJson(Map<String, dynamic> json) {
  return _ProductEntity.fromJson(json);
}

/// @nodoc
mixin _$ProductEntity {
  /// Core identifiers
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;

  /// Pricing (PAISE, not double)
  @JsonKey(fromJson: _readPrice)
  int get price => throw _privateConstructorUsedError; // selling price
  int? get originalPrice =>
      throw _privateConstructorUsedError; // MRP (optional)
  /// Media
  String get imageUrl => throw _privateConstructorUsedError;
  List<String> get additionalImages => throw _privateConstructorUsedError;

  /// Inventory
  int get stock => throw _privateConstructorUsedError; // 0 = out of stock
  /// Classification
  String get category => throw _privateConstructorUsedError;
  String? get brand => throw _privateConstructorUsedError;
  List<String> get tags => throw _privateConstructorUsedError;

  /// Metrics for AI Scoring
  int get salesCount => throw _privateConstructorUsedError;
  int get viewCount => throw _privateConstructorUsedError;
  DateTime? get createdAt => throw _privateConstructorUsedError;

  /// Hyperlocal
  String? get location => throw _privateConstructorUsedError;

  /// Optional content
  String? get description => throw _privateConstructorUsedError;

  /// Social proof (optional)
  double get rating => throw _privateConstructorUsedError;
  int get reviewCount => throw _privateConstructorUsedError;

  /// Flags
  bool get isFeatured => throw _privateConstructorUsedError;

  /// Serializes this ProductEntity to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of ProductEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ProductEntityCopyWith<ProductEntity> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ProductEntityCopyWith<$Res> {
  factory $ProductEntityCopyWith(
    ProductEntity value,
    $Res Function(ProductEntity) then,
  ) = _$ProductEntityCopyWithImpl<$Res, ProductEntity>;
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(fromJson: _readPrice) int price,
    int? originalPrice,
    String imageUrl,
    List<String> additionalImages,
    int stock,
    String category,
    String? brand,
    List<String> tags,
    int salesCount,
    int viewCount,
    DateTime? createdAt,
    String? location,
    String? description,
    double rating,
    int reviewCount,
    bool isFeatured,
  });
}

/// @nodoc
class _$ProductEntityCopyWithImpl<$Res, $Val extends ProductEntity>
    implements $ProductEntityCopyWith<$Res> {
  _$ProductEntityCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of ProductEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = null,
    Object? originalPrice = freezed,
    Object? imageUrl = null,
    Object? additionalImages = null,
    Object? stock = null,
    Object? category = null,
    Object? brand = freezed,
    Object? tags = null,
    Object? salesCount = null,
    Object? viewCount = null,
    Object? createdAt = freezed,
    Object? location = freezed,
    Object? description = freezed,
    Object? rating = null,
    Object? reviewCount = null,
    Object? isFeatured = null,
  }) {
    return _then(
      _value.copyWith(
            id: null == id
                ? _value.id
                : id // ignore: cast_nullable_to_non_nullable
                      as String,
            name: null == name
                ? _value.name
                : name // ignore: cast_nullable_to_non_nullable
                      as String,
            price: null == price
                ? _value.price
                : price // ignore: cast_nullable_to_non_nullable
                      as int,
            originalPrice: freezed == originalPrice
                ? _value.originalPrice
                : originalPrice // ignore: cast_nullable_to_non_nullable
                      as int?,
            imageUrl: null == imageUrl
                ? _value.imageUrl
                : imageUrl // ignore: cast_nullable_to_non_nullable
                      as String,
            additionalImages: null == additionalImages
                ? _value.additionalImages
                : additionalImages // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            stock: null == stock
                ? _value.stock
                : stock // ignore: cast_nullable_to_non_nullable
                      as int,
            category: null == category
                ? _value.category
                : category // ignore: cast_nullable_to_non_nullable
                      as String,
            brand: freezed == brand
                ? _value.brand
                : brand // ignore: cast_nullable_to_non_nullable
                      as String?,
            tags: null == tags
                ? _value.tags
                : tags // ignore: cast_nullable_to_non_nullable
                      as List<String>,
            salesCount: null == salesCount
                ? _value.salesCount
                : salesCount // ignore: cast_nullable_to_non_nullable
                      as int,
            viewCount: null == viewCount
                ? _value.viewCount
                : viewCount // ignore: cast_nullable_to_non_nullable
                      as int,
            createdAt: freezed == createdAt
                ? _value.createdAt
                : createdAt // ignore: cast_nullable_to_non_nullable
                      as DateTime?,
            location: freezed == location
                ? _value.location
                : location // ignore: cast_nullable_to_non_nullable
                      as String?,
            description: freezed == description
                ? _value.description
                : description // ignore: cast_nullable_to_non_nullable
                      as String?,
            rating: null == rating
                ? _value.rating
                : rating // ignore: cast_nullable_to_non_nullable
                      as double,
            reviewCount: null == reviewCount
                ? _value.reviewCount
                : reviewCount // ignore: cast_nullable_to_non_nullable
                      as int,
            isFeatured: null == isFeatured
                ? _value.isFeatured
                : isFeatured // ignore: cast_nullable_to_non_nullable
                      as bool,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$ProductEntityImplCopyWith<$Res>
    implements $ProductEntityCopyWith<$Res> {
  factory _$$ProductEntityImplCopyWith(
    _$ProductEntityImpl value,
    $Res Function(_$ProductEntityImpl) then,
  ) = __$$ProductEntityImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({
    String id,
    String name,
    @JsonKey(fromJson: _readPrice) int price,
    int? originalPrice,
    String imageUrl,
    List<String> additionalImages,
    int stock,
    String category,
    String? brand,
    List<String> tags,
    int salesCount,
    int viewCount,
    DateTime? createdAt,
    String? location,
    String? description,
    double rating,
    int reviewCount,
    bool isFeatured,
  });
}

/// @nodoc
class __$$ProductEntityImplCopyWithImpl<$Res>
    extends _$ProductEntityCopyWithImpl<$Res, _$ProductEntityImpl>
    implements _$$ProductEntityImplCopyWith<$Res> {
  __$$ProductEntityImplCopyWithImpl(
    _$ProductEntityImpl _value,
    $Res Function(_$ProductEntityImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of ProductEntity
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? price = null,
    Object? originalPrice = freezed,
    Object? imageUrl = null,
    Object? additionalImages = null,
    Object? stock = null,
    Object? category = null,
    Object? brand = freezed,
    Object? tags = null,
    Object? salesCount = null,
    Object? viewCount = null,
    Object? createdAt = freezed,
    Object? location = freezed,
    Object? description = freezed,
    Object? rating = null,
    Object? reviewCount = null,
    Object? isFeatured = null,
  }) {
    return _then(
      _$ProductEntityImpl(
        id: null == id
            ? _value.id
            : id // ignore: cast_nullable_to_non_nullable
                  as String,
        name: null == name
            ? _value.name
            : name // ignore: cast_nullable_to_non_nullable
                  as String,
        price: null == price
            ? _value.price
            : price // ignore: cast_nullable_to_non_nullable
                  as int,
        originalPrice: freezed == originalPrice
            ? _value.originalPrice
            : originalPrice // ignore: cast_nullable_to_non_nullable
                  as int?,
        imageUrl: null == imageUrl
            ? _value.imageUrl
            : imageUrl // ignore: cast_nullable_to_non_nullable
                  as String,
        additionalImages: null == additionalImages
            ? _value._additionalImages
            : additionalImages // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        stock: null == stock
            ? _value.stock
            : stock // ignore: cast_nullable_to_non_nullable
                  as int,
        category: null == category
            ? _value.category
            : category // ignore: cast_nullable_to_non_nullable
                  as String,
        brand: freezed == brand
            ? _value.brand
            : brand // ignore: cast_nullable_to_non_nullable
                  as String?,
        tags: null == tags
            ? _value._tags
            : tags // ignore: cast_nullable_to_non_nullable
                  as List<String>,
        salesCount: null == salesCount
            ? _value.salesCount
            : salesCount // ignore: cast_nullable_to_non_nullable
                  as int,
        viewCount: null == viewCount
            ? _value.viewCount
            : viewCount // ignore: cast_nullable_to_non_nullable
                  as int,
        createdAt: freezed == createdAt
            ? _value.createdAt
            : createdAt // ignore: cast_nullable_to_non_nullable
                  as DateTime?,
        location: freezed == location
            ? _value.location
            : location // ignore: cast_nullable_to_non_nullable
                  as String?,
        description: freezed == description
            ? _value.description
            : description // ignore: cast_nullable_to_non_nullable
                  as String?,
        rating: null == rating
            ? _value.rating
            : rating // ignore: cast_nullable_to_non_nullable
                  as double,
        reviewCount: null == reviewCount
            ? _value.reviewCount
            : reviewCount // ignore: cast_nullable_to_non_nullable
                  as int,
        isFeatured: null == isFeatured
            ? _value.isFeatured
            : isFeatured // ignore: cast_nullable_to_non_nullable
                  as bool,
      ),
    );
  }
}

/// @nodoc
@JsonSerializable()
class _$ProductEntityImpl implements _ProductEntity {
  const _$ProductEntityImpl({
    required this.id,
    required this.name,
    @JsonKey(fromJson: _readPrice) this.price = 0,
    this.originalPrice,
    required this.imageUrl,
    final List<String> additionalImages = const [],
    this.stock = 0,
    required this.category,
    this.brand,
    final List<String> tags = const [],
    this.salesCount = 0,
    this.viewCount = 0,
    this.createdAt,
    this.location,
    this.description,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.isFeatured = false,
  }) : _additionalImages = additionalImages,
       _tags = tags;

  factory _$ProductEntityImpl.fromJson(Map<String, dynamic> json) =>
      _$$ProductEntityImplFromJson(json);

  /// Core identifiers
  @override
  final String id;
  @override
  final String name;

  /// Pricing (PAISE, not double)
  @override
  @JsonKey(fromJson: _readPrice)
  final int price;
  // selling price
  @override
  final int? originalPrice;
  // MRP (optional)
  /// Media
  @override
  final String imageUrl;
  final List<String> _additionalImages;
  @override
  @JsonKey()
  List<String> get additionalImages {
    if (_additionalImages is EqualUnmodifiableListView)
      return _additionalImages;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_additionalImages);
  }

  /// Inventory
  @override
  @JsonKey()
  final int stock;
  // 0 = out of stock
  /// Classification
  @override
  final String category;
  @override
  final String? brand;
  final List<String> _tags;
  @override
  @JsonKey()
  List<String> get tags {
    if (_tags is EqualUnmodifiableListView) return _tags;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_tags);
  }

  /// Metrics for AI Scoring
  @override
  @JsonKey()
  final int salesCount;
  @override
  @JsonKey()
  final int viewCount;
  @override
  final DateTime? createdAt;

  /// Hyperlocal
  @override
  final String? location;

  /// Optional content
  @override
  final String? description;

  /// Social proof (optional)
  @override
  @JsonKey()
  final double rating;
  @override
  @JsonKey()
  final int reviewCount;

  /// Flags
  @override
  @JsonKey()
  final bool isFeatured;

  @override
  String toString() {
    return 'ProductEntity(id: $id, name: $name, price: $price, originalPrice: $originalPrice, imageUrl: $imageUrl, additionalImages: $additionalImages, stock: $stock, category: $category, brand: $brand, tags: $tags, salesCount: $salesCount, viewCount: $viewCount, createdAt: $createdAt, location: $location, description: $description, rating: $rating, reviewCount: $reviewCount, isFeatured: $isFeatured)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ProductEntityImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.originalPrice, originalPrice) ||
                other.originalPrice == originalPrice) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl) &&
            const DeepCollectionEquality().equals(
              other._additionalImages,
              _additionalImages,
            ) &&
            (identical(other.stock, stock) || other.stock == stock) &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.brand, brand) || other.brand == brand) &&
            const DeepCollectionEquality().equals(other._tags, _tags) &&
            (identical(other.salesCount, salesCount) ||
                other.salesCount == salesCount) &&
            (identical(other.viewCount, viewCount) ||
                other.viewCount == viewCount) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.rating, rating) || other.rating == rating) &&
            (identical(other.reviewCount, reviewCount) ||
                other.reviewCount == reviewCount) &&
            (identical(other.isFeatured, isFeatured) ||
                other.isFeatured == isFeatured));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
    runtimeType,
    id,
    name,
    price,
    originalPrice,
    imageUrl,
    const DeepCollectionEquality().hash(_additionalImages),
    stock,
    category,
    brand,
    const DeepCollectionEquality().hash(_tags),
    salesCount,
    viewCount,
    createdAt,
    location,
    description,
    rating,
    reviewCount,
    isFeatured,
  );

  /// Create a copy of ProductEntity
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ProductEntityImplCopyWith<_$ProductEntityImpl> get copyWith =>
      __$$ProductEntityImplCopyWithImpl<_$ProductEntityImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ProductEntityImplToJson(this);
  }
}

abstract class _ProductEntity implements ProductEntity {
  const factory _ProductEntity({
    required final String id,
    required final String name,
    @JsonKey(fromJson: _readPrice) final int price,
    final int? originalPrice,
    required final String imageUrl,
    final List<String> additionalImages,
    final int stock,
    required final String category,
    final String? brand,
    final List<String> tags,
    final int salesCount,
    final int viewCount,
    final DateTime? createdAt,
    final String? location,
    final String? description,
    final double rating,
    final int reviewCount,
    final bool isFeatured,
  }) = _$ProductEntityImpl;

  factory _ProductEntity.fromJson(Map<String, dynamic> json) =
      _$ProductEntityImpl.fromJson;

  /// Core identifiers
  @override
  String get id;
  @override
  String get name;

  /// Pricing (PAISE, not double)
  @override
  @JsonKey(fromJson: _readPrice)
  int get price; // selling price
  @override
  int? get originalPrice; // MRP (optional)
  /// Media
  @override
  String get imageUrl;
  @override
  List<String> get additionalImages;

  /// Inventory
  @override
  int get stock; // 0 = out of stock
  /// Classification
  @override
  String get category;
  @override
  String? get brand;
  @override
  List<String> get tags;

  /// Metrics for AI Scoring
  @override
  int get salesCount;
  @override
  int get viewCount;
  @override
  DateTime? get createdAt;

  /// Hyperlocal
  @override
  String? get location;

  /// Optional content
  @override
  String? get description;

  /// Social proof (optional)
  @override
  double get rating;
  @override
  int get reviewCount;

  /// Flags
  @override
  bool get isFeatured;

  /// Create a copy of ProductEntity
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ProductEntityImplCopyWith<_$ProductEntityImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
