import 'package:amazon_clone/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButton extends StatefulWidget {
  const TopButton({Key? key}) : super(key: key);

  @override
  State<TopButton> createState() => _TopButtonState();
}

class _TopButtonState extends State<TopButton> {
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
            AccountButton(buttonText: 'Log Out', onTapButton: (){

            }),
            AccountButton(buttonText: 'Your wish list', onTapButton: (){

            })
          ],
        )
      ],
    );
  }
}
