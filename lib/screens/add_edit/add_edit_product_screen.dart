import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:algo_botix_assignment/blocs/add_edit/add_edit_product_cubit.dart';
import 'package:algo_botix_assignment/blocs/image_picker/image_picker_cubit.dart';
import 'package:algo_botix_assignment/blocs/product/product_bloc.dart';
import 'package:algo_botix_assignment/blocs/product/product_event.dart';
import 'package:algo_botix_assignment/models/product_model.dart';
import 'package:algo_botix_assignment/core/widgets/custom_app_bar.dart';
import 'package:algo_botix_assignment/screens/add_edit/widgets/product_image_selector.dart';
import 'package:algo_botix_assignment/core/widgets/custom_text_form_field.dart';
import 'package:algo_botix_assignment/core/widgets/custom_elevated_button.dart';
import 'package:algo_botix_assignment/core/utils/validator.dart';
import 'package:algo_botix_assignment/core/widgets/custom_snack_bar.dart';
import 'package:algo_botix_assignment/core/theme/app_colors.dart';
import 'package:algo_botix_assignment/core/theme/app_typography.dart';

class AddEditProductScreen extends StatelessWidget {
  final Product? product;

  AddEditProductScreen({super.key, this.product});

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final addEditCubit = context.read<AddEditProductCubit>();

    return Scaffold(
      appBar: CustomAppBar(
        title: product == null ? 'Add Product' : 'Edit Product',
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (product != null)
                Card(
                  color: AppColors.primaryLight,
                  margin: const EdgeInsets.only(bottom: 16),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "ID: ${product!.id}",
                      style: AppTypography.infoValue.copyWith(
                        color: AppColors.primary,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              const ProductImageSelector(),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: addEditCubit.nameController,
                labelText: 'Product Name',
                validator: Validator.validateName,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: addEditCubit.descController,
                labelText: 'Description',
                maxLines: 3,
                validator: Validator.validateDescription,
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                controller: addEditCubit.stockController,
                labelText: 'Initial Stock',
                keyboardType: TextInputType.number,
                validator: Validator.validateStock,
              ),
              const SizedBox(height: 24),
              CustomElevatedButton(
                onPressed: () {
                  final imagePath = context.read<ImagePickerCubit>().state;
                  addEditCubit.submit(
                    formKey: _formKey,
                    imagePath: imagePath,
                    context: context,
                    originalProduct: product,
                  );
                },
                text: product == null ? 'Create Product' : 'Update Product',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
