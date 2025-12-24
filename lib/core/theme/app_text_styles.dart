import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'app_colors.dart';

class AppTextStyles {
  // Headings
  static TextStyle get displayLarge => GoogleFonts.outfit(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  static TextStyle get headingLarge => GoogleFonts.outfit(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    letterSpacing: -0.5,
  );

  static TextStyle get headingMedium => GoogleFonts.outfit(
    fontSize: 20,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  static TextStyle get headingSmall => GoogleFonts.outfit(
    fontSize: 18,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );

  // Body
  static TextStyle get bodyLarge => GoogleFonts.outfit(
    fontSize: 16,
    color: AppColors.textPrimary,
    fontWeight: FontWeight.normal,
  );

  static TextStyle get body => GoogleFonts.outfit(
    fontSize: 14,
    color: AppColors.textSecondary,
    fontWeight: FontWeight.normal,
  );

  static TextStyle get bodySmall => GoogleFonts.outfit(
    fontSize: 12,
    color: AppColors.textTertiary,
    fontWeight: FontWeight.normal,
  );

  // Backward compatibility
  static TextStyle get bodySecondary => bodySmall;

  // UI Elements
  static TextStyle get button => GoogleFonts.outfit(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: Colors.white,
    letterSpacing: 0.5,
  );

  static TextStyle get caption => GoogleFonts.outfit(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textTertiary,
  );

  static TextStyle get label => GoogleFonts.outfit(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.primary,
  );
}
