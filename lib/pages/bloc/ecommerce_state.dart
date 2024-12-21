part of 'ecommerce_bloc.dart';

enum HomeScreenSate {
  none,
  loading,
  success,
  failure,
}

class EcommerceState extends Equatable {

  final List<ProductModel> products;
  final List<ProductModel> cart;
  final HomeScreenSate homeScreenSate;

  const EcommerceState({
    required this.products,
    required this.cart,
    required this.homeScreenSate,
  });

  factory EcommerceState.initial(){
    return const EcommerceState(
      products: [], 
      cart: [],
      homeScreenSate: HomeScreenSate.none,
    );
  }

  EcommerceState copyWith({
    List<ProductModel>? products,
    List<ProductModel>? cart,
    HomeScreenSate ? homeScreenSate,
  }) {
    return EcommerceState(
      products: products ?? this.products,
      cart: cart ?? this.cart,
      homeScreenSate: homeScreenSate ?? this.homeScreenSate
    );
  }
  
  @override
  List<Object> get props => [products, cart, homeScreenSate];
}


