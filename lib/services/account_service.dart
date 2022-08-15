import 'dart:convert';

import 'package:amazon_clone/models/order_model.dart';
import 'package:amazon_clone/screens/auth_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constants/error_handling.dart';
import '../constants/global_var.dart';
import '../constants/utils.dart';
import 'package:flutter/material.dart';

import '../providers/user_provider.dart';
import 'package:http/http.dart' as http;

class AccountService{
  Future<List<OrderModel>> fetchOrders({
    required BuildContext context,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<OrderModel> orderList = [];

    try{
      //Sen the get request
      http.Response httpResponse = await http.get(Uri.parse('$uri/api/orders/me'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
      );
      httpErrorHandling(response: httpResponse, context: context, onSuccess: (){
        //Convert the JSON format to a Order Model
        for(int i = 0; i < jsonDecode(httpResponse.body).length; i++){
          orderList.add(OrderModel.fromJson(
              jsonEncode(jsonDecode(httpResponse.body)[i])
          )
          );
        }
      });
    }catch(error){
      showSnackbar(context, error.toString());
      print(error.toString());
    }
    return orderList;
  }

  //Log out the user
  void logOut(BuildContext context) async {
      try{
        //Check token on user device
        SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
        await sharedPreferences.setString('x-auth-token', ''); //Empty the token
        Navigator.pushNamedAndRemoveUntil(context, AuthScreen.routeAuthScreen, (route) => false);
      }catch(error){
        showSnackbar(context, error.toString());
      }
  }
}