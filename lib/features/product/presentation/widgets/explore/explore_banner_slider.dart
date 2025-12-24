import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_text_styles.dart';

class ExploreBannerSlider extends StatelessWidget {
  const ExploreBannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    final items = [
      _BannerItem(
        title: 'New Season\nArrivals',
        subtitle: 'SUMMER 2024',
        image: 'https://images.unsplash.com/photo-1483985988355-763728e1935b',
      ),
      _BannerItem(
        title: 'Premium\nTech Gear',
        subtitle: 'UP TO 30% OFF',
        image:
            'https://images.unsplash.com/photo-1550009158-9ebf69173e03', // Fixed URL
      ),
    ];

    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.only(top: 16, bottom: 8),
        child: CarouselSlider(
          options: CarouselOptions(
            height: 220, // Increased height to prevent overflow
            viewportFraction: 0.92,
            enlargeCenterPage: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            enableInfiniteScroll: true,
          ),
          items: items.map((item) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    color: Theme.of(
                      context,
                    ).colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(20),
                    image: DecorationImage(
                      image: NetworkImage(item.image),
                      fit: BoxFit.cover,
                      colorFilter: ColorFilter.mode(
                        Colors.black.withOpacity(0.3),
                        BlendMode.darken,
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(24.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            item.subtitle,
                            style: AppTextStyles.caption.copyWith(
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                              color: Colors.black,
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        Flexible(
                          // Prevent overflow
                          child: Text(
                            item.title,
                            style: AppTextStyles.displayLarge.copyWith(
                              color: Colors.white,
                              fontSize: 28,
                              height: 1.1,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 16),
                        ElevatedButton(
                          onPressed: () {
                            // Verified tap
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.black,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 20,
                              vertical: 12,
                            ),
                            minimumSize: Size.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          child: const Text('Shop Now'),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}

class _BannerItem {
  final String title;
  final String subtitle;
  final String image;

  _BannerItem({
    required this.title,
    required this.subtitle,
    required this.image,
  });
}
