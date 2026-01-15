import 'dart:io';
import 'package:flutter/material.dart';
import 'package:algo_botix_assignment/core/theme/app_colors.dart';

class ProductImageSection extends StatelessWidget {
  final String imagePath;

  const ProductImageSection({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    if (imagePath.isNotEmpty) {
      return Container(
        width: double.infinity,
        height: 250,
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          image: DecorationImage(
            image: FileImage(File(imagePath)),
            fit: BoxFit.cover,
          ),
        ),
      );
    } else {
      return Container(
        width: double.infinity,
        height: 200,
        color: AppColors.lightGrey,
        child: const Icon(
          Icons.inventory,
          size: 80,
          color: AppColors.iconColor,
        ),
      );
    }
  }
}
