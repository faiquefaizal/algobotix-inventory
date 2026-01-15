import 'dart:io';

import 'package:flutter/material.dart';
import 'package:algo_botix_assignment/core/theme/app_colors.dart';
import 'package:algo_botix_assignment/core/theme/app_typography.dart';

class ImageContainer extends StatelessWidget {
  final String? imagePath;
  const ImageContainer({super.key, this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(12),
        image: imagePath != null
            ? DecorationImage(
                image: FileImage(File(imagePath!)),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: imagePath == null
          ? const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_a_photo, size: 40, color: AppColors.iconColor),
                Text("Tap to add image", style: AppTypography.label),
              ],
            )
          : null,
    );
  }
}
