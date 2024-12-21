import 'package:ecomerce_app/pages/bloc/ecommerce_bloc.dart';
import 'package:ecomerce_app/widget/app_colors.dart';
import 'package:ecomerce_app/widget/categories_widget.dart';
import 'package:ecomerce_app/widget/products_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: context.read<EcommerceBloc>()..add(LoadProductsEvent()),
      child: const _Body(),
    );
  }
}

class _Body extends StatelessWidget {
  // ignore: unused_element
  const _Body({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 16,
          ),
          child: CircleAvatar(
            backgroundColor: AppColors.green,
            child: Icon(
              Icons.shopify_rounded,
              color: AppColors.black,
              size: 24.0,
            ),
          ),
        ),
        title: SizedBox(
          width: size.width,
          child: Column(
            children: [
              Text(
                "Delivery address",
                style: TextStyle(
                  color: AppColors.greyLight,
                  fontSize: 12,
                ),
              ),
              Text(
                "92 High Street, London",
                style: TextStyle(
                    color: AppColors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
        actions: [
          CircleAvatar(
            backgroundColor: AppColors.greyBackground,
            child: Icon(
              Icons.notifications_none_outlined,
              color: AppColors.black,
              size: 24.0,
            ),
          ),
          const SizedBox(width: 16),
        ],
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
            )),
        child: const Column(
          children: [
            CategoriesWidget(),
            Expanded(child: ProductsWidget()),
          ],
        ),
      ),
    );
  }
}
