import 'package:algo_botix_assignment/blocs/image_picker/image_picker_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class ImageSourceSheet extends StatelessWidget {
  const ImageSourceSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children: [
        ListTile(
          leading: const Icon(Icons.photo_library),
          title: const Text('Gallery'),
          onTap: () {
            Navigator.pop(context);
            context.read<ImagePickerCubit>().pickImageFromSource(
              ImageSource.gallery,
            );
          },
        ),
        ListTile(
          leading: const Icon(Icons.camera_alt),
          title: const Text('Camera'),
          onTap: () {
            Navigator.pop(context);
            context.read<ImagePickerCubit>().pickImageFromSource(
              ImageSource.camera,
            );
          },
        ),
      ],
    );
  }
}
