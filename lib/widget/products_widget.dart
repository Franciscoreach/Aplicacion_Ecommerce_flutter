import 'package:ecomerce_app/data.dart';
import 'package:ecomerce_app/widget/app_colors.dart';
import 'package:ecomerce_app/widget/app_primary_button.dart';
import 'package:flutter/material.dart';

class ProductsWidget extends StatelessWidget {
  const ProductsWidget({super.key});

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.fromLTRB(16,16,16,0),
      child: GridView.builder(
        itemCount: productsJson.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: .65,
        ),
        itemBuilder: (context,index){
          final product = productsJson[index];
          return _buildCardProduct(
            title: product["description"],
            imageUrl : product["image_url"],
            price: product["price"].toString(),
            productID: product["id"].toString(),
          );
        }, 
        
      ),
    );
  }


  _buildCardProduct({
    required String title,
    required String imageUrl,
    required String price,
    required String productID,
  }){
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
          child: Image.network(imageUrl),
        ),
        const SizedBox(height: 4),
        Text(
          title,
          style: TextStyle(
            color: AppColors.black,
            fontSize: 12,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "\$$price",
          style: TextStyle(
            color: AppColors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        AppPrimaryButton(
          onTap: (){
            //BLOC (evento) -> productID
          }, 
          text: "Add to cart",
          fontSize: 14,
          height: 30,
        ),
      ],
    );
  }


}