import 'package:flutter/material.dart';
import 'package:algo_botix_assignment/core/theme/app_colors.dart';
import 'package:algo_botix_assignment/core/theme/app_typography.dart';

Future<void> showConfirmDialog({
  required BuildContext context,
  required String title,
  required String content,
  String cancelText = "Cancel",
  required String confirmText,
  required VoidCallback onConfirm,
  Color? confirmColor,
}) {
  return showDialog(
    context: context,
    builder: (context) => AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      title: Text(title, style: AppTypography.headline),
      content: Text(content, style: AppTypography.body),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(
            cancelText,
            style: AppTypography.button.copyWith(color: AppColors.grey),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: confirmColor ?? AppColors.primary,
            foregroundColor: AppColors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          onPressed: () {
            onConfirm();
            Navigator.pop(context);
          },
          child: Text(confirmText, style: AppTypography.button),
        ),
      ],
    ),
  );
}
