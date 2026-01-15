import 'package:algo_botix_assignment/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class StockButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;

  const StockButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Padding(
        padding: const EdgeInsets.all(4),
        child: Icon(icon, size: 18, color: AppColors.primary),
      ),
    );
  }
}
