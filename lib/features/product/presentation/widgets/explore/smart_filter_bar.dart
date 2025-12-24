import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';

class SmartFilterBar extends StatefulWidget {
  const SmartFilterBar({super.key});

  @override
  State<SmartFilterBar> createState() => _SmartFilterBarState();
}

class _SmartFilterBarState extends State<SmartFilterBar> {
  int _selectedIndex = 0;
  final List<String> _filters = [
    "All",
    "On Sale",
    "New Arrivals",
    "Trending",
    "Shoes",
    "Clothing",
    "Tech",
  ];

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SliverToBoxAdapter(
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(vertical: 8),
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          scrollDirection: Axis.horizontal,
          itemCount: _filters.length,
          separatorBuilder: (context, index) => const SizedBox(width: 10),
          itemBuilder: (context, index) {
            final isSelected = _selectedIndex == index;
            // Determine text color:
            // Selected -> White
            // Unselected Dark Mode -> White
            // Unselected Light Mode -> TextPrimary
            final labelColor = isSelected
                ? Colors.white
                : (isDark ? Colors.white : AppColors.textPrimary);

            return ChoiceChip(
              label: Text(_filters[index]),
              selected: isSelected,
              onSelected: (selected) {
                setState(() {
                  _selectedIndex = index;
                });
              },
              selectedColor: AppColors.textPrimary, // Or primary color
              backgroundColor: isDark ? const Color(0xFF374151) : Colors.white,
              labelStyle: isSelected
                  ? AppTextStyles.button.copyWith(
                      fontSize: 14,
                      color: Colors.white,
                    )
                  : AppTextStyles.body.copyWith(color: labelColor),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
                side: BorderSide(
                  color: isSelected
                      ? Colors.transparent
                      : (isDark ? Colors.grey[700]! : AppColors.border),
                ),
              ),
              showCheckmark: false,
              elevation: isSelected ? 4 : 0,
              pressElevation: 0,
            );
          },
        ),
      ),
    );
  }
}
