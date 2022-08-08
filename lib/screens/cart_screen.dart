import 'package:amazon_clone/constants/global_var.dart';
import 'package:amazon_clone/screens/search_screen.dart';
import 'package:amazon_clone/widgets/address_box.dart';
import 'package:flutter/material.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToSearchScreen(String query){
    Navigator.pushNamed(context, SearchScreen.searchScreenRouteName, arguments: query);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: GlobalVars.homeScreenCommon((query) => navigateToSearchScreen),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const AddressBox(),
            
          ],
        ),
      ),
    );
  }
}
