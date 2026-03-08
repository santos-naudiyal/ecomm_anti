import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../domain/services/trending_service.dart';
import '../../controllers/product_controller.dart';
import '../../../domain/entities/product_entity.dart';

class TrendingSection extends ConsumerWidget {
  final String? location;
  final String title;

  const TrendingSection({
    super.key,
    this.location,
    required this.title,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final trendingIdsStream = ref.watch(trendingServiceProvider.notifier).getTrendingProductIds(location: location);

    return StreamBuilder<List<String>>(
      stream: trendingIdsStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const SliverToBoxAdapter(child: SizedBox.shrink());
        }

        final productIds = snapshot.data!;

        return SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
                child: Row(
                  children: [
                    Text('🔥', style: TextStyle(fontSize: 20)),
                    const SizedBox(width: 8),
                    Text(title, style: AppTextStyles.headingLarge),
                  ],
                ),
              ),
              SizedBox(
                height: 220,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  scrollDirection: Axis.horizontal,
                  itemCount: productIds.length,
                  itemBuilder: (context, index) {
                    final productId = productIds[index];
                    return _TrendingProductItem(productId: productId);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TrendingProductItem extends ConsumerWidget {
  final String productId;
  const _TrendingProductItem({required this.productId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final productAsync = ref.watch(productDetailsProvider(productId));

    return productAsync.when(
      data: (product) {
        if (product == null) return const SizedBox.shrink();
        return Container(
          width: 160,
          margin: const EdgeInsets.only(right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  product.imageUrl,
                  height: 140,
                  width: 160,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                product.name,
                style: AppTextStyles.body.copyWith(fontWeight: FontWeight.w600),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              Text(
                '₹${(product.price / 100).toStringAsFixed(0)}',
                style: AppTextStyles.body.copyWith(color: AppColors.primary),
              ),
            ],
          ),
        );
      },
      loading: () => Container(width: 160, color: Colors.grey[200]),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}
