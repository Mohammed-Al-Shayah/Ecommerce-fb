import 'package:flutter/material.dart';

class ElevatedButtonSocial extends StatelessWidget {
  final String text;
  final String imageUrl;
  final Function function;
      ElevatedButtonSocial({
      required this.text,
        required this.imageUrl,
        required this.function,
  });
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      // important
      onPressed: (){
       function();
      },
      style: ElevatedButton.styleFrom(
        minimumSize: Size(double.infinity, 50),
        primary: Colors.grey.shade200,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      child: Row(
        children: [
          Padding(
            padding: EdgeInsetsDirectional.all(10,),

            child:  Container(
              width: 40,
              height: 40,
              child: Image.asset(
                imageUrl,
              ),
            ),
          ),
          SizedBox(width: 10,),
          Text(
            text,
            style: TextStyle(
              fontSize: 20,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
