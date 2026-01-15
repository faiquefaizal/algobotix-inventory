import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../../db/database_helper.dart';
import '../../models/product.dart';
import '../../models/stock_history.dart';
import 'product_event.dart';
import 'product_state.dart';

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

  Future<void> _onAddProduct(
    AddProduct event,
    Emitter<ProductState> emit,
  ) async {
    try {
      if (await _dbHelper.getProduct(event.product.id) != null) {
        emit(
          const ProductError("Product ID already exists. Please try again."),
        );
        // Reload to restore state ? Or just emit error then reload?
        // Better to keep previous state if possible, but simplicity:
        add(LoadProducts());
        return;
      }
      await _dbHelper.insertProduct(event.product);
      add(LoadProducts());
    } catch (e) {
      emit(ProductError("Failed to add product: $e"));
    }
  }

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

  Future<void> _onSearchProducts(
    SearchProducts event,
    Emitter<ProductState> emit,
  ) async {
    if (state is ProductLoaded) {
      final loadedState = state as ProductLoaded;
      final query = event.query.toLowerCase();

      final filtered = loadedState.products.where((product) {
        return product.id.toLowerCase().contains(query) ||
            product.name.toLowerCase().contains(query);
      }).toList();

      emit(
        ProductLoaded(
          products: loadedState.products,
          filteredProducts: filtered,
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

  Future<void> _updateStock(
    String productId,
    int change,
    Emitter<ProductState> emit,
  ) async {
    try {
      final product = await _dbHelper.getProduct(productId);
      if (product != null) {
        final newStock = product.stock + change;
        if (newStock < 0) return; // Prevent negative stock

        final updatedProduct = product.copyWith(stock: newStock);
        await _dbHelper.updateProduct(updatedProduct);

        // Log History
        final history = StockHistory(
          productId: productId,
          timestamp: DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),
          changeAmount: change,
          newStock: newStock,
        );
        await _dbHelper.logStockChange(history);

        // Ideally, we just update the list locally to avoid full reload flicker,
        // but for reliability with Search, reloading is safe.
        // Or better: Update list in place.
        if (state is ProductLoaded) {
          final currentState = state as ProductLoaded;
          final updatedList = currentState.products
              .map((p) => p.id == productId ? updatedProduct : p)
              .toList();

          // Re-apply filter if needed, or just LoadProducts(). LoadProducts is safer for consistency.
          add(LoadProducts());
        } else {
          add(LoadProducts());
        }
      }
    } catch (e) {
      emit(ProductError("Failed to update stock: $e"));
    }
  }
}
