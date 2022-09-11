import 'package:flutter/material.dart';

mixin Helpers {
  void showSnackBar(
      {required BuildContext context,
      required String message,
      bool error = false}){
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        duration: Duration(milliseconds: 400),
        content: Text(message),
        backgroundColor: error?Colors.red:Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
