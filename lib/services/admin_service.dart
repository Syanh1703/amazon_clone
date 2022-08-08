import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_var.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/product_model.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

//30_07: Create API to upload all the images
class AdminService{
  final String _cloudName = 'amazonclone1703';
  final String _uploadPreset = 'f7b0nvhn';
  void sellProducts({
    required BuildContext ctx,
    required String name,
    required String des,
    required double price,
    required double quantity,
    required String category,
    required List<File> images,
})  async {
    final userProvider = Provider.of<UserProvider>(ctx, listen: false);
    try{
      final cloudinary = CloudinaryPublic(_cloudName, _uploadPreset);
      List<String> imagesUrl = [];
     for(int i = 0; i<images.length; i++){
        CloudinaryResponse resp = await cloudinary.uploadFile(CloudinaryFile.fromFile(images[i].path, folder: name));
        imagesUrl.add(resp.secureUrl);
      }

     //Create a product with product model
      ProductModel productModel = ProductModel(name: name, des: des, price: price, quantity: quantity, category: category, images: imagesUrl);

     //31_07: Create a post request to check the database
      http.Response res = await http.post(Uri.parse('$uri/admin/add-product'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
        body: productModel.toJson()
      );

      //Error handling
      httpErrorHandling(response: res, context: ctx, onSuccess: (){
        showSnackbar(ctx, 'Product added successfully');
        Navigator.of(ctx).pop();

      });
    }catch(error){
      showSnackbar(ctx, error.toString());
    }
  }

  //31_07: Get all the products
  Future<List<ProductModel>> fetchAllProducts(BuildContext context) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    List<ProductModel> productList = [];

    try{
      //Sen the get request
      http.Response httpResponse = await http.get(Uri.parse('$uri/admin/get-products'),
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

  //31_07: Delete the product from the list
  void deleteProduct({
    required BuildContext context,
    required ProductModel product,
    required VoidCallback onSuccess,
}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try{

      //31_07: Create a post request to check the database
      http.Response res = await http.post(Uri.parse('$uri/admin/delete-product'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': userProvider.user.token
          },
          body: jsonEncode({
            'id': product.id
          })
      );

      //Error handling
      httpErrorHandling(response: res, context: context, onSuccess: (){
        onSuccess();
      });
    }catch(error){
      showSnackbar(context, error.toString());
    }
  }
}