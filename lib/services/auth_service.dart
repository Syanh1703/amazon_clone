import 'dart:convert';

import 'package:amazon_clone/constants/error_handling.dart';
import 'package:amazon_clone/constants/global_var.dart';
import 'package:amazon_clone/constants/utils.dart';
import 'package:amazon_clone/models/user_model.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/screens/home_screen.dart';
import 'package:amazon_clone/widgets/bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService{
  //Sign up the user
  void signUpUser({
    required String email,
    required String pass,
    required String userName,
    required BuildContext context,
}) async {
    try{
      //28_07: Create a user model
      UserModel user = UserModel(
          id: '',
          name: userName,
          email: email,
          pass: pass,
          address: '',
          type: '',
          token: '',
          cart: []);

      //Request the API
      final http.Response response = await http.post(Uri.parse('$uri/api/signup'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
      );
      print(response.body);

      //error handling
      httpErrorHandling(response: response, context: context, onSuccess: (){
        showSnackbar(context, 'Account is created');
      });
    }catch(error){
      print(error.toString());
      showSnackbar(context, error.toString());
    }
  }

  //Sign in the user
  void sigInUser({
    required String email,
    required String pass,
    required BuildContext ctx,
}) async {
    try{
      http.Response res = await http.post(Uri.parse('$uri/api/signin'),
          body: jsonEncode({
            'email': email,
            'pass': pass,
          }),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );

      print('res Sign In body: ${res.body}');
      httpErrorHandling(response: res, context: ctx, onSuccess: () async {
        //Use shared Preference to save data on local
        SharedPreferences prefs = await SharedPreferences.getInstance();
        Provider.of<UserProvider>(ctx, listen: false).setUser(res.body);
        await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
        Navigator.pushNamedAndRemoveUntil(ctx, BottomBar.bottomBarRouteName, (route) => false);
      });
    }catch(error){
      showSnackbar(ctx, error.toString());
    }
  }

  //Get user data
  void getUserData(BuildContext context) async {
    try{
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if(token == null){
        prefs.setString('x-auth-token', '');
      }

      //Request API
      final tokenRes = await http.post(Uri.parse('$uri/validToken'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-auth-token': token!,
        },
      );

      var response = jsonDecode(tokenRes.body);

      if(response == true){
        //Actually get the user data
        http.Response userResponse = await http.get(Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
            'x-auth-token': token,
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userResponse.body);

      }
    }catch(error)
    {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(error.toString())));
    }
}
}