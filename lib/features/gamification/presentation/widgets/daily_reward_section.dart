import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../controllers/gamification_controller.dart';

class DailyRewardSection extends ConsumerWidget {
  const DailyRewardSection({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: AppColors.primaryGradient,
            borderRadius: BorderRadius.circular(24),
          ),
          child: Column(
            children: [
              const Icon(Icons.stars, color: Colors.white, size: 48),
              const SizedBox(height: 12),
              Text(
                'Daily Login Reward',
                style: AppTextStyles.headingLarge.copyWith(color: Colors.white),
              ),
              const SizedBox(height: 8),
              Text(
                'Claim your daily 50 coins and keep your streak alive!',
                style: AppTextStyles.body.copyWith(color: Colors.white.withOpacity(0.9)),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  ref.read(gamificationControllerProvider.notifier).claimDailyReward();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('50 Coins added to your wallet! 💰')),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: AppColors.primary,
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Claim Reward'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
