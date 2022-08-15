
import 'package:amazon_clone/constants/global_var.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:amazon_clone/widgets/orders.dart';
import 'package:amazon_clone/widgets/top_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class AccountScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    return Scaffold(
      appBar: GlobalVars.screenCommon(''),
      body: Column(
        children: <Widget>[
          Container(
            decoration: const BoxDecoration(
              gradient: GlobalVars.appBarGradient,
            ),
            padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
            child: Row(
              children: [
                RichText(
                    text: TextSpan(
                      text: 'Hello, ',
                      style: const TextStyle(
                        fontSize: 22,
                        color: Colors.black
                      ),
                      children: [
                        TextSpan(
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.w600,
                            color: Colors.black
                          ),
                          text: user.name
                        ),
                      ],
                    ),
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          TopButton(),
          const SizedBox(height: 20),
          const Orders(),
        ],
      ),
    );
  }
}

