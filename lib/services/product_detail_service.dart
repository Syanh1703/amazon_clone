import 'dart:convert';

import 'package:amazon_clone/models/user_model.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/error_handling.dart';
import '../constants/global_var.dart';
import '../constants/utils.dart';
import '../models/product_model.dart';
import '../providers/user_provider.dart';

class ProductDetailService{
  void rateProduct({
    required BuildContext ctx,
    required ProductModel product,
    required double rating,
  })  async {
    final userProvider = Provider.of<UserProvider>(ctx, listen: false);
    try{

      //31_07: Create a post request to check the database
      http.Response res = await http.post(Uri.parse('$uri/api/rate-product'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
          body: jsonEncode({
            'id': product.id,
            'rating': rating,
          })
      );

      //Error handling
      httpErrorHandling(response: res, context: ctx, onSuccess: (){});
    }catch(error){
      showSnackbar(ctx, error.toString());
    }
  }

  void addToCart({
    required BuildContext ctx,
    required ProductModel product,
  })  async {
    final userProvider = Provider.of<UserProvider>(ctx, listen: false);
    try{

      //31_07: Create a post request to check the database
      http.Response res = await http.post(Uri.parse('$uri/api/add-to-cart'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
          body: jsonEncode({
            'id': product.id,
          })
      );

      //Error handling
      httpErrorHandling(response: res, context: ctx, onSuccess: (){
          UserModel user = userProvider.user.copyWith(cart: jsonDecode(res.body)['cart']);
          userProvider.setUserFromModel(user);
      });
    }catch(error){
      showSnackbar(ctx, error.toString());
      print(error.toString());
    }
  }

}