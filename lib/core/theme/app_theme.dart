import 'package:flutter/material.dart';
import 'app_typography.dart';
import 'app_colors.dart';

/// Configures the global [ThemeData] for the application.
///
/// Integrates [AppColors] and [AppTypography] to provide a usage-ready theme.
class AppTheme {
  /// The default light theme configuration.
  ///
  /// * Uses Material 3.
  /// * Sets 'Roboto' as the default font family.
  /// * Configures global styles for AppBar, Cards, Buttons, etc.
  static final ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
    useMaterial3: true,
    fontFamily: 'Roboto',
    textTheme: const TextTheme(
      headlineLarge: AppTypography.headline,
      titleLarge: AppTypography.title,
      titleMedium: AppTypography.subtitle,
      bodyLarge: AppTypography.body,
      labelLarge: AppTypography.button,
      bodySmall: AppTypography.label,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      elevation: 4,
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      titleTextStyle: AppTypography.title,
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
    ),
    cardTheme: CardThemeData(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: AppTypography.button,
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    dialogTheme: DialogThemeData(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      titleTextStyle: AppTypography.headline,
      contentTextStyle: AppTypography.body,
    ),
  );
}
