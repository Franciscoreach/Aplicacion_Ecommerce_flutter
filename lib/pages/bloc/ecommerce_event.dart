part of 'ecommerce_bloc.dart';

sealed class EcommerceEvent extends Equatable {
  const EcommerceEvent();

  @override
  List<Object> get props => [];
}

class LoadProductsEvent extends EcommerceEvent {}

class LoadCatalogProductsEvent extends EcommerceEvent {}

class LoadCartItemsEvent extends EcommerceEvent {}

class AddToCartEvent extends EcommerceEvent {
  final ProductModel product;

  const AddToCartEvent({required this.product});
}

class UpdateCartQuantityEvent extends EcommerceEvent {
  final ProductModel product;
  final int newQty;
  const UpdateCartQuantityEvent({
    required this.product,
    required this.newQty,
  });
}

class RemoveCartItemEvent extends EcommerceEvent {
  final ProductModel product;
  const RemoveCartItemEvent({required this.product});
}


class RemoveCatalogItemEvent extends EcommerceEvent {
  final ProductModel product;
  const RemoveCatalogItemEvent({required this.product});
}


class CreateNewProductsEvent extends EcommerceEvent {
  final String description;
  final String imageUrl;
  final int price;

  const CreateNewProductsEvent({
    required this.description,
    required this.imageUrl,
    required this.price,
  });

}

class UpdateProductEvent extends EcommerceEvent {
  final String productId; 
  final String description;
  final String imageUrl;
  final int price;

  const UpdateProductEvent({
    required this.productId,
    required this.description,
    required this.imageUrl,
    required this.price,
  });

}


