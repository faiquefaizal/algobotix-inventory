class StockHistory {
  final int? id;
  final String productId;
  final String timestamp;
  final int changeAmount;
  final int newStock;

  StockHistory({
    this.id,
    required this.productId,
    required this.timestamp,
    required this.changeAmount,
    required this.newStock,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'product_id': productId,
      'timestamp': timestamp,
      'change_amount': changeAmount,
      'new_stock': newStock,
    };
  }

  factory StockHistory.fromMap(Map<String, dynamic> map) {
    return StockHistory(
      id: map['id'],
      productId: map['product_id'],
      timestamp: map['timestamp'],
      changeAmount: map['change_amount'],
      newStock: map['new_stock'],
    );
  }
}
