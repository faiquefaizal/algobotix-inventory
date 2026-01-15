import 'package:algo_botix_assignment/core/theme/app_colors.dart';
import 'package:algo_botix_assignment/core/theme/app_typography.dart';
import 'package:algo_botix_assignment/models/stock_history_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class HistoryTile extends StatelessWidget {
  const HistoryTile({super.key, required this.isPositive, required this.item});

  final bool isPositive;
  final StockHistory item;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(
        isPositive ? Icons.arrow_upward : Icons.arrow_downward,

        color: isPositive ? AppColors.primary : AppColors.error,
      ),
      title: Text(
        "${isPositive ? '+' : ''}${NumberFormat.decimalPattern().format(item.changeAmount)} Stock",
        style: AppTypography.body.copyWith(fontWeight: FontWeight.bold),
      ),
      subtitle: Text(
        DateFormat.yMMMd().add_jm().format(item.timestamp),
        style: AppTypography.label,
      ),
      trailing: Text(
        "New Stock: ${NumberFormat.decimalPattern().format(item.newStock)}",
        style: AppTypography.body,
      ),
    );
  }
}
