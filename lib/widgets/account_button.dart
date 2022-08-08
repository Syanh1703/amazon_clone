import 'package:flutter/material.dart';

class AccountButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTapButton;

  AccountButton({
    required this.buttonText,
    required this.onTapButton});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 40,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.white,
            width: 0.0,
          ),
          borderRadius: BorderRadius.circular(50),
          color: Colors.white
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: 10,
        ),
        child: OutlinedButton(
          style: OutlinedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50)
            ),
            primary: Colors.black.withOpacity(0.8),
          ),
          onPressed: onTapButton,
          child: Text(buttonText, style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.normal,
            fontSize: 16
          ),
          ),
        )
      ),
    );
  }
}
