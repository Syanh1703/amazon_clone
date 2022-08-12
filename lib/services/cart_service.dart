import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../constants/error_handling.dart';
import '../constants/global_var.dart';
import '../constants/utils.dart';
import '../models/product_model.dart';
import 'package:http/http.dart' as http;

import '../models/user_model.dart';
import '../providers/user_provider.dart';


class CartService{
  void removeFromCart({
    required BuildContext ctx,
    required ProductModel product,
  })  async {
    final userProvider = Provider.of<UserProvider>(ctx, listen: false);
    try{

      //31_07: Create a post request to check the database
      http.Response res = await http.delete(Uri.parse('$uri/api/remove-from-cart/${product.id}'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
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