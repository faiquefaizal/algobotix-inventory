import 'package:flutter/material.dart';
import 'package:algo_botix_assignment/core/theme/app_typography.dart';

class CustomElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const CustomElevatedButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,

      child: Text(text, style: AppTypography.button),
    );
  }
}
