import 'package:flutter/material.dart';
import 'package:classchronicalapp/color.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final Icon suffixicon;
  final TextInputType inputType;
  final String validation_text;
  final int value_email;
  const CustomTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.suffixicon,
    this.inputType = TextInputType.text,
    this.validation_text = "",
    this.value_email = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: inputType,
      controller: controller,
      decoration: InputDecoration(
          border: OutlineInputBorder(
            borderSide: BorderSide(
              color: themegreycolor,
            ),
            borderRadius: BorderRadius.circular(8),
          ),
          hintText: hintText,
          suffixIcon: suffixicon,
          hintStyle: TextStyle(color: Colors.grey, fontSize: 18)),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "${validation_text}";
        }
        if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]").hasMatch(value) &&
            value_email == 1) {
          return ("Please Enter a valid email");
        }
      },
    );
  }
}
