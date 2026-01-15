import 'package:flutter/material.dart';
import 'package:algo_botix_assignment/core/theme/app_typography.dart';

class EmptyProductScreen extends StatelessWidget {
  final VoidCallback onRetry;

  const EmptyProductScreen({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("No products found.", style: AppTypography.body),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: onRetry, child: const Text("Fetch Again")),
        ],
      ),
    );
  }
}
