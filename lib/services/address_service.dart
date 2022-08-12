import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_var.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import '../models/user_model.dart';

//30_07: Create API to upload all the images
class AddressService {

  void saveUserAddress({
    required BuildContext context,
    required String address,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/save-user-address'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token,
        },
        body: jsonEncode({
          'address': address,
        }),
      );

      httpErrorHandling(
        response: res,
        context: context,
        onSuccess: () {
          UserModel user = userProvider.user.copyWith(
            address: jsonDecode(res.body)['address'],
          );

          userProvider.setUserFromModel(user);
        },
      );
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  void placeOrder(
  {
    required BuildContext context,
    required String address,
    required double totalSum,
}) async {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      try{
        http.Response res = await http.post(Uri.parse('$uri/api/order-product'),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
              'x-auth-token': userProvider.user.token
            },
        body: jsonEncode({
          'cart': userProvider.user.cart,
          'address': address,
          'totalPrice': totalSum,
        })
        );

        httpErrorHandling(response: res, context: context, onSuccess: (){
            showSnackbar(context, 'Your order is ready');
            UserModel user = userProvider.user.copyWith(cart: [],);
            userProvider.setUserFromModel(user);
        });
      }catch(error){
        print('Error in Order: ${error.toString()}');
      }
  }
}