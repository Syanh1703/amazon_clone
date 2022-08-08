import 'dart:convert';

import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import '../constants/error_handling.dart';
import '../constants/global_var.dart';
import '../constants/utils.dart';
import '../models/product_model.dart';
import '../providers/user_provider.dart';
import 'package:http/http.dart' as http;

class SearchService{
  Future<List<ProductModel>> fetchSearchedProduct({
    required BuildContext context,
    required String searchQuery,
  }) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> productList = [];

    try{
      //Sen the get request
      http.Response httpResponse = await http.get(Uri.parse('$uri/api/products/search/$searchQuery'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': userProvider.user.token
        },
      );
      httpErrorHandling(response: httpResponse, context: context, onSuccess: (){
        //Convert the JSON format to a Product Model
        for(int i = 0; i < jsonDecode(httpResponse.body).length; i++){
          productList.add(ProductModel.fromJson(
              jsonEncode(jsonDecode(httpResponse.body)[i])
          )
          );
        }
      });
    }catch(error){
      showSnackbar(context, error.toString());
      print(error.toString());
    }
    return productList;
  }
}