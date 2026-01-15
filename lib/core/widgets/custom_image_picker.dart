import 'dart:io';
import 'package:algo_botix_assignment/core/utils/image_helper.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:algo_botix_assignment/core/theme/app_colors.dart';
import 'package:algo_botix_assignment/core/theme/app_typography.dart';

class CustomImagePicker extends StatelessWidget {
  final String? imagePath;
  final Function(String) onImagePicked;

  const CustomImagePicker({
    super.key,
    this.imagePath,
    required this.onImagePicked,
  });

  void showPickerOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (ctx) {
        return Wrap(
          children: [
            ListTile(
              leading: const Icon(
                Icons.photo_library,
                color: AppColors.iconColor,
              ),
              title: const Text('Gallery', style: AppTypography.body),
              onTap: () async {
                Navigator.pop(ctx);
                final path = await pickImage(ImageSource.gallery);
                if (path != null) {
                  onImagePicked(path);
                }
              },
            ),
            ListTile(
              leading: const Icon(Icons.camera_alt, color: AppColors.iconColor),
              title: const Text('Camera', style: AppTypography.body),
              onTap: () async {
                Navigator.pop(ctx);
                final path = await pickImage(ImageSource.camera);
                if (path != null) {
                  onImagePicked(path);
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showPickerOptions(context),
      child: Container(
        height: 150,
        decoration: BoxDecoration(
          color: AppColors.lightGrey,
          borderRadius: BorderRadius.circular(12),
          image: imagePath != null && imagePath!.isNotEmpty
              ? DecorationImage(
                  image: FileImage(File(imagePath!)),
                  fit: BoxFit.cover,
                )
              : null,
          border: Border.all(color: AppColors.borderGrey),
        ),
        child: imagePath == null || imagePath!.isEmpty
            ? const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.add_a_photo, size: 40, color: AppColors.iconColor),
                  SizedBox(height: 8),
                  Text("Tap to add image", style: AppTypography.label),
                ],
              )
            : null,
      ),
    );
  }
}
