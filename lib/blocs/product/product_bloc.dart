import 'package:algo_botix_assignment/core/utils/helper_funtions.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:algo_botix_assignment/db/database_helper.dart';
import 'package:algo_botix_assignment/models/stock_history_model.dart';
import 'product_event.dart';
import 'product_state.dart';

/// Manages the state of the product inventory.
///
/// Handles CRUD operations, searching, and stock adjustments.
class ProductBloc extends Bloc<ProductEvent, ProductState> {
  final DatabaseHelper _dbHelper = DatabaseHelper.instance;

  ProductBloc() : super(ProductLoading()) {
    on<LoadProducts>(_onLoadProducts);
    on<AddProduct>(_onAddProduct);
    on<UpdateProduct>(_onUpdateProduct);
    on<DeleteProduct>(_onDeleteProduct);
    on<SearchProducts>(_onSearchProducts);
    on<IncrementStock>(_onIncrementStock);
    on<DecrementStock>(_onDecrementStock);
  }

  /// Loads all products from the database.
  ///
  /// Emits [ProductLoading] initially, then [ProductLoaded] with the data.
  Future<void> _onLoadProducts(
    LoadProducts event,
    Emitter<ProductState> emit,
  ) async {
    emit(ProductLoading());
    try {
      final products = await _dbHelper.getAllProducts();
      emit(ProductLoaded(products: products, filteredProducts: products));
    } catch (e) {
      emit(ProductError("Failed to load products: $e"));
    }
  }

  /// Adds a new product to the database and reloads the list.
  Future<void> _onAddProduct(
    AddProduct event,
    Emitter<ProductState> emit,
  ) async {
    try {
      await _dbHelper.insertProduct(event.product);
      add(LoadProducts());
    } catch (e) {
      emit(ProductError("Failed to add product: $e"));
    }
  }

  /// Updates an existing product and reloads the list.
  Future<void> _onUpdateProduct(
    UpdateProduct event,
    Emitter<ProductState> emit,
  ) async {
    try {
      await _dbHelper.updateProduct(event.product);
      add(LoadProducts());
    } catch (e) {
      emit(ProductError("Failed to update product: $e"));
    }
  }

  /// Deletes a product by ID and reloads the list.
  Future<void> _onDeleteProduct(
    DeleteProduct event,
    Emitter<ProductState> emit,
  ) async {
    try {
      await _dbHelper.deleteProduct(event.id);
      add(LoadProducts());
    } catch (e) {
      emit(ProductError("Failed to delete product: $e"));
    }
  }

  /// Filters the loaded product list based on a search query.
  ///
  /// Supports searching by Product Name or ID.
  Future<void> _onSearchProducts(
    SearchProducts event,
    Emitter<ProductState> emit,
  ) async {
    if (state is ProductLoaded) {
      final loadedState = state as ProductLoaded;
      final query = event.query.toLowerCase();

      final filtered = loadedState.products
          .where(
            (product) =>
                (product.id?.toLowerCase().contains(query) ?? false) ||
                product.name.toLowerCase().contains(query),
          )
          .toList();

      emit(
        ProductLoaded(
          products: loadedState.products,
          filteredProducts: filtered,
          isFromQrScan: event.isFromQrScan,
        ),
      );
    }
  }

  Future<void> _onIncrementStock(
    IncrementStock event,
    Emitter<ProductState> emit,
  ) async {
    await _updateStock(event.productId, 1, emit);
  }

  Future<void> _onDecrementStock(
    DecrementStock event,
    Emitter<ProductState> emit,
  ) async {
    await _updateStock(event.productId, -1, emit);
  }

  /// internal helper to update stock (Optimistic UI Update).
  ///
  /// 1. Updates local state immediately for responsiveness.
  /// 2. Syncs change to database in background.
  /// 3. Rolls back changes if DB sync fails.
  Future<void> _updateStock(
    String productId,
    int change,
    Emitter<ProductState> emit,
  ) async {
    // Only proceed if products are already loaded
    if (state is ProductLoaded) {
      final currentState = state as ProductLoaded;

      // 1. FIND AND UPDATE LOCALLY (Optimistic Update)
      final updatedProducts = getUpdatedList(
        currentState.products,
        productId,
        change,
      );

      // Check if any change actually happened (e.g., prevented negative stock)
      final updatedProduct = updatedProducts.firstWhere(
        (p) => p.id == productId,
      );
      final originalProduct = currentState.products.firstWhere(
        (p) => p.id == productId,
      );

      if (updatedProduct.stock == originalProduct.stock) return;

      // 2. EMIT IMMEDIATELY (UI changes instantly)
      emit(
        ProductLoaded(
          products: updatedProducts,
          filteredProducts: updatedProducts,
        ),
      );

      try {
        // 3. BACKGROUND DATABASE SYNC
        // We already calculated values, just push to DB
        await _dbHelper.updateProduct(updatedProduct);

        final history = StockHistory(
          productId: productId,
          changeAmount: change,
          newStock: updatedProduct.stock,
        );
        await _dbHelper.logStockChange(history);
      } catch (e) {
        // 4. ROLLBACK ON ERROR
        // If DB fails, reload everything to ensure UI matches DB reality
        add(LoadProducts());
        emit(ProductError("Sync failed: $e"));
      }
    }
  }
}
