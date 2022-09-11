import 'package:flutter/material.dart';

class slider_top_app extends StatelessWidget {
  // const slider_top_app({
  //   Key? key,
  // }) : super(key: key);
  final Color color;
  final String text;
  slider_top_app({

    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 7),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
        color:color,
        borderRadius: BorderRadius.circular(20),
        
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ),
        ),
    );
  }
}
