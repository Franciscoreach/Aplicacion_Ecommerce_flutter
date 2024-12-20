import 'package:ecomerce_app/pages/cart_page.dart';
import 'package:ecomerce_app/pages/home_page.dart';
import 'package:ecomerce_app/widget/app_colors.dart';
import 'package:flutter/material.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int selecectedIndex = 0;

  final List<Widget> _pages = const [
    HomePage(),
    Center(child: Text("Coming Soon")),
    CartPage(),
    Center(child: Text("Coming Soon")),
    Center(child: Text("Coming Soon")),
  ];

  void onitemTapped(int index){
    setState(() {
      selecectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[selecectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selecectedIndex,
        onTap: onitemTapped,
        selectedItemColor: AppColors.green,
        unselectedItemColor: AppColors.black,
        type: BottomNavigationBarType.fixed,
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.home, 
              color: AppColors.green,
            ),
            icon: Icon(
              Icons.home, 
              color: AppColors.black,
            ),
            label: "Home",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.search, 
              color: AppColors.green,
              ),
            icon: Icon(
              Icons.search, 
              color: AppColors.black,
              ),
            label: "Catalog",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.shop, 
              color: AppColors.green,
              ),
            icon: Icon(
              Icons.shop, 
              color: AppColors.black,
              ),
            label: "Cart",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.favorite, 
              color: AppColors.green,
              ),
            icon: Icon(
              Icons.favorite, 
              color: AppColors.black,
              ),
            label: "Favorites",
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.person, 
              color: AppColors.green,
              ),
            icon: Icon(
              Icons.person, 
              color: AppColors.black,
              ),
            label: "Profile",
          ),
        ],
      ),
    );
  }
}