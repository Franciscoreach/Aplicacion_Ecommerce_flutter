part of 'ecommerce_bloc.dart';

enum HomeScreenSate {
  none,
  loading,
  success,
  failure,
}

class EcommerceState extends Equatable {

  final List<ProductModel> allProducts;
  final List<ProductModel> products;
  final List<ProductModel> cart;
  final HomeScreenSate homeScreenSate;

  const EcommerceState({
    required this.allProducts,
    required this.products,
    required this.cart,
    required this.homeScreenSate,
  });

  factory EcommerceState.initial(){
    return const EcommerceState(
      allProducts: [],
      products: [], 
      cart: [],
      homeScreenSate: HomeScreenSate.none,
    );
  }

  EcommerceState copyWith({
    List<ProductModel>? allProducts,
    List<ProductModel>? products,
    List<ProductModel>? cart,
    HomeScreenSate? homeScreenSate,
  }) {
    return EcommerceState(
      allProducts: allProducts ?? this.allProducts,
      products: products ?? this.products,
      cart: cart ?? this.cart,
      homeScreenSate: homeScreenSate ?? this.homeScreenSate
    );
  }
  
  @override
  List<Object> get props => [allProducts, products, cart, homeScreenSate];
}
