import 'dart:math';

import 'package:algo_botix_assignment/models/product_model.dart';

/// Generates a random alphanumeric ID string.
///
/// Uses upper-case letters (A-Z) and digits (0-9) with a length of 5.
String generateRandomId() {
  const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
  final rnd = Random();

  final idChars = List.generate(5, (_) => chars[rnd.nextInt(chars.length)]);
  return idChars.join();
}

/// Returns a new list of products with updated stock for a specific ID.
List<Product> getUpdatedList(List<Product> products, String id, int change) {
  return products.map((p) {
    if (p.id == id) {
      final newStock = p.stock + change;
      // If the change results in negative stock, return the original product
      return newStock >= 0 ? p.copyWith(stock: newStock) : p;
    }
    return p;
  }).toList();
}
