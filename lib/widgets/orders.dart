import 'package:amazon_clone/constants/global_var.dart';
import 'package:amazon_clone/widgets/single_product.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {

  //Temporary list
  List productList = [
    'https://images.unsplash.com/photo-1644982649363-fae51da44eac?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
    'https://images.unsplash.com/photo-1644982649363-fae51da44eac?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
    'https://images.unsplash.com/photo-1644982649363-fae51da44eac?ixlib=rb-1.2.1&ixid=MnwxMjA3fDF8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children : <Widget> [
            Container(
                padding: const EdgeInsets.only(left: 15),
                child: const Text('Your orders', style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
                ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 15),
              child: Text('See all', style: TextStyle(
                  color: GlobalVars.selectedNavBarColor,
                  fontWeight: FontWeight.w600,
                  fontSize: 18,
              ),
              ),
            ),

        ],
        ),
        ///Display products
        Container(
          height: 170,
          padding: const EdgeInsets.all(16),
          child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemBuilder: ((ctx, index) {
                return SingleProduct(productList[index]);
              }),
            itemCount: productList.length,
          ),
        )
      ],
    );
  }
}
