import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class AISummaryWidget extends StatelessWidget {
  final String description;
  const AISummaryWidget({super.key, required this.description});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.primary.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.psychology, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text('AI Description Summary', style: AppTextStyles.headingMedium),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            'This premium product is highly rated for its durability and sleek design. Perfect for users who value quality and modern aesthetics.',
            style: AppTextStyles.body.copyWith(fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _SentimentBadge(label: 'Positive Sentiment', icon: Icons.sentiment_very_satisfied, color: Colors.green),
              const SizedBox(width: 8),
              _SentimentBadge(label: '98% Recommended', icon: Icons.thumb_up, color: Colors.blue),
            ],
          ),
        ],
      ),
    );
  }
}

class _SentimentBadge extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;
  const _SentimentBadge({required this.label, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(label, style: AppTextStyles.caption.copyWith(color: color, fontWeight: FontWeight.bold, fontSize: 10)),
        ],
      ),
    );
  }
}
