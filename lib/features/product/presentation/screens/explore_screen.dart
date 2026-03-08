import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../controllers/product_controller.dart';
import '../widgets/explore/explore_app_bar.dart';
import '../widgets/explore/explore_banner_slider.dart';
import '../widgets/explore/explore_stories.dart';
import '../widgets/explore/flash_sale_section.dart';
import '../widgets/explore/smart_filter_bar.dart';
import '../widgets/explore/smart_product_grid.dart';
import '../../../gamification/presentation/widgets/daily_reward_section.dart';
import '../widgets/explore/trending_section.dart';
import '../widgets/explore/live_commerce_section.dart';
import '../widgets/explore/hyperlocal_deals.dart';

class ExploreScreen extends ConsumerWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(smartFeedProductsProvider.notifier).refresh();
        },
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            /// ================= NEW APP BAR =================
            const ExploreAppBar(),

            /// ================= DAILY REWARD =================
            const DailyRewardSection(),

            /// ================= STORIES =================
            const ExploreStories(),

            /// ================= BANNER SLIDER =================
            const ExploreBannerSlider(),

            /// ================= SMART FILTERS =================
            const SmartFilterBar(),

            /// ================= FLASH SALE =================
            const FlashSaleSection(),

            /// ================= TRENDING SECTIONS =================
            const TrendingSection(
              title: 'Trending in Mumbai',
              location: 'Mumbai',
            ),

            /// ================= HYPERLOCAL DEALS =================
            const HyperlocalDeals(),

            /// ================= LIVE COMMERCE =================
            const LiveCommerceSection(),

            const TrendingSection(
              title: 'Most Popular Today',
            ),

            /// ================= CATEGORIES HEADER =================
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Recommended For You', style: AppTextStyles.headingLarge),
                    Text(
                      'Smart Feed',
                      style: AppTextStyles.button.copyWith(
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            /// ================= SMART FEED GRID =================
            const SmartProductGrid(),

            const SliverPadding(padding: EdgeInsets.only(bottom: 100)),
          ],
        ),
      ),
    );
  }
}
