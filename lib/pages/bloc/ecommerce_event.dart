part of 'ecommerce_bloc.dart';

class EcommerceEvent extends Equatable {
  const EcommerceEvent();

  @override
  List<Object> get props => [];
}

class LoadProductsEvent extends EcommerceEvent {}

class AddToCartEvent extends EcommerceEvent {
  final ProductModel product;

  const AddToCartEvent({required this.product});

  @override
  List<Object> get props => [product];
}

class UpdateCartQuantityEvent extends EcommerceEvent {
  final String productId;
  final int quantityChange;

  const UpdateCartQuantityEvent({required this.productId, required this.quantityChange});

  @override
  List<Object> get props => [productId, quantityChange];
}

class RemoveCartItemEvent extends EcommerceEvent {
  final String productId;

  const RemoveCartItemEvent(this.productId);

  @override
  List<Object> get props => [productId];
}

class FilterByCategoryEvent extends EcommerceEvent {
  final String category;

  const FilterByCategoryEvent({required this.category});

  @override
  List<Object> get props => [category];
}