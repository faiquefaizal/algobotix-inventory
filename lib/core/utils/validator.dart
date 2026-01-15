/// Provides static validation methods for form fields.
class Validator {
  /// Validates the Product Name field.
  ///
  /// * Required.
  /// * Must be at least 3 characters long.
  static String? validateName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Product Name is required';
    }
    if (value.length < 3) {
      // Minimum length check
      return 'Product Name must be at least 3 characters long';
    }
    return null;
  }

  /// Validates the Product Description field.
  ///
  /// * Required.
  /// * Must be at least 5 characters long.
  static String? validateDescription(String? value) {
    if (value == null || value.isEmpty) {
      return 'Description is required';
    }
    if (value.length < 5) {
      return 'Description must be at least 5 characters long';
    }
    return null;
  }

  /// Validates the Stock Quantity field.
  ///
  /// * Required.
  /// * Must be a valid integer.
  /// * Must be greater than 0.
  static String? validateStock(String? value) {
    if (value == null || value.isEmpty) {
      return 'Stock is required';
    }
    final int? stockValue = int.tryParse(value);
    if (stockValue == null) {
      return 'Please enter a valid number';
    }
    if (stockValue <= 0) {
      return 'Stock must be greater than 0';
    }
    return null;
  }
}
