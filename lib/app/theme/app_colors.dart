import 'package:flutter/material.dart';

abstract final class AppColors {
  AppColors._();

  // Brand
  static const Color primary = Color(0xFF6C3BFF);
  static const Color primaryDark = Color(0xFF4D20D9);
  static const Color primaryLight = Color(0xFFEDE7FF);

  // Surfaces
  static const Color background = Color(0xFFF8F8FC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceSecondary = Color(0xFFF1F1F7);

  // Text
  static const Color textPrimary = Color(0xFF17151F);
  static const Color textSecondary = Color(0xFF76727F);
  static const Color textMuted = Color(0xFFA6A2AE);

  // Borders
  static const Color border = Color(0xFFE7E5EC);

  // Semantic
  static const Color success = Color(0xFF22C55E);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);

  // Base
  static const Color white = Colors.white;
  static const Color black = Colors.black;
}
