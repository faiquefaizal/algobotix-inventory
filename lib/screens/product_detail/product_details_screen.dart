import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:algo_botix_assignment/blocs/product/product_bloc.dart';
import 'package:algo_botix_assignment/blocs/product/product_event.dart';
import 'package:algo_botix_assignment/blocs/add_edit/add_edit_product_cubit.dart';
import 'package:algo_botix_assignment/blocs/image_picker/image_picker_cubit.dart';
import 'package:algo_botix_assignment/models/product_model.dart';
import '../add_edit/add_edit_product_screen.dart';
import 'package:algo_botix_assignment/core/widgets/custom_app_bar.dart';
import 'widgets/product_image_section.dart';
import 'widgets/product_info_section.dart';
import 'package:algo_botix_assignment/core/widgets/custom_confirm_dialog.dart';

class ProductDetailsScreen extends StatelessWidget {
  final Product product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: product.name,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return MultiBlocProvider(
                      providers: [
                        BlocProvider(
                          create: (_) =>
                              ImagePickerCubit()..setImage(product.imagePath),
                        ),
                        BlocProvider(
                          create: (_) {
                            final cubit = AddEditProductCubit();
                            cubit.prefill(product);
                            return cubit;
                          },
                        ),
                      ],
                      child: AddEditProductScreen(product: product),
                    );
                  },
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              showConfirmDialog(
                context: context,
                title: "Delete Product",
                content: "Are you sure you want to delete this product?",
                confirmText: "Delete",
                onConfirm: () {
                  if (product.id != null) {
                    context.read<ProductBloc>().add(DeleteProduct(product.id!));
                  }
                  Navigator.pop(context);
                },
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ProductImageSection(imagePath: product.imagePath),
            ProductInfoSection(product: product),
          ],
        ),
      ),
    );
  }
}
