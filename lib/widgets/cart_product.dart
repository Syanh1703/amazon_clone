import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/services/cart_service.dart';
import 'package:amazon_clone/services/product_detail_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';

class CartProduct extends StatefulWidget {
  final int index;
  CartProduct(this.index);

  @override
  State<CartProduct> createState() => _CartProductState();
}

class _CartProductState extends State<CartProduct> {

  final productDetailService = ProductDetailService();
  final cartService = CartService();
  
  void increaseQuantity(ProductModel product){
    productDetailService.addToCart(ctx: context, product: product);
  }
  
  void decreaseQuantity(ProductModel product){
    cartService.removeFromCart(ctx: context, product: product);
  }

  Widget featureContainer(String content, double fontSize,
      FontWeight fontWeight) {
    return Container(
      width: 235,
      padding: const EdgeInsets.only(left: 10, top: 5),
      child: Text(content, style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight
      ),),
    );
  }

  @override
  Widget build(BuildContext context) {
    final productCart = context.watch<UserProvider>().user.cart[widget.index];
    final product = ProductModel.fromMap(productCart['product']);
    final quantity = productCart['quantity'];

    return Column(
      children: <Widget>[
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10, top: 8),
          child: Row(
            children: <Widget>[
              Image.network(product.images[0], fit: BoxFit.contain,
                height: 135,
                width: 135,),

              ///Product Description
              Column(
                children: <Widget>[
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(product.name, style: const TextStyle(
                      fontSize: 18,
                    ),
                      maxLines: 2,
                    ),
                  ),
                  featureContainer('\$${product.price}', 20, FontWeight.bold),
                  featureContainer(
                      'Eligible for FREE Shipping', 16, FontWeight.normal),
                  Container(
                    width: 235,
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: const Text('In stock', style: TextStyle(
                        color: Colors.teal
                    ),
                      maxLines: 2,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        ///Add a button to control the quantity
        Container(
          margin: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget> [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.black12,
                      width: 1.5
                    ),
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black12,
                  ),
                  child: Row(
                    children: <Widget>[
                      InkWell(
                        child: Container(
                          width: 35,
                          height: 32,
                          alignment: Alignment.center,
                          child: const Icon(Icons.remove, size: 18,),
                        ),
                        onTap: () => decreaseQuantity(product),
                      ),
                      DecoratedBox(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black12, width: 1.5
                          ),
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(0),
                        ),
                        child: Container(
                          width: 35,
                          height: 32,
                          alignment: Alignment.center,
                          child: Text(quantity.toString(), style: const TextStyle(
                            fontSize: 15,
                          ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => increaseQuantity(product),
                        child: Container(
                          width: 35,
                          height: 32,
                          alignment: Alignment.center,
                          child: const Icon(Icons.add, size: 18,),
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
