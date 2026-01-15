import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Defines the text styles used throughout the application.
///
/// Uses [AppColors] for consistent coloring.
class AppTypography {
  /// Large headline style (Font size 24, Bold).
  static const TextStyle headline = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  /// Title style used in AppBars (Font size 20, Bold, White).
  static const TextStyle title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );

  static const TextStyle subtitle = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.black,
  );

  /// Standard body text style (Font size 16, Regular).
  static const TextStyle body = TextStyle(
    fontSize: 16,
    color: AppColors.black,
    height: 1.5,
  );

  static const TextStyle label = TextStyle(fontSize: 14, color: AppColors.grey);

  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle infoValue = TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 16,
    color: AppColors.primary,
  );
}
