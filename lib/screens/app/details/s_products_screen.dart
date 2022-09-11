import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fb/screens/app/new_product.dart';
import 'package:ecommerce_fb/utils/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../../provider/cart.dart';
import '../../../provider/cart1.dart';
import '../../../widgets/slider_top_app.dart';

class SProductsScreen extends StatefulWidget {
  final String productID;

  const SProductsScreen({required this.productID});

  @override
  State<SProductsScreen> createState() => _SProductsScreen();
}

class _SProductsScreen extends State<SProductsScreen>with Helpers{
  bool _isLoading = false;
  String imageUrl = '';
  String text = '';
  String price = '';
  String newPrice = '';
  String description='';


  void initState() {
    // TODO: implement initState
    super.initState();
    getCategoryDetail();
  }

  void getCategoryDetail() async {
    _isLoading = true;
    try {
      final DocumentSnapshot sProductsDoc = //widget.userId
      await FirebaseFirestore.instance
          .collection('SpecialProducts')
          .doc(widget.productID)
          .get();
      if (sProductsDoc == null) {
        return;
      } else {
        setState(() {
          imageUrl = sProductsDoc.get('imageUrl');
          text = sProductsDoc.get('name');
          price = sProductsDoc.get('price');
          newPrice =sProductsDoc.get('newPrice');
          description = sProductsDoc.get('description');
        });
      }
    } catch (e) {
      showSnackBar(context: context, message: 'No Data',error: true);
    }finally{
      _isLoading=false;
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart1 = Provider.of<Cart1>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body:_isLoading?
      Center(
        child:CircularProgressIndicator(
          color: Colors.black12,
          backgroundColor: Colors.grey,
          strokeWidth: 3,
        ),
      ): ListView(
        children: [
          Stack(
            children: [
              _isLoading?CircularProgressIndicator():
              Container(
                width: double.infinity,
                height: 300,
                color: Colors.white,
                child:Image.network('${imageUrl}',fit: BoxFit.cover,),
                // clipBehavior: Clip.antiAlias,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10, right: 20, top: 30),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: (){
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return NewProducts();
                              },
                            ),
                          );
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 30,
                          color: Colors.black,
                        )),
                    Spacer(),
                    Row(
                      children: [
                        Text(
                          '4,5',
                          style: TextStyle(fontSize: 17, color: Colors.black,fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 3,
                        ),
                        Icon(
                          Icons.star,
                          color: Colors.amber.shade900,
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            width: double.infinity,
            // height: 400,
            // color: Colors.green,
            child: Align(
              alignment: AlignmentDirectional.topStart,
              child: Column(
                children: [
                  Row(
                    children: [
                      Align(
                        alignment: AlignmentDirectional.topStart,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20, top: 20),
                          child: Text(
                            '${text}',
                            style: TextStyle(
                              fontSize: 25,
                              color: Colors.black,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Padding(
                        padding:
                        const EdgeInsets.only(right: 30, top: 20),
                        child:Column(
                          children: [
                            Text(
                              '${price} \$',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.red,
                                fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.lineThrough,
                              ),
                            ),
                            Text(
                              '${newPrice} \$',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.green,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(top: 20, left: 30),
                        child: Container(
                          height: 50,
                          width: 100,
                          decoration: BoxDecoration(
                            color: Colors.red.withOpacity(0.2),
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              bottomLeft: Radius.circular(20),
                            ),
                          ),
                          child: IconButton(
                            onPressed: () {
                              ;
                            },
                            icon:Icon(
                              Icons.favorite,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  Padding(
                    padding: EdgeInsets.only(left: 15, right: 5, top: 20),
                    child: Container(
                        height: 40,
                        width: double.infinity,
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: [
                              slider_top_app(
                                text: 'Food',
                                color: Colors.green.withOpacity(0.3),
                              ),
                              slider_top_app(
                                text: 'Cat',
                                color: Colors.redAccent.withOpacity(0.3),
                              ),
                              slider_top_app(
                                text: 'Pro',
                                color: Colors.cyanAccent.withOpacity(0.1),

                              ),
                              slider_top_app(
                                text: 'Fave',
                                color: Colors.blueGrey.withOpacity(0.3),

                              ),
                            ],
                          ),
                        )),
                  ),


                  Padding(
                    padding: const EdgeInsets.only(left: 20,top: 20,right: 20),
                    child: Container(
                      width: double.infinity,
                      height: 150,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 15,right: 15),
                              child: Align(
                                alignment: AlignmentDirectional.topStart,
                                child: Text(
                                  '$description',
                                  maxLines: 5,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(

                                    fontSize: 20,
                                    color: Colors.black,
                                    fontWeight: FontWeight.w400,
                                  ),

                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 30,bottom: 20),
                    child: ElevatedButton(
                      onPressed: (){

                        if(true){
                          cart1.addItem(
                            widget.productID,
                          );
                          showSnackBar(context: context, message: 'Product add successfully',error: false);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.blue.withOpacity(0.6),
                        minimumSize: Size(30, 50),
                        fixedSize: Size(300, 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      child: Text(
                        'Add to Cart',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
