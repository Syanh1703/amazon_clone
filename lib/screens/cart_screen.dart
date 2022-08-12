import 'package:amazon_clone/constants/global_var.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/screens/address_screen.dart';
import 'package:amazon_clone/screens/search_screen.dart';
import 'package:amazon_clone/widgets/address_box.dart';
import 'package:amazon_clone/widgets/cart_product.dart';
import 'package:amazon_clone/widgets/cart_subtotal.dart';
import 'package:amazon_clone/widgets/common/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  void navigateToSearchScreen(String query){
    Navigator.pushNamed(context, SearchScreen.searchScreenRouteName, arguments: query);
  }

  void navigateToAddressScreen(String sum){
    Navigator.pushNamed(context, AddressScreen.addressRouteName, arguments: sum);
  }

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    num sum = 0;
    user.cart.map((index) => sum += (index['quantity'] * index['product']['price']) as num).toList();
    //sum = double.parse(sum.toStringAsFixed(2));

    return Scaffold(
      appBar: GlobalVars.homeScreenCommon((query) => navigateToSearchScreen),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            const AddressBox(),
            const CartSubtotal(),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomButton(buttonText: 'Proceed to buy (${user.cart.length} items)', onTap:() => navigateToAddressScreen(sum.toString()),
                textColor: Colors.black,
              color: Colors.yellow[600],
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              height: 1,
              color: Colors.black12.withOpacity(0.08),
            ),
            const SizedBox(
              height: 5,
            ),
            ListView.builder(itemBuilder: (ctx, index) {
              return CartProduct(index);
            },
              shrinkWrap: true,
            itemCount: user.cart.length,
            ),

          ],
        ),
      ),
    );
  }
}
