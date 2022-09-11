import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fb/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/cart.dart';
import '../screens/app/cart.dart';

class CartPdt extends StatelessWidget with Helpers {
  final String text;
  final String price;
  final String imageUrl;
  final String id;

  CartPdt({
    required this.text,
    required this.price,
    required this.imageUrl,
    required this.id,
  });

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Column(
      children:[
        Padding(
          padding: const EdgeInsets.only(top: 10, bottom: 3),
          child: InkWell(
            child: Container(
              height: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.grey, width: 2),
              ),
              child: Center(
                child: ListTile(
                  leading: Container(
                    width: 100,
                    height: 100,
                    child: Image.network(imageUrl),
                  ),
                  title: Text(
                    text,
                    style: TextStyle(fontSize: 23, color: Colors.black),
                  ),
                  subtitle: Text(
                    '$price \$',
                    style: TextStyle(fontSize: 20, color: Colors.green),
                  ),
                  trailing: IconButton(
                    onPressed: () {
                      if (true) {
                        cart.removeItem(id);
                        // showSnackBar(context: context, message: 'Deleted successfully',error: false);
                      }
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Divider(
          color: Colors.grey,
        ),
      ],
    );
  }
}
