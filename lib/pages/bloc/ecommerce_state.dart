part of 'ecommerce_bloc.dart';

enum HomeScreenState {
  none,
  loading,
  success,
  failure,
}

enum CatalogScreenState {
  none,
  loading,
  success,
  failure
}

class EcommerceState extends Equatable {
  final List<ProductModel> cart;
  final List<ProductModel> products;
  final List<ProductModel> catalogProducts;
  final HomeScreenState homeScreenState;
  final CatalogScreenState catalogScreenState;

  const EcommerceState({
    required this.cart,
    required this.products,
    required this.homeScreenState,
    required this.catalogProducts,
    required this.catalogScreenState,
  });

  factory EcommerceState.initial() {
    return const EcommerceState(
      cart: [], // Inicializa el carrito como una lista vacía
      products: [],
      homeScreenState: HomeScreenState.none,
      catalogProducts: [],
      catalogScreenState: CatalogScreenState.none,
    );
  }

  EcommerceState copyWith({
    List<ProductModel>? cart,
    List<ProductModel>? products,
    HomeScreenState? homeScreenState,
    List<ProductModel>? catalogProducts,
    CatalogScreenState? catalogScreenState,
  }) {
    return EcommerceState(
      cart: cart ?? this.cart,
      products: products ?? this.products,
      homeScreenState: homeScreenState ?? this.homeScreenState,
      catalogProducts: catalogProducts ?? this.catalogProducts,
      catalogScreenState: catalogScreenState ?? this.catalogScreenState,
    );
  }

  @override
  List<Object?> get props => [cart, products, homeScreenState, catalogProducts, catalogScreenState];
}
