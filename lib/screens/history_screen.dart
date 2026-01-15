import 'package:flutter/material.dart';
import '../db/database_helper.dart';
import '../models/stock_history.dart';

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
      appBar: AppBar(title: Text("Stock History: $productName")),
      body: FutureBuilder<List<StockHistory>>(
        future: DatabaseHelper.instance.getHistoryForProduct(productId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text("No history available."));
          }

          final history = snapshot.data!;
          return ListView.separated(
            itemCount: history.length,
            separatorBuilder: (ctx, i) => const Divider(),
            itemBuilder: (context, index) {
              final item = history[index];
              final isPositive = item.changeAmount > 0;
              return ListTile(
                leading: Icon(
                  isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                  color: isPositive ? Colors.green : Colors.red,
                ),
                title: Text(
                  "${isPositive ? '+' : ''}${item.changeAmount} Stock",
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(item.timestamp),
                trailing: Text("New Stock: ${item.newStock}"),
              );
            },
          );
        },
      ),
    );
  }
}
