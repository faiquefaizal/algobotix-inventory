import 'dart:io';
import 'package:algo_botix_assignment/screens/home/widgets/product_image.dart';
import 'package:algo_botix_assignment/screens/home/widgets/stock_button.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:algo_botix_assignment/blocs/product/product_bloc.dart';
import 'package:algo_botix_assignment/blocs/product/product_event.dart';
import 'package:algo_botix_assignment/models/product_model.dart';
import 'package:algo_botix_assignment/screens/product_detail/product_details_screen.dart';
import 'package:algo_botix_assignment/core/theme/app_colors.dart';
import 'package:algo_botix_assignment/core/theme/app_typography.dart';

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          // Navigate to Details
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductDetailsScreen(product: product),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Row(
            children: [
              // Image
              Hero(
                tag: 'product_${product.id}',
                child: ProductImage(imagePath: product.imagePath),
              ),
              const SizedBox(width: 16),
              // Content
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: AppTypography.subtitle,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      product.description,
                      style: AppTypography.label,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Text('Stock: ', style: AppTypography.body),

                        Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.borderGrey),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Row(
                            children: [
                              StockButton(
                                icon: Icons.remove,
                                onTap: () {
                                  if (product.id != null) {
                                    context.read<ProductBloc>().add(
                                      DecrementStock(product.id!),
                                    );
                                  }
                                },
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8,
                                ),
                                child: Text(
                                  NumberFormat.decimalPattern().format(
                                    product.stock,
                                  ),
                                  style: AppTypography.body.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              StockButton(
                                icon: Icons.add,
                                onTap: () {
                                  if (product.id != null) {
                                    context.read<ProductBloc>().add(
                                      IncrementStock(product.id!),
                                    );
                                  }
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
