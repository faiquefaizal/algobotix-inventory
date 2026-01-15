import 'package:algo_botix_assignment/screens/history/widgets/history_tile.dart';
import 'package:flutter/material.dart';
import 'package:algo_botix_assignment/db/database_helper.dart';
import 'package:algo_botix_assignment/models/stock_history_model.dart';
import 'package:algo_botix_assignment/core/widgets/custom_app_bar.dart';
import 'package:algo_botix_assignment/core/theme/app_colors.dart';
import 'package:algo_botix_assignment/core/theme/app_typography.dart';

class HistoryScreen extends StatelessWidget {
  final String productId;
  final String productName;

  const HistoryScreen({
    super.key,
    required this.productId,
    required this.productName,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: 'History: $productName'),
      body: FutureBuilder<List<StockHistory>>(
        future: DatabaseHelper.instance.getHistoryForProduct(productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(
              child: Text(
                "Error: ${snapshot.error}",
                style: AppTypography.body,
              ),
            );
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text("No history available.", style: AppTypography.body),
            );
          }

          final history = snapshot.data!;
          return ListView.separated(
            itemCount: history.length,
            separatorBuilder: (ctx, i) => const Divider(),
            itemBuilder: (context, index) {
              final item = history[index];
              final isPositive = item.changeAmount > 0;
              return HistoryTile(isPositive: isPositive, item: item);
            },
          );
        },
      ),
    );
  }
}
