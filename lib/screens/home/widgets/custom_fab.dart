import 'package:flutter/material.dart';
import 'package:algo_botix_assignment/core/theme/app_colors.dart';

class CustomFloatingActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final String? heroTag;
  final Color? backgroundColor;

  const CustomFloatingActionButton({
    super.key,
    required this.onPressed,
    required this.icon,
    this.heroTag,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      heroTag: heroTag,
      onPressed: onPressed,
      backgroundColor: backgroundColor,
      foregroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: icon,
    );
  }
}
