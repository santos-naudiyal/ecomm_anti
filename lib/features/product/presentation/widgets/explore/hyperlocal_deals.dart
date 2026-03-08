import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class HyperlocalDeals extends StatelessWidget {
  const HyperlocalDeals({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        margin: const EdgeInsets.all(16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.05),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Colors.blue.withOpacity(0.1)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.blue),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Hyperlocal Deals', style: AppTextStyles.headingMedium),
                      Text('Deliverable within 1 hour in Mumbai', style: AppTextStyles.caption),
                    ],
                  ),
                ),
                TextButton(onPressed: () {}, child: const Text('View All')),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                _MiniProduct(label: 'Fast Delivery'),
                const SizedBox(width: 12),
                _MiniProduct(label: 'Near You'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MiniProduct extends StatelessWidget {
  final String label;
  const _MiniProduct({required this.label});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 4)],
        ),
        child: Center(child: Text(label, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold))),
      ),
    );
  }
}
