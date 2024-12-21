import 'package:ecomerce_app/model/product_model.dart';
import 'package:ecomerce_app/pages/bloc/ecommerce_bloc.dart';
import 'package:ecomerce_app/widget/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EcommerceBloc, EcommerceState>(
      builder: (context, state) {
        return ListView.builder(
          itemCount: state.cart.length,
          itemBuilder: (context, index) {
            if (state.cart.isEmpty) {
              return const SizedBox.shrink();
            }
            final product = state.cart[index];

            return _buildCardItem(product);
          },
        );
      },
    );
  }

  _buildCardItem(ProductModel product) {
    return Container(
      height: 130,
      width: double.infinity,
      padding: const EdgeInsets.all(8),
      child: Row(
        children: [
          IconButton(
            onPressed: () {},
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
                            child: Icon(
                              Icons.remove,
                              color: AppColors.black,
                              size: 14,
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
                            child: Icon(
                              Icons.add,
                              color: AppColors.black,
                              size: 14,
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
