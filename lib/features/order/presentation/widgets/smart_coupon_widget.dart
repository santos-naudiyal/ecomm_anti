import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class SmartCouponWidget extends StatelessWidget {
  final int subtotal;
  const SmartCouponWidget({super.key, required this.subtotal});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
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
              const Icon(Icons.local_offer, color: AppColors.primary, size: 20),
              const SizedBox(width: 8),
              Text('Smart Coupon Applied', style: AppTextStyles.headingMedium),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('SAVE20', style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold)),
                  Text('Extra 20% off for you', style: AppTextStyles.caption),
                ],
              ),
              Text(
                '-₹${((subtotal * 0.2) / 100).toStringAsFixed(0)}',
                style: AppTextStyles.body.copyWith(color: AppColors.primary, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
