import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:algo_botix_assignment/core/utils/image_helper.dart';

/// Manages the state of the product image selection.
///
/// Stores the filesystem path of the selected image.
class ImagePickerCubit extends Cubit<String?> {
  ImagePickerCubit() : super(null);

  /// Manually sets the image path (e.g., when editing an existing product).
  void setImage(String? path) {
    emit(path);
  }

  /// Picks an image from the specified [source] (Camera or Gallery).
  ///
  /// Emits the new image path if selection is successful.
  Future<void> pickImageFromSource(ImageSource source) async {
    final path = await pickImage(source);
    if (path != null) {
      emit(path);
    }
  }

  /// Clears the currently selected image.
  void clearImage() {
    emit(null);
  }
}
