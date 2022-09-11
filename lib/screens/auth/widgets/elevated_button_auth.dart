import 'package:flutter/material.dart';

class ElevatedButtonAuth extends StatelessWidget {
  final String text;
  final Function function;

      ElevatedButtonAuth({
    required this.text,
        required this.function,

          });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        function();
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 25,
        ),
      ),
    );
  }
}
