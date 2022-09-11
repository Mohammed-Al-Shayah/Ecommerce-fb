import 'package:flutter/material.dart';
class ListTileCon extends StatelessWidget {

  final String text;
  final Icon leadding;
  final Icon trealing;
  ListTileCon({
    required this.text,
    required this.leadding,
    required this.trealing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.5),
            spreadRadius: 4,
            blurRadius: 7,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
        color: Colors.white,
      ),
      child: Center(
        child: ListTile(
          leading:leadding,
          title: Text(
            text,
            style: TextStyle(
                fontSize: 20,
                color: Colors.black,
                fontWeight: FontWeight.bold),
          ),
          trailing:trealing,
        ),
      ),
    );
  }
}
