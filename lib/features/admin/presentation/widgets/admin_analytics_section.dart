import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class AdminAnalyticsSection extends StatelessWidget {
  const AdminAnalyticsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Real-Time Analytics', style: AppTextStyles.headingLarge),
        const SizedBox(height: 16),
        Row(
          children: [
            _StatCard(title: 'Revenue', value: '₹4,52,000', color: Colors.green, icon: Icons.trending_up),
            const SizedBox(width: 12),
            _StatCard(title: 'Orders', value: '1,240', color: Colors.blue, icon: Icons.shopping_cart),
          ],
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Conversion Funnel', style: AppTextStyles.headingMedium),
              const SizedBox(height: 16),
              _FunnelStep(label: 'Product Views', value: '15,000', percent: 1.0, color: Colors.blue),
              _FunnelStep(label: 'Add to Cart', value: '3,000', percent: 0.2, color: Colors.orange),
              _FunnelStep(label: 'Checkout', value: '1,500', percent: 0.1, color: Colors.purple),
              _FunnelStep(label: 'Purchased', value: '800', percent: 0.05, color: Colors.green),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatCard extends StatelessWidget {
  final String title;
  final String value;
  final Color color;
  final IconData icon;

  const _StatCard({required this.title, required this.value, required this.color, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withOpacity(0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 24),
            const SizedBox(height: 12),
            Text(title, style: AppTextStyles.caption.copyWith(color: color, fontWeight: FontWeight.bold)),
            Text(value, style: AppTextStyles.headingMedium.copyWith(color: color)),
          ],
        ),
      ),
    );
  }
}

class _FunnelStep extends StatelessWidget {
  final String label;
  final String value;
  final double percent;
  final Color color;

  const _FunnelStep({required this.label, required this.value, required this.percent, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: AppTextStyles.body),
              Text(value, style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: percent,
              backgroundColor: color.withOpacity(0.1),
              valueColor: AlwaysStoppedAnimation(color),
              minHeight: 8,
            ),
          ),
        ],
      ),
    );
  }
}
