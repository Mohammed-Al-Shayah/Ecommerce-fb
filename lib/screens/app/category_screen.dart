import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fb/controller/fb_controllers/fb_firestore_controller.dart';
import 'package:ecommerce_fb/screens/app/details/category_details_screen.dart';
import 'package:ecommerce_fb/utils/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/cart.dart';
class CategoryScreen extends StatefulWidget {

 FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final String proID;
  CategoryScreen({
  required this.proID,
});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen>with Helpers {
  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('Category Screen',
        style: TextStyle(
          color: Colors.black,
          fontSize: 28,
        ),
        ),
        leading: IconButton(
          onPressed:(){
            Navigator.pushReplacementNamed(context, '/main_screen');
          },
          icon: Icon(
            Icons.arrow_back,
            color: Colors.black,
            size: 30,
          ),
        ),
      ),
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder<QuerySnapshot>(
          stream: FbFireStoreController().getProducts(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasData) {
              List<QueryDocumentSnapshot> pro = snapshot.data!.docs;
              return SizedBox(
                child:GestureDetector(
                  child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                          maxCrossAxisExtent: 200,
                          childAspectRatio: 3 / 3.5,
                          crossAxisSpacing: 15,
                          mainAxisSpacing: 15),
                      itemCount: (snapshot.data!).docs.length,
                      itemBuilder: (BuildContext ctx, index) {
                        return Container(
                          // alignment: Alignment.center,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(0, 3), // changes position of shadow
                                ),
                              ],
                              borderRadius: BorderRadius.circular(20)),

                          // clipBehavior: Clip.antiAlias,
                          child:  Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(context, MaterialPageRoute(
                                    builder:(context){
                                      return DetailsScreen(
                                         productID:snapshot.data!.docs[index]['productID'],
                                      );
                                    },));
                                },
                                child: Container(
                                  width: double.infinity,
                                  height:157,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(18),
                                      topRight:Radius.circular(18),
                                    ),
                                  ),
                                  child:Image.network(
                                    '${pro[index].get('imageUrl')}',
                                    fit: BoxFit.cover,
                                  ),
                                  clipBehavior: Clip.antiAlias,
                                ),
                              ),
                              Spacer(),
                              Container(
                                width: double.infinity,
                                height:50,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(18),
                                    bottomRight:Radius.circular(18),
                                  ),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(left:20,top: 5),
                                  child: Row(
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(top:3),
                                        child: Column(
                                          children: [
                                            Text('${pro[index].get('name')}'),
                                            SizedBox(height: 6,),
                                            Text('${pro[index].get('price')} \$'),

                                          ],
                                        ),
                                      ),
                                      SizedBox(width: 20,),

                                      ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          // maximumSize: Size(2,2),
                                          minimumSize: Size(1,2),
                                          maximumSize: Size(50, 50),
                                          primary:Colors.grey,
                                        ),
                                        onPressed: (){

                                          if(true){
                                            cart.addItem(
                                                snapshot.data!.docs[index]['productID']
                                            );
                                            showSnackBar(context: context, message: 'Product add successfully',error: false);
                                          }
                                          },
                                        child:Icon(
                                          Icons.add,
                                        ),
                                      )

                                    ],
                                  ),
                                ),
                                clipBehavior: Clip.antiAlias,
                              ),
                            ],),



                        );

                      }
                  ),
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.warning,
                      size: 80,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      'No Category',
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              );
            }

            return Text('');
          }),
              
    ),
    
    );
  }
}