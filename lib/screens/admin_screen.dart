import 'package:amazon_clone/screens/order_screen.dart';
import 'package:amazon_clone/screens/products_manage_screen.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';

import '../constants/global_var.dart';

class AdminScreen extends StatefulWidget {
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  int _page = 0;
  final double _bottomContainerWidth = 42;
  final double _bottomBarBorderWidth = 5;

  BottomNavigationBarItem bottomBarItem(double containerWidth, double bottomBarWidth, IconData icon, int presentPage, String label, int itemPage){
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
    const ProductsManageScreen(),
    const Center(
      child: Text('Analytics Page'),
    ),
    const OrderScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalVars.screenCommon('Admin'),
      body: pages[_page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _page,
        selectedItemColor: GlobalVars.selectedNavBarColor,
        unselectedItemColor: GlobalVars.unselectedNavBarColor,
        backgroundColor: GlobalVars.backgroundColor,
        iconSize: 28,
        onTap: updateBottomPage,
        items: [
        bottomBarItem(_bottomContainerWidth, _bottomBarBorderWidth, Icons.home_outlined, _page, 'Post', 0),
          bottomBarItem(_bottomContainerWidth, _bottomBarBorderWidth, Icons.analytics_outlined, _page , 'Analytics', 1),
          bottomBarItem(_bottomContainerWidth, _bottomBarBorderWidth, Icons.all_inbox_outlined, _page, 'Orders',2),
        ],
    ),
    );
  }
}
