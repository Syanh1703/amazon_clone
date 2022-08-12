import 'package:amazon_clone/constants/global_var.dart';
import 'package:amazon_clone/screens/order_detail_screen.dart';
import 'package:amazon_clone/services/account_service.dart';
import 'package:amazon_clone/widgets/loader.dart';
import 'package:amazon_clone/widgets/single_product.dart';
import 'package:flutter/material.dart';

import '../models/order_model.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {


  List<OrderModel>? orders;
  final accountService = AccountService();

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }

  void fetchOrders() async {
    orders = await accountService.fetchOrders(context: context);
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return orders == null ? const Loader() : Column(
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
                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(context, OrderDetailScreen.orderScreenRouteName, arguments: orders![index]);
                    },
                      child: SingleProduct(orders![index].products[0].images[0]));
                }),
              itemCount: orders!.length,
            ),
          )
        ],
    );
  }
}
