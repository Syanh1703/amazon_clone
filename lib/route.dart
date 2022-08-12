import 'package:amazon_clone/models/order_model.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/screens/add_product_screen.dart';
import 'package:amazon_clone/screens/address_screen.dart';
import 'package:amazon_clone/screens/auth_screen.dart';
import 'package:amazon_clone/screens/categories_deal_screen.dart';
import 'package:amazon_clone/screens/home_screen.dart';
import 'package:amazon_clone/screens/order_detail_screen.dart';
import 'package:amazon_clone/screens/product_detail_screen.dart';
import 'package:amazon_clone/screens/search_screen.dart';
import 'package:amazon_clone/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings route){
  //Constructing a Route
  switch(route.name){
    case AuthScreen.routeAuthScreen:
      return MaterialPageRoute(builder: (_) => AuthScreen());
    case HomeScreen.homeScreenRouteName:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case BottomBar.bottomBarRouteName:
      return MaterialPageRoute(builder: (_) => const BottomBar());
    case AddProductScreen.addProductScreenRoute:
      return MaterialPageRoute(builder: (_) => const AddProductScreen());
    case CategoriesDealScreen.categoryScreenRoute:
      var category = route.arguments as String;
      return MaterialPageRoute(builder: (_) => CategoriesDealScreen(category: category,));
    case SearchScreen.searchScreenRouteName:
      var searchQuery = route.arguments as String;
      return MaterialPageRoute(builder: (_) => SearchScreen(query: searchQuery));
    case ProductDetailScreen.productDetailRouteName:
      var product = route.arguments as ProductModel;
      return MaterialPageRoute(builder: (_) =>  ProductDetailScreen(product: product,));
    case AddressScreen.addressRouteName:
      var totalAmount = route.arguments as String;
      return MaterialPageRoute(builder: (_) => AddressScreen(totalAmount: totalAmount,));
    case OrderDetailScreen.orderScreenRouteName:
      var order = route.arguments as OrderModel;
      return MaterialPageRoute(builder: (_) => OrderDetailScreen(order: order));
    default:
      return MaterialPageRoute(builder: (_) => const Scaffold(
        body: Center(
          child: Text('The screen does not exist!'),
        ),
      ));
  }
}