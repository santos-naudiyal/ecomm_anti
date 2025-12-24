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
      expandedHeight: 140,
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
                      Text(
                        'Antigravity',
                        style: GoogleFonts.outfit(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                      const Spacer(),
                      _GlassIcon(
                        icon: Icons.notifications_outlined,
                        onTap: () {},
                      ),
                      const SizedBox(width: 10),
                      _GlassIcon(
                        icon: Icons.shopping_bag_outlined,
                        onTap: () => context.push('/cart'),
                      ),
                    ],
                  ),
                  const Spacer(),

                  /// LOCATION
                  GestureDetector(
                    onTap: () => context.push('/cart/addresses'),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.18),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(
                            Icons.location_on_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                          const SizedBox(width: 8),
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
                            color: Colors.white,
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
            Text(
              title,
              style: GoogleFonts.outfit(
                fontSize: 20,
                fontWeight: FontWeight.w600,
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

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 90,
        child: categoriesAsync.when(
          data: (list) => ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            itemBuilder: (_, i) => GestureDetector(
              onTap: () => context.push('/explore/category', extra: list[i]),
              child: Container(
                width: 90,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(18),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    list[i],
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
            separatorBuilder: (_, __) => const SizedBox(width: 12),
            itemCount: list.length,
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (_, __) => const SizedBox(),
        ),
      ),
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
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 14,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(20),
                ),
                child: Image.network(product.imageUrl, fit: BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(fontSize: 13),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '₹${(product.price / 100).toStringAsFixed(0)}',
                        style: GoogleFonts.outfit(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      const Spacer(),
                      const Icon(Icons.star, size: 14, color: Colors.amber),
                      const Text('4.5', style: TextStyle(fontSize: 12)),
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
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.orange, Colors.deepOrange],
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Deal of the Day',
                  style: TextStyle(color: Colors.white70),
                ),
                SizedBox(height: 8),
                Text(
                  'Up to 50% OFF',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Icon(Icons.local_offer, size: 64, color: Colors.white),
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
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(image, fit: BoxFit.cover),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.6), Colors.transparent],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: GoogleFonts.outfit(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(subtitle, style: const TextStyle(color: Colors.white70)),
              ],
            ),
          ),
        ],
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
