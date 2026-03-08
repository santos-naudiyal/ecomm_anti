import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class LiveCommerceSection extends StatelessWidget {
  const LiveCommerceSection({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 24, 16, 12),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.error,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: const Text('LIVE', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 10)),
                ),
                const SizedBox(width: 8),
                Text('Live Shopping', style: AppTextStyles.headingLarge),
              ],
            ),
          ),
          SizedBox(
            height: 200,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              scrollDirection: Axis.horizontal,
              itemCount: 3,
              itemBuilder: (context, index) {
                return _LiveStreamCard(index: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _LiveStreamCard extends StatelessWidget {
  final int index;
  const _LiveStreamCard({required this.index});

  @override
  Widget build(BuildContext context) {
    final images = [
      'https://images.unsplash.com/photo-1441986300917-64674bd600d8',
      'https://images.unsplash.com/photo-1523275335684-37898b6baf30',
      'https://images.unsplash.com/photo-1505740420928-5e560c06d30e',
    ];

    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        image: DecorationImage(
          image: NetworkImage(images[index % images.length]),
          fit: BoxFit.cover,
        ),
      ),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [Colors.transparent, Colors.black.withOpacity(0.7)],
              ),
            ),
          ),
          Positioned(
            bottom: 12,
            left: 12,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Seller Name', style: AppTextStyles.caption.copyWith(color: Colors.white, fontWeight: FontWeight.bold)),
                Text('👀 1.2k watching', style: AppTextStyles.caption.copyWith(color: Colors.white70, fontSize: 10)),
              ],
            ),
          ),
          const Center(child: Icon(Icons.play_circle_fill, color: Colors.white, size: 40)),
        ],
      ),
    );
  }
}
