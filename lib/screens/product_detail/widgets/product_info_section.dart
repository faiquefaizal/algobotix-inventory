import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:algo_botix_assignment/models/product_model.dart';
import 'package:algo_botix_assignment/core/theme/app_typography.dart';
import 'package:algo_botix_assignment/core/theme/app_colors.dart';
import 'package:algo_botix_assignment/screens/history/history_screen.dart';

class ProductInfoSection extends StatelessWidget {
  final Product product;

  const ProductInfoSection({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "ID: ${product.id ?? 'N/A'}",
                style: AppTypography.infoValue,
              ),
              Text(
                "Stock: ${NumberFormat.decimalPattern().format(product.stock)}",
                style: AppTypography.infoValue.copyWith(color: AppColors.black),
              ),
            ],
          ),
          const Divider(height: 30),
          Text(product.name, style: AppTypography.headline),
          const SizedBox(height: 8),
          Text("Added by: ${product.addedBy}", style: AppTypography.label),
          const SizedBox(height: 4),
          Text(
            "Date: ${DateFormat.yMMMd().add_jm().format(product.dateAdded)}",
            style: AppTypography.label,
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => HistoryScreen(
                    productId: product.id!,
                    productName: product.name,
                  ),
                ),
              );
            },
            icon: const Icon(Icons.history),
            label: const Text("View Stock History"),
          ),
          const SizedBox(height: 16),
          const Text("Description", style: AppTypography.subtitle),
          const SizedBox(height: 8),
          Text(product.description, style: AppTypography.body),
        ],
      ),
    );
  }
}
