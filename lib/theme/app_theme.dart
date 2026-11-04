import 'package:flutter/material.dart';

class AppColors {
  const AppColors._();

  static const Color background = Color(0xFFF7F4EC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color cream = Color(0xFFF1ECE0);
  static const Color creamDark = Color(0xFFE8E2D3);
  static const Color lime = Color(0xFFB9DA4B);
  static const Color green = Color(0xFF5B8C32);
  static const Color dark = Color(0xFF17380F);
  static const Color textPrimary = Color(0xFF111111);
  static const Color textSecondary = Color(0xFF8C8C84);
  static const Color dotted = Color(0xFFB8B3A5);
}

class AppTheme {
  const AppTheme._();

  static ThemeData get light => ThemeData(
    useMaterial3: true,
    scaffoldBackgroundColor: AppColors.background,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.lime,
      primary: AppColors.dark,
      surface: AppColors.surface,
    ),
    splashFactory: InkSparkle.splashFactory,
  );
}
