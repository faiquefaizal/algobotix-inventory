import 'package:flutter/material.dart';
import 'package:algo_botix_assignment/core/theme/app_colors.dart';

class CustomSnackBar {
  static void show(
    BuildContext context, {
    required String message,
    Color? backgroundColor,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: backgroundColor ?? AppColors.black,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  static void showError(BuildContext context, {required String message}) {
    show(context, message: message, backgroundColor: AppColors.error);
  }

  static void showSuccess(BuildContext context, {required String message}) {
    show(context, message: message, backgroundColor: AppColors.primary);
  }
}
