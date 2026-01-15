import 'dart:io';

import 'package:algo_botix_assignment/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class ProductImage extends StatelessWidget {
  final String imagePath;
  const ProductImage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: AppColors.lightGrey,
        image: imagePath.isNotEmpty
            ? DecorationImage(
                image: FileImage(File(imagePath)),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: imagePath.isEmpty
          ? const Icon(Icons.inventory, color: AppColors.iconColor)
          : null,
    );
  }
}
