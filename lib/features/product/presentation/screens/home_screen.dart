import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../product/presentation/controllers/product_controller.dart';
import '../../../product/domain/entities/product_entity.dart';
import '../../../cart/presentation/controllers/address_controller.dart';
import '../../../../core/theme/app_colors.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final featuredAsync = ref.watch(featuredProductsProvider);
    final categoriesAsync = ref.watch(categoriesProvider);
    final addressAsync = ref.watch(addressControllerProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          /// ================= APP BAR =================
          _HomeSliverAppBar(addressAsync),

          /// ================= SEARCH =================
          const SliverPadding(padding: EdgeInsets.only(top: 12)),
          const _SearchBar(),

          /// ================= HERO =================
          const SliverPadding(padding: EdgeInsets.only(top: 8)),
          const SliverToBoxAdapter(child: HeroBannerCarousel()),

          /// ================= CATEGORIES =================
          _SectionHeader(
            title: 'Categories',
            onTap: () => context.push('/explore/category'),
          ),
          _CategoriesStrip(categoriesAsync),

          /// ================= DEAL =================
          const SliverPadding(padding: EdgeInsets.only(top: 16)),
          const SliverToBoxAdapter(child: _DealOfTheDayBanner()),

          /// ================= PRODUCTS =================
          _SectionHeader(title: 'Featured for you'),
          _FeaturedProductsGrid(featuredAsync),

          const SliverPadding(padding: EdgeInsets.only(bottom: 40)),
        ],
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
/// APP BAR
///////////////////////////////////////////////////////////////////////////////

class _HomeSliverAppBar extends StatelessWidget {
  final AsyncValue addressAsync;
  const _HomeSliverAppBar(this.addressAsync);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      expandedHeight: 180,
      backgroundColor: Colors.transparent,
      elevation: 0,
      automaticallyImplyLeading: false,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.primary.withOpacity(0.85)],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TOP ROW
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Welcome to',
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.white70,
                              letterSpacing: 0.5,
                            ),
                          ),
                          Text(
                            'Tera Shop',
                            style: GoogleFonts.outfit(
                              fontSize: 26,
                              fontWeight: FontWeight.w800,
                              color: Colors.white,
                              letterSpacing: -0.5,
                            ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      _GlassIcon(
                        icon: Icons.notifications_none_rounded,
                        onTap: () {},
                      ),
                      const SizedBox(width: 12),
                      Stack(
                        children: [
                          _GlassIcon(
                            icon: Icons.shopping_bag_outlined,
                            onTap: () => context.push('/cart'),
                          ),
                          Positioned(
                            right: 4,
                            top: 4,
                            child: Container(
                              padding: const EdgeInsets.all(4),
                              decoration: const BoxDecoration(
                                color: Colors.orange,
                                shape: BoxShape.circle,
                              ),
                              child: const Text(
                                '0',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 8,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  /// LOCATION
                  GestureDetector(
                    onTap: () => context.push('/cart/addresses'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.12),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.2),
                          width: 1,
                        ),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(0.2),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.location_on_rounded,
                              color: Colors.white,
                              size: 14,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Flexible(
                            child: addressAsync.when(
                              data: (list) {
                                final a = list.isNotEmpty ? list.first : null;
                                return Text(
                                  a != null
                                      ? '${a.street}, ${a.city}'
                                      : 'Select delivery location',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                  ),
                                );
                              },
                              loading: () => const Text(
                                'Loading...',
                                style: TextStyle(color: Colors.white70),
                              ),
                              error: (_, __) => const Text(
                                'Set location',
                                style: TextStyle(color: Colors.white70),
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            color: Colors.white70,
                            size: 20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
/// SEARCH BAR
///////////////////////////////////////////////////////////////////////////////

class _SearchBar extends StatelessWidget {
  const _SearchBar();

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 20),
        child: Container(
          height: 52,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 14,
                offset: const Offset(0, 8),
              ),
            ],
          ),
          child: const TextField(
            decoration: InputDecoration(
              hintText: 'Search products',
              prefixIcon: Icon(Icons.search),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 14),
            ),
          ),
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
/// SECTION HEADER
///////////////////////////////////////////////////////////////////////////////

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onTap;

  const _SectionHeader({required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 28, 16, 12),
        child: Row(
          children: [
            Flexible(
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.outfit(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            const Spacer(),
            if (onTap != null)
              TextButton(onPressed: onTap, child: const Text('View all')),
          ],
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
/// CATEGORIES
///////////////////////////////////////////////////////////////////////////////

class _CategoriesStrip extends StatelessWidget {
  final AsyncValue<List<String>> categoriesAsync;
  const _CategoriesStrip(this.categoriesAsync);

  static const Map<String, IconData> _categoryIcons = {
    'Electronics': Icons.devices_other_rounded,
    'Fashion': Icons.checkroom_rounded,
    'Home': Icons.home_max_rounded,
    'Beauty': Icons.auto_awesome_rounded,
    'Sports': Icons.sports_basketball_rounded,
    'Groceries': Icons.shopping_basket_rounded,
  };

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 110,
        child: categoriesAsync.when(
          data: (list) => ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            physics: const BouncingScrollPhysics(),
            itemBuilder: (_, i) {
              final name = list[i];
              final icon = _categoryIcons[name] ?? Icons.category_rounded;
              return GestureDetector(
                onTap: () => context.push('/explore/category', extra: name),
                child: Column(
                  children: [
                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Center(
                        child: Icon(
                          icon,
                          color: AppColors.primary,
                          size: 32,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 80,
                      child: Text(
                        name,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemCount: list.length,
          ),
          loading: () => ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, __) => _CategoryShimmer(),
            separatorBuilder: (_, __) => const SizedBox(width: 16),
            itemCount: 5,
          ),
          error: (_, __) => const SizedBox(),
        ),
      ),
    );
  }
}

class _CategoryShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.05),
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 8),
        Container(
          width: 50,
          height: 10,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.05),
            borderRadius: BorderRadius.circular(5),
          ),
        ),
      ],
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
/// FEATURED PRODUCTS
///////////////////////////////////////////////////////////////////////////////

class _FeaturedProductsGrid extends StatelessWidget {
  final AsyncValue<List<ProductEntity>> featuredAsync;
  const _FeaturedProductsGrid(this.featuredAsync);

  @override
  Widget build(BuildContext context) {
    return featuredAsync.when(
      data: (products) => SliverPadding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        sliver: SliverGrid(
          delegate: SliverChildBuilderDelegate(
            (context, i) => _ProductCard(product: products[i]),
            childCount: products.length,
          ),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 220,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childAspectRatio: 0.66,
          ),
        ),
      ),
      loading: () => const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(40),
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (_, __) => const SliverToBoxAdapter(
        child: Center(child: Text('Failed to load products')),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
/// PRODUCT CARD
///////////////////////////////////////////////////////////////////////////////

class _ProductCard extends StatelessWidget {
  final ProductEntity product;
  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/explore/product/${product.id}'),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(24),
                      bottom: Radius.circular(24),
                    ),
                    child: Image.network(
                      product.imageUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: double.infinity,
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.9),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.favorite_border_rounded,
                        size: 18,
                        color: Colors.redAccent,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        '₹${(product.price / 100).toStringAsFixed(0)}',
                        style: GoogleFonts.outfit(
                          fontSize: 18,
                          fontWeight: FontWeight.w800,
                          color: AppColors.primary,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.star_rounded, size: 16, color: Colors.orange),
                      const SizedBox(width: 2),
                      Text(
                        '4.5',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
/// DEAL BANNER
///////////////////////////////////////////////////////////////////////////////

class _DealOfTheDayBanner extends StatelessWidget {
  const _DealOfTheDayBanner();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [const Color(0xFFFF5F6D), const Color(0xFFFFC371)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFFF5F6D).withOpacity(0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    'Limited Offer',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  'Deal of the Day',
                  style: GoogleFonts.poppins(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                Text(
                  'Up to 70% OFF on all items',
                  style: GoogleFonts.poppins(
                    color: Colors.white.withOpacity(0.9),
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.flash_on_rounded,
              size: 40,
              color: Colors.white,
            ),
          ),
        ],
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
/// HERO CAROUSEL
///////////////////////////////////////////////////////////////////////////////

class HeroBannerCarousel extends StatelessWidget {
  const HeroBannerCarousel({super.key});

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 180,
        autoPlay: true,
        viewportFraction: 0.92,
      ),
      items: [
        _HeroBanner(
          title: 'New Collection',
          subtitle: 'Premium picks',
          image: 'https://images.unsplash.com/photo-1523275335684-37898b6baf30',
        ),
        _HeroBanner(
          title: 'Exclusive Deals',
          subtitle: 'Limited time',
          image: 'https://images.unsplash.com/photo-1512436991641-6745cdb1723f',
        ),
      ],
    );
  }
}

class _HeroBanner extends StatelessWidget {
  final String image, title, subtitle;
  const _HeroBanner({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(image, fit: BoxFit.cover),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.1),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Text(
                      'NEW',
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    title,
                    style: GoogleFonts.outfit(
                      color: Colors.white,
                      fontSize: 26,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: GoogleFonts.poppins(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
/// GLASS ICON
///////////////////////////////////////////////////////////////////////////////

class _GlassIcon extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _GlassIcon({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.18),
          borderRadius: BorderRadius.circular(14),
        ),
        child: Icon(icon, color: Colors.white),
      ),
    );
  }
}
