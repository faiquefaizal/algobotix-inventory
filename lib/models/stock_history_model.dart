class StockHistory {
  final int? id;
  final String productId;
  final DateTime timestamp;
  final int changeAmount;
  final int newStock;

  StockHistory({
    this.id,
    required this.productId,
    DateTime? timestamp,
    required this.changeAmount,
    required this.newStock,
  }) : timestamp = timestamp ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_id': productId,
      'timestamp': timestamp.toIso8601String(),
      'change_amount': changeAmount,
      'new_stock': newStock,
    };
  }

  factory StockHistory.fromMap(Map<String, dynamic> map) {
    return StockHistory(
      id: map['id'],
      productId: map['product_id'],
      timestamp: DateTime.parse(map['timestamp']),
      changeAmount: map['change_amount'],
      newStock: map['new_stock'],
    );
  }
}
