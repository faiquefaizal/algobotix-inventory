import 'package:image_picker/image_picker.dart';

/// Picks an image from the specified [source].
///
/// Returns the file path of the picked image, or `null` if cancelled.
Future<String?> pickImage(ImageSource source) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: source);
  return pickedFile?.path;
}
