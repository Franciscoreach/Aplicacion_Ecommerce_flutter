import 'package:ecomerce_app/model/product_model.dart';
import 'package:ecomerce_app/pages/bloc/ecommerce_bloc.dart';
import 'package:ecomerce_app/widget/app_colors.dart';
import 'package:ecomerce_app/widget/app_primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      child: BlocBuilder<EcommerceBloc, EcommerceState>(
        builder: (context, state) {
          if (state.homeScreenSate == HomeScreenSate.loading) {
            return const Center(child: CircularProgressIndicator());
          }
          return GridView.builder(
            itemCount: state.products.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: .65,
            ),
            itemBuilder: (context, index) {
              final product = state.products[index];
              return _buildCardProduct(
                context: context,
                product: product,
              );
            },
          );
        },
      ),
    );
  }

  _buildCardProduct({
    required BuildContext context,
    required ProductModel product,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 155,
          decoration: BoxDecoration(
            color: AppColors.greyBackground,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Image.network(product.imageUrl),
        ),
        const SizedBox(height: 4),
        Text(
          product.name,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "\$${product.price}",
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        AppPrimaryButton(
          onTap: () {
            //BLOC (evento) -> productID
            context.read<EcommerceBloc>().add(AddToCartEvent(
              product: product,
              ));
          },
          text: "Add to cart",
          fontSize: 14,
          height: 30,
        ),
      ],
    );
  }
}
