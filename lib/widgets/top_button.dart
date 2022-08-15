import 'package:amazon_clone/services/account_service.dart';
import 'package:amazon_clone/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButton extends StatelessWidget {


  TopButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            AccountButton(buttonText: 'Your orders', onTapButton: (){

            }),
            AccountButton(buttonText: 'Turn Seller', onTapButton: (){

            })
          ],
        ),
        const SizedBox(
          height: 16,
        ),
        Row(
          children: <Widget>[
            AccountButton(buttonText: 'Log Out', onTapButton: () => AccountService().logOut(context)),
            AccountButton(buttonText: 'Your wish list', onTapButton: (){

            })
          ],
        )
      ],
    );
  }
}
