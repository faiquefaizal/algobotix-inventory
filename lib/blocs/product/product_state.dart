import 'package:equatable/equatable.dart';
import 'package:algo_botix_assignment/models/product_model.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final List<Product> filteredProducts;
  final bool isFromQrScan;

  const ProductLoaded({
    required this.products,
    required this.filteredProducts,
    this.isFromQrScan = false,
  });

  @override
  List<Object> get props => [products, filteredProducts, isFromQrScan];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object> get props => [message];
}
