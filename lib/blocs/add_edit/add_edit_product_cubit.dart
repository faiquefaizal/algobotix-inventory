import 'package:algo_botix_assignment/blocs/product/product_bloc.dart';
import 'package:algo_botix_assignment/blocs/product/product_event.dart';
import 'package:algo_botix_assignment/core/widgets/custom_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:algo_botix_assignment/models/product_model.dart';

/// Manages the state and logic for adding or editing a product.
///
/// Handles form validation, data collection, and integration with [ProductBloc].
class AddEditProductCubit extends Cubit<void> {
  String? id;

  final TextEditingController nameController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController stockController = TextEditingController();

  AddEditProductCubit() : super(null);

  // Prefill controllers from an existing product
  /// Pre-fills the form controllers with data from an existing [product].
  ///
  /// Used when entering "Edit Mode".
  void prefill(Product product) {
    id = product.id;
    nameController.text = product.name;
    descController.text = product.description;
    stockController.text = product.stock.toString();
  }

  // Generate a Product model from current controller values
  /// Creates a [Product] model instance from the current form values.
  Product currentData({String? imagePath}) {
    return Product(
      id: id,
      name: nameController.text,
      description: descController.text,
      stock: int.tryParse(stockController.text) ?? 0,
      imagePath: imagePath ?? '',
    );
  }

  /// Validates the form and submits the product data to the [ProductBloc].
  ///
  /// 1. Validates form fields (Name, Description, Stock).
  /// 2. Ensures an image is selected.
  /// 3. Dispatches [AddProduct] or [UpdateProduct] event.
  /// 4. Navigates back upon success.
  void submit({
    required GlobalKey<FormState> formKey,
    required BuildContext context,
    String? imagePath,
    Product? originalProduct,
  }) {
    // 1. Validate Form
    if (!formKey.currentState!.validate()) return;

    // 2. Validate Image
    if (imagePath == null || imagePath.isEmpty) {
      CustomSnackBar.showError(context, message: 'Please select an image');
      return;
    }

    // 3. Create Product Model
    final productData = Product(
      id: id,
      name: nameController.text.trim(),
      description: descController.text.trim(),
      stock: int.parse(stockController.text),
      imagePath: imagePath,
      dateAdded: originalProduct?.dateAdded,
    );

    // 4. Dispatch to ProductBloc
    if (originalProduct == null) {
      context.read<ProductBloc>().add(AddProduct(productData));
    } else {
      context.read<ProductBloc>().add(UpdateProduct(productData));
    }

    // 5. Navigate back
    Navigator.pop(context);
  }

  @override
  Future<void> close() {
    nameController.dispose();
    descController.dispose();
    stockController.dispose();
    return super.close();
  }
}
