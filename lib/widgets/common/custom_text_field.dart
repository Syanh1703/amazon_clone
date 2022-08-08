import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final int maxLines;
  final String feedbackString;
  CustomFormField(this.controller, this.hint, this.maxLines, this.feedbackString);


  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        hintText: hint,
        border: const OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.black38,
          ),
        ),
        enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black38,
        ),
        ),
      ),
      validator: (val){
        if(val == null || val.isEmpty){
          return feedbackString;
        }
        return null;
      },
      maxLines: maxLines,
    );
  }
}
