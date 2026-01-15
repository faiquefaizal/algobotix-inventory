import 'dart:io';
import 'package:algo_botix_assignment/core/widgets/image_container.dart';
import 'package:algo_botix_assignment/screens/add_edit/widgets/image_source_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:algo_botix_assignment/blocs/image_picker/image_picker_cubit.dart';

class ProductImageSelector extends StatelessWidget {
  const ProductImageSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ImagePickerCubit, String?>(
      builder: (context, imagePath) {
        return GestureDetector(
          onTap: () {
            showModalBottomSheet(
              context: context,
              builder: (_) {
                return BlocProvider.value(
                  value: context.read<ImagePickerCubit>(),
                  child: ImageSourceSheet(),
                );
              },
            );
          },
          child: ImageContainer(imagePath: imagePath),
        );
      },
    );
  }
}
