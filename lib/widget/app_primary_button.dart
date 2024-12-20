import 'package:ecomerce_app/widget/app_colors.dart';
import 'package:flutter/material.dart';

class AppPrimaryButton extends StatelessWidget {

  final Function()? onTap;
  final String text;
  final double? height;
  final double? fontSize;

  const AppPrimaryButton({
    super.key, 
    required this.onTap, 
    required this.text,
    this.height = 30,
    this.fontSize = 14,
    });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: onTap, 
          child: Container(
            width: double.infinity,
            height: height,
            decoration: BoxDecoration(
              color: AppColors.green,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Center(
              child: Text(
                text,
                style: TextStyle(
                  color: AppColors.black,
                  fontSize: fontSize,
                ),
              )
            ),
          ),
    );
  }
}