import 'package:ecomerce_app/model/product_model.dart';
import 'package:ecomerce_app/pages/bloc/ecommerce_bloc.dart';
import 'package:ecomerce_app/widget/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 140,
        title: SizedBox(
          width: size.width,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Cart",
                    style: TextStyle(
                      color: AppColors.black,
                      fontSize: 24,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  CircleAvatar(
                    backgroundColor: AppColors.greyBackground,
                    child: Icon(
                      Icons.more_horiz_rounded,
                      color: AppColors.black,
                      size: 24.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12), 
              Container(
                width: size.width * 0.9,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.greyBackground,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      Icons.location_on,
                      color: AppColors.black,
                      size: 20,
                    ),
                    Expanded(
                      child: Text(
                        '92 High Street, London',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: AppColors.black,
                          fontSize: 16, // Aumentar el tamaño de la fuente para que se vea más grande
                        ),
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.black,
                      size: 16,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      body: Container(
        margin: const EdgeInsets.only(top: 8),
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16),
            topRight: Radius.circular(16),
          ),
        ),
        child: BlocBuilder<EcommerceBloc, EcommerceState>(
          builder: (context, state) {
            if (state.cart.isEmpty) {
              return Center(
                child: Text(
                  "Your cart is empty",
                  style: TextStyle(fontSize: 16, color: AppColors.black),
                ),
              );
            }

            return ListView.builder(
              itemCount: state.cart.length,
              itemBuilder: (context, index) {
                final product = state.cart[index];
                return _buildCardItem(product, context);
              },
            );
          },
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ElevatedButton(
          onPressed: () {},
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.green,
            padding: const EdgeInsets.symmetric(vertical: 12),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
            ),
          ),
          child: Text(
            'Checkout',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w800,
              color: AppColors.black,
            ),
          ),
        ),
      ),
    );
  }

  _buildCardItem(ProductModel product, BuildContext context) {
  return Container(
    height: 130,
    width: double.infinity,
    padding: const EdgeInsets.all(8),
    child: Row(
      children: [
        IconButton(
          onPressed: () {
            context.read<EcommerceBloc>().add(RemoveCartItemEvent(product.id));
          },
          icon: Icon(
            Icons.delete,
            color: AppColors.red,
          ),
        ),
        Container(
          width: 100,
          height: 100,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.greyBackground,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Image.network(product.imageUrl),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(
              top: 16,
              bottom: 16,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  product.name,
                  maxLines: 2,
                  style: TextStyle(
                    color: AppColors.black,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "\$${product.price * product.quantity}",
                      style: TextStyle(
                        color: AppColors.black,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Row(
                      children: [
                        CircleAvatar(
                          backgroundColor: AppColors.greyBackground,
                          radius: 14,
                          child: IconButton(
                            icon: Icon(
                              Icons.remove,
                              color: AppColors.black,
                              size: 14,
                            ),
                            onPressed: () {
                              // Disminuir cantidad
                              context.read<EcommerceBloc>().add(UpdateCartQuantityEvent(
                                productId: product.id,
                                quantityChange: -1,
                              ));
                            },
                          ),
                        ),
                        SizedBox(
                          width: 40,
                          child: Center(
                            child: Text(product.quantity.toString()),
                          ),
                        ),
                        CircleAvatar(
                          backgroundColor: AppColors.greyBackground,
                          radius: 14,
                          child: IconButton(
                            icon: Icon(
                              Icons.add,
                              color: AppColors.black,
                              size: 14,
                            ),
                            onPressed: () {
                              // Aumentar cantidad
                              context.read<EcommerceBloc>().add(UpdateCartQuantityEvent(
                                productId: product.id,
                                quantityChange: 1,
                              ));
                            },
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
}
