import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class ExploreStories extends StatelessWidget {
  const ExploreStories({super.key});

  @override
  Widget build(BuildContext context) {
    final stories = [
      {
        'name': 'Nike',
        'image': 'https://images.unsplash.com/photo-1542291026-7eec264c27ff',
        'hasStory': true,
      },
      {
        'name': 'Adidas',
        'image': 'https://images.unsplash.com/photo-1518002171953-a080ee321e2f',
        'hasStory': true,
      },
      {
        'name': 'Puma',
        'image': 'https://images.unsplash.com/photo-1608231387042-66d1773070a5',
        'hasStory': true,
      },
      {
        'name': 'Zara',
        'image': 'https://images.unsplash.com/photo-1441986300917-64674bd600d8',
        'hasStory': false,
      },
      {
        'name': 'H&M',
        'image': 'https://images.unsplash.com/photo-1483985988355-763728e1935b',
        'hasStory': true,
      },
      {
        'name': 'Gucci',
        'image': 'https://images.unsplash.com/photo-1548036328-c9fa89d128fa',
        'hasStory': false,
      },
    ];

    return SliverToBoxAdapter(
      child: Container(
        height: 110,
        margin: const EdgeInsets.only(top: 8),
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: stories.length,
          separatorBuilder: (context, index) => const SizedBox(width: 16),
          itemBuilder: (context, index) {
            final story = stories[index];
            return _StoryItem(
              name: story['name'] as String,
              imageUrl: story['image'] as String,
              hasStory: story['hasStory'] as bool,
            );
          },
        ),
      ),
    );
  }
}

class _StoryItem extends StatelessWidget {
  final String name;
  final String imageUrl;
  final bool hasStory;

  const _StoryItem({
    required this.name,
    required this.imageUrl,
    required this.hasStory,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Viewing story for $name')));
      },
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(3),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: hasStory ? AppColors.primaryGradient : null,
              border: !hasStory
                  ? Border.all(
                      color: isDark ? Colors.grey[700]! : AppColors.border,
                      width: 2,
                    )
                  : null,
            ),
            child: Container(
              padding: const EdgeInsets.all(2),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: CircleAvatar(
                radius: 32,
                backgroundColor: Theme.of(
                  context,
                ).colorScheme.surfaceContainerHighest,
                backgroundImage: NetworkImage(imageUrl),
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            name,
            style: AppTextStyles.caption.copyWith(
              fontWeight: hasStory ? FontWeight.w600 : FontWeight.w400,
              color: isDark
                  ? Colors.grey[300]
                  : (hasStory
                        ? AppColors.textPrimary
                        : AppColors.textSecondary),
            ),
          ),
        ],
      ),
    );
  }
}
