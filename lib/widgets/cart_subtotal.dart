import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CartSubtotal extends StatelessWidget {
  const CartSubtotal({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserProvider>().user;
    num sum = 0;
    user.cart.map((index) => sum += (index['quantity'] * index['product']['price']) as num).toList();
    //sum = double.parse(sum.toStringAsFixed(2));
    return Container(
      margin: const EdgeInsets.all(10),
      child: Row(
        children: <Widget>[
          const Text('Subtotal:', style: TextStyle(
            fontSize: 20,
          ),
          ),
          Text('\$$sum', style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),),
        ],
      ),
    );
  }
}
