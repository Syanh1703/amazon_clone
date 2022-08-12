import 'package:amazon_clone/screens/order_detail_screen.dart';
import 'package:amazon_clone/services/admin_service.dart';
import 'package:amazon_clone/widgets/loader.dart';
import 'package:amazon_clone/widgets/single_product.dart';
import 'package:flutter/material.dart';

import '../models/order_model.dart';

class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final adminService = AdminService();
  List<OrderModel>? orders;

  void fetchOrders() async {
    orders = await adminService.fetchAllOrders(context);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetchOrders();
  }
  @override
  Widget build(BuildContext context) {
    return orders == null ? const Loader() : GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (ctx, index) {
          final orderData = orders![index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(context, OrderDetailScreen.orderScreenRouteName, arguments: orderData);
            },
            child: SizedBox(
              height: 140,
              child: SingleProduct(
                  orderData.products[0].images[0]
              ),
            ),
          );
        },
        itemCount: orders!.length,
    );
  }
}
