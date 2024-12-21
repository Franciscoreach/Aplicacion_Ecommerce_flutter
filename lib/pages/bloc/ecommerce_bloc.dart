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
  }

  void _onLoadProductsEvent(LoadProductsEvent event, Emitter<EcommerceState> emit) async{
    emit(state.copyWith(homeScreenSate: HomeScreenSate.loading));

    await Future.delayed(const Duration(seconds: 1));

    final products = productsJson.map((json){
      return ProductModel(
        id: json["id"].toString(), 
        name: json["description"], 
        price: double.parse(json["price"].toString()), 
        imageUrl: json["image_url"]
      );
    }).toList();


    emit(state.copyWith(
      homeScreenSate: HomeScreenSate.success,
      products: products,
    ));

  }

  void _onAddToCartEvent(AddToCartEvent event, Emitter<EcommerceState> emit){

    final exist = state.cart.firstWhere(
      (p) => p.id == event.product.id,
      orElse: () => event.product.copyWith(quantity: 0),
    );

    //Volvemos a agregar el mismo producto, la cantidad se incrementa en 1
    final updateCart = state.cart.map((p){
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

  void _onUpdateCartQuantityEvent(UpdateCartQuantityEvent event, Emitter<EcommerceState> emit){

  }

  void _onRemoveCartItemEvent(RemoveCartItemEvent event, Emitter<EcommerceState> emit){

  }


}
