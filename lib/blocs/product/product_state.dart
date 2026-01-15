import 'package:equatable/equatable.dart';
import '../../models/product.dart';

abstract class ProductState extends Equatable {
  const ProductState();

  @override
  List<Object> get props => [];
}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
  final List<Product> products;
  final List<Product> filteredProducts;

  const ProductLoaded({required this.products, required this.filteredProducts});

  @override
  List<Object> get props => [products, filteredProducts];
}

class ProductError extends ProductState {
  final String message;

  const ProductError(this.message);

  @override
  List<Object> get props => [message];
}
