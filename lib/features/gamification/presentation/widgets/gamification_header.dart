import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../controllers/gamification_controller.dart';

class GamificationHeader extends ConsumerWidget {
  const GamificationHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final statsAsync = ref.watch(gamificationControllerProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return statsAsync.when(
      data: (stats) {
        final coins = stats['coins'] ?? 0;
        final streak = stats['streak'] ?? 0;

        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isDark ? const Color(0xFF1F2937) : Colors.white,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.05),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.monetization_on, color: Colors.amber, size: 20),
              const SizedBox(width: 6),
              Text(
                '$coins',
                style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 12),
              const Icon(Icons.local_fire_department, color: Colors.orange, size: 20),
              const SizedBox(width: 4),
              Text(
                '$streak days',
                style: AppTextStyles.body.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      },
      loading: () => const SizedBox.shrink(),
      error: (_, __) => const SizedBox.shrink(),
    );
  }
}
