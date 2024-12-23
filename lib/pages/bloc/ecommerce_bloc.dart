import 'package:ecomerce_app/data.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecomerce_app/model/product_model.dart';
import 'package:equatable/equatable.dart';

part 'ecommerce_event.dart';
part 'ecommerce_state.dart';

class EcommerceBloc extends Bloc<EcommerceEvent, EcommerceState> {
  EcommerceBloc() : super(EcommerceState.initial()) {
    on<LoadProductsEvent>(_onLoadProductsEvent);
    on<AddToCartEvent>(_onAddToCartEvent);
    on<UpdateCartQuantityEvent>(_onUpdateCartQuantityEvent);
    on<RemoveCartItemEvent>(_onRemoveCartItemEvent);
    on<FilterByCategoryEvent>(_onFilterByCategoryEvent);
  }

  void _onLoadProductsEvent(LoadProductsEvent event, Emitter<EcommerceState> emit) async {
    emit(state.copyWith(homeScreenSate: HomeScreenSate.loading));

    await Future.delayed(const Duration(seconds: 1));

    final products = productsJson.map((json) {
      return ProductModel(
        id: json["id"].toString(),
        name: json["description"],
        price: double.parse(json["price"].toString()),
        imageUrl: json["image_url"],
        category: json["product"],
      );
    }).toList();

    emit(state.copyWith(
      homeScreenSate: HomeScreenSate.success,
      products: products,
      allProducts: products, // Guardamos todos los productos en allProducts
    ));
  }

  void _onAddToCartEvent(AddToCartEvent event, Emitter<EcommerceState> emit) {
    final exist = state.cart.firstWhere(
      (p) => p.id == event.product.id,
      orElse: () => event.product.copyWith(quantity: 0),
    );

    // Volvemos a agregar el mismo producto, la cantidad se incrementa en 1
    final updateCart = state.cart.map((p) {
      if (p.id == event.product.id) {
        return p.copyWith(quantity: p.quantity + 1);
      }
      return p;
    }).toList();

    if (exist.quantity == 0) {
      updateCart.add(event.product.copyWith(quantity: 1));
    }

    emit(state.copyWith(cart: updateCart));
  }

  void _onUpdateCartQuantityEvent(UpdateCartQuantityEvent event, Emitter<EcommerceState> emit) {
    final updatedCart = state.cart.map((product) {
      if (product.id == event.productId) {
        final newQuantity = product.quantity + event.quantityChange;
        if (newQuantity >= 1) {
          return product.copyWith(quantity: newQuantity);
        }
      }
      return product;
    }).toList();

    emit(state.copyWith(cart: updatedCart));
  }

  void _onRemoveCartItemEvent(RemoveCartItemEvent event, Emitter<EcommerceState> emit) {
    // Filtramos el carrito para eliminar el producto con el ID proporcionado
    final updatedCart = state.cart.where((product) => product.id != event.productId).toList();

    emit(state.copyWith(cart: updatedCart));
  }

  void _onFilterByCategoryEvent(FilterByCategoryEvent event, Emitter<EcommerceState> emit) {
    final filteredProducts = state.allProducts
        .where((product) => product.category == event.category)
        .toList();

    emit(state.copyWith(products: filteredProducts));
  }
}