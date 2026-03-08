// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$featuredProductsHash() => r'de48d6ebb5126b194211b91de7d010bf2ff05988';

/// ------------------------------------------------------------
/// FEATURED PRODUCTS
/// ------------------------------------------------------------
///
/// Copied from [FeaturedProducts].
@ProviderFor(FeaturedProducts)
final featuredProductsProvider =
    AutoDisposeAsyncNotifierProvider<
      FeaturedProducts,
      List<ProductEntity>
    >.internal(
      FeaturedProducts.new,
      name: r'featuredProductsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$featuredProductsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$FeaturedProducts = AutoDisposeAsyncNotifier<List<ProductEntity>>;
String _$categoriesHash() => r'c8c33019b20b87a0520b91e5f25a774b46ebd9f7';

/// ------------------------------------------------------------
/// CATEGORIES
/// ------------------------------------------------------------
///
/// Copied from [Categories].
@ProviderFor(Categories)
final categoriesProvider =
    AutoDisposeAsyncNotifierProvider<Categories, List<String>>.internal(
      Categories.new,
      name: r'categoriesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$categoriesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$Categories = AutoDisposeAsyncNotifier<List<String>>;
String _$productDetailsHash() => r'a2168b3111dc20433e3d11d5c427f3736b4358eb';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

abstract class _$ProductDetails
    extends BuildlessAutoDisposeAsyncNotifier<ProductEntity?> {
  late final String id;

  FutureOr<ProductEntity?> build(String id);
}

/// ------------------------------------------------------------
/// PRODUCT DETAILS (BY ID)
/// ------------------------------------------------------------
///
/// Copied from [ProductDetails].
@ProviderFor(ProductDetails)
const productDetailsProvider = ProductDetailsFamily();

/// ------------------------------------------------------------
/// PRODUCT DETAILS (BY ID)
/// ------------------------------------------------------------
///
/// Copied from [ProductDetails].
class ProductDetailsFamily extends Family<AsyncValue<ProductEntity?>> {
  /// ------------------------------------------------------------
  /// PRODUCT DETAILS (BY ID)
  /// ------------------------------------------------------------
  ///
  /// Copied from [ProductDetails].
  const ProductDetailsFamily();

  /// ------------------------------------------------------------
  /// PRODUCT DETAILS (BY ID)
  /// ------------------------------------------------------------
  ///
  /// Copied from [ProductDetails].
  ProductDetailsProvider call(String id) {
    return ProductDetailsProvider(id);
  }

  @override
  ProductDetailsProvider getProviderOverride(
    covariant ProductDetailsProvider provider,
  ) {
    return call(provider.id);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productDetailsProvider';
}

/// ------------------------------------------------------------
/// PRODUCT DETAILS (BY ID)
/// ------------------------------------------------------------
///
/// Copied from [ProductDetails].
class ProductDetailsProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<ProductDetails, ProductEntity?> {
  /// ------------------------------------------------------------
  /// PRODUCT DETAILS (BY ID)
  /// ------------------------------------------------------------
  ///
  /// Copied from [ProductDetails].
  ProductDetailsProvider(String id)
    : this._internal(
        () => ProductDetails()..id = id,
        from: productDetailsProvider,
        name: r'productDetailsProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$productDetailsHash,
        dependencies: ProductDetailsFamily._dependencies,
        allTransitiveDependencies:
            ProductDetailsFamily._allTransitiveDependencies,
        id: id,
      );

  ProductDetailsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final String id;

  @override
  FutureOr<ProductEntity?> runNotifierBuild(covariant ProductDetails notifier) {
    return notifier.build(id);
  }

  @override
  Override overrideWith(ProductDetails Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductDetailsProvider._internal(
        () => create()..id = id,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<ProductDetails, ProductEntity?>
  createElement() {
    return _ProductDetailsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductDetailsProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductDetailsRef on AutoDisposeAsyncNotifierProviderRef<ProductEntity?> {
  /// The parameter `id` of this provider.
  String get id;
}

class _ProductDetailsProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<ProductDetails, ProductEntity?>
    with ProductDetailsRef {
  _ProductDetailsProviderElement(super.provider);

  @override
  String get id => (origin as ProductDetailsProvider).id;
}

String _$productsByCategoryHash() =>
    r'e9fb27cb5124ba0a0a04d2573a11f8d57ccf3a3d';

abstract class _$ProductsByCategory
    extends BuildlessAutoDisposeAsyncNotifier<List<ProductEntity>> {
  late final String category;

  FutureOr<List<ProductEntity>> build(String category);
}

/// ------------------------------------------------------------
/// PRODUCTS BY CATEGORY
/// ------------------------------------------------------------
///
/// Copied from [ProductsByCategory].
@ProviderFor(ProductsByCategory)
const productsByCategoryProvider = ProductsByCategoryFamily();

/// ------------------------------------------------------------
/// PRODUCTS BY CATEGORY
/// ------------------------------------------------------------
///
/// Copied from [ProductsByCategory].
class ProductsByCategoryFamily extends Family<AsyncValue<List<ProductEntity>>> {
  /// ------------------------------------------------------------
  /// PRODUCTS BY CATEGORY
  /// ------------------------------------------------------------
  ///
  /// Copied from [ProductsByCategory].
  const ProductsByCategoryFamily();

  /// ------------------------------------------------------------
  /// PRODUCTS BY CATEGORY
  /// ------------------------------------------------------------
  ///
  /// Copied from [ProductsByCategory].
  ProductsByCategoryProvider call(String category) {
    return ProductsByCategoryProvider(category);
  }

  @override
  ProductsByCategoryProvider getProviderOverride(
    covariant ProductsByCategoryProvider provider,
  ) {
    return call(provider.category);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'productsByCategoryProvider';
}

/// ------------------------------------------------------------
/// PRODUCTS BY CATEGORY
/// ------------------------------------------------------------
///
/// Copied from [ProductsByCategory].
class ProductsByCategoryProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          ProductsByCategory,
          List<ProductEntity>
        > {
  /// ------------------------------------------------------------
  /// PRODUCTS BY CATEGORY
  /// ------------------------------------------------------------
  ///
  /// Copied from [ProductsByCategory].
  ProductsByCategoryProvider(String category)
    : this._internal(
        () => ProductsByCategory()..category = category,
        from: productsByCategoryProvider,
        name: r'productsByCategoryProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$productsByCategoryHash,
        dependencies: ProductsByCategoryFamily._dependencies,
        allTransitiveDependencies:
            ProductsByCategoryFamily._allTransitiveDependencies,
        category: category,
      );

  ProductsByCategoryProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.category,
  }) : super.internal();

  final String category;

  @override
  FutureOr<List<ProductEntity>> runNotifierBuild(
    covariant ProductsByCategory notifier,
  ) {
    return notifier.build(category);
  }

  @override
  Override overrideWith(ProductsByCategory Function() create) {
    return ProviderOverride(
      origin: this,
      override: ProductsByCategoryProvider._internal(
        () => create()..category = category,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        category: category,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    ProductsByCategory,
    List<ProductEntity>
  >
  createElement() {
    return _ProductsByCategoryProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ProductsByCategoryProvider && other.category == category;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ProductsByCategoryRef
    on AutoDisposeAsyncNotifierProviderRef<List<ProductEntity>> {
  /// The parameter `category` of this provider.
  String get category;
}

class _ProductsByCategoryProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          ProductsByCategory,
          List<ProductEntity>
        >
    with ProductsByCategoryRef {
  _ProductsByCategoryProviderElement(super.provider);

  @override
  String get category => (origin as ProductsByCategoryProvider).category;
}

String _$smartFeedProductsHash() => r'5107a1797ee488d2f9014076f9ca1d455e8bd063';

/// ------------------------------------------------------------
/// SMART FEED PRODUCTS (AI RANKED)
/// ------------------------------------------------------------
///
/// Copied from [SmartFeedProducts].
@ProviderFor(SmartFeedProducts)
final smartFeedProductsProvider =
    AutoDisposeAsyncNotifierProvider<
      SmartFeedProducts,
      List<ProductEntity>
    >.internal(
      SmartFeedProducts.new,
      name: r'smartFeedProductsProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$smartFeedProductsHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$SmartFeedProducts = AutoDisposeAsyncNotifier<List<ProductEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
