import 'package:flutter/material.dart';

class AppColors {
  // Brand - Premium & Tech-focused
  static const Color primary = Color(0xFF2962FF); // Vivid Royal Blue
  static const Color primaryDark = Color(0xFF0039CB);
  static const Color accent = Color(0xFF00B0FF); // Cyan Accent for highlights

  // Backgrounds - Clean & Minimal
  static const Color background = Color(0xFFF9FAFB); // Cool Grey 50
  static const Color surface = Colors.white;
  static const Color surfaceVariant = Color(0xFFF3F4F6); // Cool Grey 100

  // Text - High Contrast & Readable
  static const Color textPrimary = Color(0xFF111827); // Cool Grey 900
  static const Color textSecondary = Color(0xFF4B5563); // Cool Grey 600
  static const Color textTertiary = Color(0xFF9CA3AF); // Cool Grey 400

  // Status - Soft & Modern
  static const Color success = Color(0xFF10B981); // Emerald
  static const Color warning = Color(0xFFF59E0B); // Amber
  static const Color error = Color(0xFFEF4444); // Red
  static const Color info = Color(0xFF3B82F6); // Blue

  // Borders & Outlines
  static const Color border = Color(0xFFE5E7EB); // Cool Grey 200
  static const Color divider = Color(0xFFF3F4F6);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF2962FF), Color(0xFF448AFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
