import 'package:equatable/equatable.dart';
import 'package:algo_botix_assignment/models/product_model.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class LoadProducts extends ProductEvent {}

class AddProduct extends ProductEvent {
  final Product product;

  const AddProduct(this.product);

  @override
  List<Object> get props => [product];
}

class UpdateProduct extends ProductEvent {
  final Product product;

  const UpdateProduct(this.product);

  @override
  List<Object> get props => [product];
}

class DeleteProduct extends ProductEvent {
  final String id;

  const DeleteProduct(this.id);

  @override
  List<Object> get props => [id];
}

class SearchProducts extends ProductEvent {
  final String query;
  final bool isFromQrScan;

  const SearchProducts({required this.query, this.isFromQrScan = false});

  @override
  List<Object> get props => [query];
}

class IncrementStock extends ProductEvent {
  final String productId;

  const IncrementStock(this.productId);

  @override
  List<Object> get props => [productId];
}

class DecrementStock extends ProductEvent {
  final String productId;

  const DecrementStock(this.productId);

  @override
  List<Object> get props => [productId];
}
