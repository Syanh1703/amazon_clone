import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String buttonText;
  final VoidCallback onTap;
  final Color? color;
  final Color? textColor;
  CustomButton({
    required this.buttonText,
    required this.onTap,
    this.color,
    this.textColor});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTap,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 50),
        primary: color,
        onPrimary: textColor
      ),
        child: Text(buttonText),
    );
  }
}
