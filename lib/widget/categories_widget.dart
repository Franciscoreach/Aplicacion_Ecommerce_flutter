import 'package:ecomerce_app/widget/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ecomerce_app/pages/bloc/ecommerce_bloc.dart';

class CategoriesWidget extends StatelessWidget {
  const CategoriesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Categories',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),
          BlocBuilder<EcommerceBloc, EcommerceState>(
            builder: (context, state) {
              // Extraemos las categorías únicas
              final categories = state.allProducts
                  .map((product) => product.category)
                  .toSet()
                  .toList();

              return Container(
                height: 100,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: categories.map((category) {
                    IconData icon;
                    switch (category) {
                      case 'Smartphone':
                        icon = Icons.phone_android;
                        break;
                      case 'HeadPhone':
                        icon = Icons.headphones;
                        break;
                      case 'Game':
                        icon = Icons.videogame_asset;
                        break;
                      case 'Notebook':
                        icon = Icons.laptop;
                        break;
                      case 'TV':
                        icon = Icons.tv;
                        break;
                      default:
                        icon = Icons.category;
                    }

                    return _buildCategoryIcon(
                      context,
                      icon: icon,
                      label: category,
                      onTap: () {
                        context
                            .read<EcommerceBloc>()
                            .add(FilterByCategoryEvent(category: category));
                      },
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryIcon(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Column(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: AppColors.greyBackground,
              child: Icon(icon, size: 28, color: AppColors.black),
            ),
            const SizedBox(height: 4),
            Text(
              label,
              style: const TextStyle(fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
