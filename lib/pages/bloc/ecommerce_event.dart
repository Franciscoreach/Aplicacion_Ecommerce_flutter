part of 'ecommerce_bloc.dart';

sealed class EcommerceEvent extends Equatable {
  const EcommerceEvent();

  @override
  List<Object> get props => [];
}

class LoadProductsEvent extends EcommerceEvent{}

class AddToCartEvent extends EcommerceEvent{
  final ProductModel product;

  const AddToCartEvent({required this.product});

}

class UpdateCartQuantityEvent extends EcommerceEvent{
  
  final String productId;
  final int quantityChange;

  const UpdateCartQuantityEvent({required this.productId, required this.quantityChange});

}

class RemoveCartItemEvent extends EcommerceEvent{
  final String productId;

  const RemoveCartItemEvent(this.productId);
}