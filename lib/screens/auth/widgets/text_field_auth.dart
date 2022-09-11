import 'package:flutter/material.dart';
class TextFieldAuth extends StatelessWidget {


  final TextEditingController controller;
  final String HintText;
  final Icon icon;
  final TextInputType textInputType;
  final bool obscureText;
  TextFieldAuth({
    required this.controller,
    required this.HintText,
  required this.icon,
    required this.textInputType,
    required this.obscureText,
    });

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType:textInputType,
      controller: controller,
      obscureText: obscureText,
      obscuringCharacter: '*',
      decoration: InputDecoration(
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        hintText: HintText,
        prefixIcon:icon,
        labelStyle: TextStyle(
          fontSize: 20,
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 1,
            color: Colors.blue,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
