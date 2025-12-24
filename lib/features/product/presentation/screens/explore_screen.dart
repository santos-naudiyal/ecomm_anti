import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/explore/explore_app_bar.dart';
import '../widgets/explore/explore_stories.dart';
import '../widgets/explore/smart_filter_bar.dart';
import '../widgets/explore/explore_banner_slider.dart';
import '../widgets/explore/flash_sale_section.dart';
import '../widgets/explore/category_masonry_grid.dart';
import '../../../../core/theme/app_text_styles.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          /// ================= NEW APP BAR =================
          const ExploreAppBar(),

          /// ================= STORIES =================
          const ExploreStories(),

          /// ================= BANNER SLIDER =================
          const ExploreBannerSlider(),

          /// ================= SMART FILTERS =================
          const SmartFilterBar(),

          /// ================= FLASH SALE =================
          const FlashSaleSection(),

          /// ================= CATEGORIES HEADER =================
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Curated For You', style: AppTextStyles.headingLarge),
                  Text(
                    'See All',
                    style: AppTextStyles.button.copyWith(
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ),
          ),

          /// ================= CATEGORY GRID =================
          const CategoryMasonryGrid(),

          const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
        ],
      ),
    );
  }
}
