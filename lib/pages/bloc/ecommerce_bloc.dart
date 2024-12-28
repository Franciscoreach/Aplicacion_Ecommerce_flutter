import 'package:dio/dio.dart';
import 'package:ecommerce_app/model/product_model.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';

part 'ecommerce_event.dart';
part 'ecommerce_state.dart';

const homeUrl = "https://ecommerce-6a1c2-default-rtdb.firebaseio.com/adl_ecommerce";
const cartUrl = "https://ecommerce-6a1c2-default-rtdb.firebaseio.com/adl_ecommerce_cart";

class EcommerceBloc extends Bloc<EcommerceEvent, EcommerceState> {
  var uuid = Uuid();
  var dio = Dio();

  EcommerceBloc() : super(EcommerceState.initial()) {
    on<LoadProductsEvent>(_onLoadProductsEvent);
    on<LoadCartItemsEvent>(_onLoadCartItemsEvent);
    on<AddToCartEvent>(_onAddToCartEvent);
    on<UpdateCartQuantityEvent>(_onUpdateCartQuantityEvent);
    on<RemoveCartItemEvent>(_onRemoveCartItemEvent);
    on<LoadCatalogProductsEvent>(_onLoadCatalogProductsEvent);
    on<CreateNewProductsEvent>(_onCreateNewProductsEvent);
    on<UpdateProductEvent>(_onUpdateProductEvent);
    on<RemoveCatalogItemEvent>(_onRemoveCatalogItemEvent);

  }

void _onLoadProductsEvent(LoadProductsEvent event, Emitter<EcommerceState> emit) async {
    emit(state.copyWith(homeScreenState: HomeScreenState.loading));

    final response = await dio.get('$homeUrl.json');
    final data = response.data as Map<String, dynamic>?;
    final responseCart = await dio.get('$cartUrl.json');
    final dataCart = responseCart.data as Map<String, dynamic>?;

    if (data == null) {
      emit(
        state.copyWith(
          homeScreenState: HomeScreenState.success,
          products: [],
        ),
      );
      return;
    }

    final products = data.entries.map((prod) {
      return ProductModel(
        id: prod.key,
        name: prod.value["description"],
        price: double.parse(prod.value["price"].toString()),
        imageUrl: prod.value["image_url"],
      );
    }).toList();

    List<ProductModel> cartListItems = [];
    if (dataCart != null) {
      cartListItems = dataCart.entries.map((prod) {
        return ProductModel(
          id: prod.key,
          name: prod.value["description"],
          price: double.parse(prod.value["price"].toString()),
          imageUrl: prod.value["image_url"],
          quantity: prod.value["quantity"] ?? 1,
        );
      }).toList();
    }

    emit(state.copyWith(
      homeScreenState: HomeScreenState.success,
      products: products,
      cart: cartListItems,
    ));


  }

void _onLoadCartItemsEvent(LoadCartItemsEvent event, Emitter<EcommerceState> emit) async {
  final response = await dio.get('$cartUrl.json');
  final data = response.data as Map<String, dynamic>?;

  if (data == null || data.isEmpty) {
    emit(state.copyWith(cart: []));
    return;
  }

  final cartItems = data.entries.map((prod) {
    final product = prod.value;
    return ProductModel(
      id: product["id"],
      name: product["description"],
      price: double.parse(product["price"].toString()),
      imageUrl: product["image_url"],
      quantity: product["quantity"] ?? 1,
    );
  }).toList();

  emit(state.copyWith(cart: cartItems));
  }


void _onAddToCartEvent(AddToCartEvent event, Emitter<EcommerceState> emit) async {
    final ProductModel product = event.product;

    // 1. verificar si existe
    final existItemIndex = state.cart.indexWhere((p) => p.id == product.id);

    if (existItemIndex >= 0) {
      // EXISTE!!!
      // Incrementar la cantidad
      final productItem = state.cart[existItemIndex];
      final newQuantity = productItem.quantity + 1;

      // Actualizar FB
      await dio.patch(
        "$cartUrl/${product.id}.json",
        data: {
          "quantity": newQuantity,
        },
      );

      final updateCart = [...state.cart];
      updateCart[existItemIndex] = productItem.copyWith(quantity: newQuantity);

      emit(state.copyWith(cart: updateCart));
    } else {
      // NO EXISTE!!!
      await dio.put(
        "$cartUrl/${product.id}.json",
        data: {
          "id": product.id,
          "description": product.name,
          "product": "",
          "image_url": product.imageUrl,
          "price": product.price,
          "quantity": 1,
        },
      );

      final updateCart = [...state.cart, product];
      emit(state.copyWith(cart: updateCart));
    }
  }

void _onUpdateCartQuantityEvent(UpdateCartQuantityEvent event, Emitter<EcommerceState> emit) async {
  final ProductModel product = event.product;

  final existItemIndex = state.cart.indexWhere((p) => p.id == product.id);

  if (existItemIndex >= 0) {
    final productItem = state.cart[existItemIndex];
    final newQuantity = productItem.quantity + event.newQty;

    if (newQuantity > 0) {
      await dio.patch(
        "$cartUrl/${product.id}.json",
        data: {"quantity": newQuantity},
      );

      final updatedCart = [...state.cart];
      updatedCart[existItemIndex] = productItem.copyWith(quantity: newQuantity);
      emit(state.copyWith(cart: updatedCart));
    } else {
      await dio.delete("$cartUrl/${product.id}.json");

      final updatedCart = state.cart.where((p) => p.id != product.id).toList();
      emit(state.copyWith(cart: updatedCart));
    }

    final updatedCart = [...state.cart];
    emit(state.copyWith(cart: updatedCart));
  }
}

void _onRemoveCartItemEvent(RemoveCartItemEvent event, Emitter<EcommerceState> emit) async {

    final ProductModel product = event.product;

    await dio.delete("$cartUrl/${product.id}.json");

    final updatedCart = state.cart.where((p) => p.id != event.product.id).toList();

    emit(state.copyWith(cart: updatedCart));
  }


void _onLoadCatalogProductsEvent(LoadCatalogProductsEvent event, Emitter<EcommerceState> emit) async {
  emit(state.copyWith(catalogScreenState: CatalogScreenState.loading));

  final response = await dio.get('$homeUrl.json');
  final data = response.data as Map<String, dynamic>?;
  
  if (data == null) {
    emit(
      state.copyWith(
        catalogScreenState: CatalogScreenState.success,
        catalogProducts: [],
      ),
    );
    return;
  }

  final catalogProducts = data.entries.map((prod) {
      return ProductModel(
        id: prod.key,
        name: prod.value["description"],
        price: double.parse(prod.value["price"].toString()),
        imageUrl: prod.value["image_url"],
      );
    }).toList();

  emit(state.copyWith(
    catalogScreenState: CatalogScreenState.success,
    catalogProducts: catalogProducts,
  ));

}

void _onCreateNewProductsEvent(CreateNewProductsEvent event, Emitter<EcommerceState> emit) async {
  final String prodUID = uuid.v1();

  final data = {
      "id": prodUID,
      "description": event.description,
      "product": "",
      "image_url": event.imageUrl,
      "price": event.price,
  };

  await dio.put("$homeUrl/$prodUID.json", data: data);

  final newProduct = ProductModel(
    id: prodUID,
    name: event.description,
    price: double.parse(event.price.toString()),
    imageUrl: event.imageUrl,
  );

  final updateProducts = [...state.catalogProducts, newProduct];
  emit(state.copyWith(catalogProducts: updateProducts));

}


void _onUpdateProductEvent(UpdateProductEvent event, Emitter<EcommerceState> emit) async {
  final productIndex = state.catalogProducts.indexWhere((product) => product.id == event.productId);

  if (productIndex >= 0) {

    final updatedProduct = ProductModel(
      id: event.productId,
      name: event.description,
      price: event.price.toDouble(),
      imageUrl: event.imageUrl,
    );

    final updatedCatalog = List<ProductModel>.from(state.catalogProducts);
    updatedCatalog[productIndex] = updatedProduct;

    emit(state.copyWith(
      catalogProducts: updatedCatalog,
    ));

    await dio.patch(
      "$homeUrl/${event.productId}.json",
      data: {
        "description": event.description,
        "image_url": event.imageUrl,
        "price": event.price,
      },
    );
  }
}


void _onRemoveCatalogItemEvent(RemoveCatalogItemEvent event, Emitter<EcommerceState> emit) async {
  final productId = event.product.id;
  final productIndex = state.catalogProducts.indexWhere((product) => product.id == productId);

  if (productIndex >= 0) {
    final updatedCatalog = state.catalogProducts.where((product) => product.id != productId).toList();

    emit(state.copyWith(catalogProducts: updatedCatalog));
    await dio.delete("$homeUrl/$productId.json");
  }
}


}
