import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../../../../gamification/presentation/widgets/gamification_header.dart';

class ExploreAppBar extends StatelessWidget {
  const ExploreAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      floating: true,
      expandedHeight: 140,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      systemOverlayStyle: Theme.of(context).brightness == Brightness.dark
          ? SystemUiOverlayStyle.light
          : SystemUiOverlayStyle.dark,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(color: Theme.of(context).scaffoldBackgroundColor),
        titlePadding: EdgeInsets.zero,
        title: const _SearchSection(),
        expandedTitleScale: 1.0,
      ),
      bottom: const PreferredSize(
        preferredSize: Size.fromHeight(0),
        child: SizedBox.shrink(),
      ),
    );
  }
}

class _SearchSection extends StatelessWidget {
  const _SearchSection();

  Future<void> _handleCameraSearch() async {
    final ImagePicker picker = ImagePicker();
    try {
      final XFile? image = await picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        // TODO: Implement image search logic
        print("Image selected: ${image.path}");
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  void _handleVoiceSearch(BuildContext context) {
    // Stub for now, show feedback
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Voice Search Listening... 🎙️')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return LayoutBuilder(
      builder: (context, constraints) {
        final percent =
            ((constraints.maxHeight - kToolbarHeight) / (140 - kToolbarHeight))
                .clamp(0.0, 1.0);

        return Padding(
          padding: const EdgeInsets.only(left: 16, right: 16, bottom: 8),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title & Wallet info
              AnimatedOpacity(
                duration: const Duration(milliseconds: 200),
                opacity: percent > 0.5 ? 1.0 : 0.0,
                child: percent > 0.5
                    ? Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Explore',
                              style: AppTextStyles.displayLarge.copyWith(
                                height: 1,
                                color: Theme.of(
                                  context,
                                ).textTheme.headlineLarge?.color,
                              ),
                            ),
                            const GamificationHeader(),
                          ],
                        ),
                      )
                    : const SizedBox.shrink(),
              ),

              // Search Bar
              Row(
                children: [
                  Expanded(
                    child: Container(
                      height: 50,
                      decoration: BoxDecoration(
                        color: isDark ? const Color(0xFF374151) : Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                        border: Border.all(
                          color: isDark ? Colors.transparent : AppColors.border,
                          width: 1,
                        ),
                      ),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () {
                            // TODO: Navigation to Search Page
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: isDark
                                      ? Colors.grey[400]
                                      : AppColors.textTertiary,
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Text(
                                    'Search for brands...',
                                    style: AppTextStyles.body.copyWith(
                                      color: isDark
                                          ? Colors.grey[400]
                                          : AppColors.textTertiary,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                // Voice Search
                                _ActionButton(
                                  icon: Icons.mic_none_rounded,
                                  onTap: () => _handleVoiceSearch(context),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  // Camera Button
                  Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: AppColors.primary.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(16),
                        onTap: () => _handleCameraSearch(),
                        child: const Icon(
                          Icons.camera_alt_outlined,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ActionButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const _ActionButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Icon(
            icon,
            color: isDark ? Colors.grey[400] : AppColors.textSecondary,
            size: 24,
          ),
        ),
      ),
    );
  }
}
