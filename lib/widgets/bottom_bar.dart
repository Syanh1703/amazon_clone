import 'package:amazon_clone/constants/global_var.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/screens/account_screen.dart';
import 'package:amazon_clone/screens/cart_screen.dart';
import 'package:amazon_clone/screens/home_screen.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

//28_07: Start working on the bottom Navigation bar

class BottomBar extends StatefulWidget {
  static const String bottomBarRouteName = '/bottom-bar';
  const BottomBar({Key? key}) : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _page = 0;
  final double _bottomContainerWidth = 42;
  final double _bottomBarBorderWidth = 5;

  BottomNavigationBarItem bottomBarItem(double containerWidth, double bottomBarWidth, IconData icon, int presentPage, String label, int itemPage, String badgeContent){
    return BottomNavigationBarItem(
        icon: Container(
          width: containerWidth,
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: presentPage == itemPage ? GlobalVars.selectedNavBarColor : GlobalVars.backgroundColor,
                width: bottomBarWidth,
              )
            )
          ),
          child: Badge(
            badgeColor: Colors.white,
              badgeContent: Text(badgeContent),
              elevation: 0,
              child: Icon(icon),
          ),
        ),
      label: label,
    );
  }

  void updateBottomPage(int page){
    setState(() {
      _page = page;
    });
  }

  List <Widget> pages = [
    const HomeScreen(),
    AccountScreen(),
    const CartScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    final userCartLength = context.watch<UserProvider>().user.cart.length;
    return Scaffold(
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVars.selectedNavBarColor,
        unselectedItemColor: GlobalVars.unselectedNavBarColor,
        backgroundColor: GlobalVars.backgroundColor,
        iconSize: 28,
        onTap: updateBottomPage,
        items: [
          bottomBarItem(_bottomContainerWidth, _bottomBarBorderWidth, Icons.home_outlined, _page, 'Home', 0, ''),
          bottomBarItem(_bottomContainerWidth, _bottomBarBorderWidth, Icons.person_outline, _page , 'Account', 1, ''),
          bottomBarItem(_bottomContainerWidth, _bottomBarBorderWidth, Icons.shopping_cart_outlined, _page, 'Cart',2, userCartLength.toString()),
        ],
      ),
    );
  }
}
