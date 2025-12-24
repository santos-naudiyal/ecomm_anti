import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:go_router/go_router.dart';
import '../../../../../core/theme/app_text_styles.dart';
import 'package:antigravity/features/product/presentation/controllers/product_controller.dart';

class CategoryMasonryGrid extends ConsumerWidget {
  const CategoryMasonryGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return categoriesAsync.when(
      data: (categories) {
        if (categories.isEmpty)
          return const SliverToBoxAdapter(child: SizedBox.shrink());

        return SliverPadding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          sliver: SliverMasonryGrid.count(
            crossAxisCount: 2,
            mainAxisSpacing: 16,
            crossAxisSpacing: 16,
            childCount: categories.length,
            itemBuilder: (context, index) {
              final category = categories[index];
              return _CategoryCard(index: index, category: category);
            },
          ),
        );
      },
      loading: () => const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.all(32.0),
          child: Center(child: CircularProgressIndicator()),
        ),
      ),
      error: (e, s) => SliverToBoxAdapter(child: Text('Error: $e')),
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final int index;
  final String category;

  const _CategoryCard({required this.index, required this.category});

  @override
  Widget build(BuildContext context) {
    // Height variance
    final height = (index % 3 == 0) ? 200.0 : 160.0;

    // Gradient colors based on index
    final colors = [
      [const Color(0xFF6dd5ed), const Color(0xFF2193b0)], // Blue
      [const Color(0xFFff9966), const Color(0xFFff5e62)], // Orange/Red
      [const Color(0xFF56ab2f), const Color(0xFFa8e063)], // Green
      [const Color(0xFF8E2DE2), const Color(0xFF4A00E0)], // Purple
      [const Color(0xFFee9ca7), const Color(0xFFffdde1)], // Pink
    ];
    final gradient = colors[index % colors.length];

    return GestureDetector(
      onTap: () => context.push('/explore/category', extra: category),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: gradient[0].withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: Stack(
          children: [
            // Background Decoration
            Positioned(
              right: -20,
              top: -20,
              child: CircleAvatar(
                radius: 60,
                backgroundColor: Colors.white.withOpacity(0.1),
              ),
            ),
            Positioned(
              bottom: -30,
              left: -30,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white.withOpacity(0.1),
              ),
            ),

            // Content
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Icon(
                      _getIconForCategory(category),
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    category.toUpperCase(),
                    style: AppTextStyles.headingSmall.copyWith(
                      color: Colors.white,
                      fontSize: 16,
                      letterSpacing: 1.0,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Text(
                        'Explore',
                        style: AppTextStyles.caption.copyWith(
                          color: Colors.white.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(width: 4),
                      Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white.withOpacity(0.8),
                        size: 14,
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

  IconData _getIconForCategory(String category) {
    final lower = category.toLowerCase();
    if (lower.contains('tech') || lower.contains('electronic'))
      return Icons.devices;
    if (lower.contains('jewel')) return Icons.diamond_outlined;
    if (lower.contains('cloth') || lower.contains('fashion'))
      return Icons.checkroom;
    if (lower.contains('shoe')) return Icons.roller_skating;
    if (lower.contains('watch')) return Icons.watch;
    if (lower.contains('home')) return Icons.chair_outlined;
    if (lower.contains('beauty')) return Icons.face;
    return Icons.grid_view;
  }
}
