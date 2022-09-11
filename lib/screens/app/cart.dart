import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fb/provider/cart1.dart';
import 'package:ecommerce_fb/provider/cart2.dart';
import 'package:ecommerce_fb/utils/helpers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../controller/fb_controllers/fb_firestore_controller.dart';
import '../../provider/cart.dart';
import '../../widgets/cart_item.dart';
import '../buy_screen.dart';
class NotificationScreen extends StatefulWidget {
  final String productID;

  const NotificationScreen({required this.productID});
  @override
  State<NotificationScreen> createState() => _NotfecationScreenState();
}



class _NotfecationScreenState extends State<NotificationScreen>with
    Helpers,
    SingleTickerProviderStateMixin
{
  late TabController _tabController;
  int _indexTab = 0;
  String id ='';
  String productId='';
  double price = 0;
  int quantity =0;
  String name='';
  String imageUrl ='';
  bool _isLoading =true;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

  }
  @override
  void dispose() {
    // TODO: implement dispose
    _tabController.dispose();
    super.dispose();
  }

  void getCategoryInCart() async {
    try {
      _isLoading = true;
      final DocumentSnapshot ProDoc = //widget.userId
      await FirebaseFirestore.instance
          .collection('products')
          .doc(widget.productID)
          .get();
      if (ProDoc == null) {
        return;
      }
      else {
        setState(() {
          name = ProDoc.get('name');
          price= ProDoc.get('price');
          imageUrl= ProDoc.get('imageUrl');
          id= ProDoc.get('productID');
        });
      }
    } catch (e) {
      showSnackBar(context: context, message: 'No Data',error: true);
    }finally{
      _isLoading=false;
    }
  }
  void getSProductsInCart() async {
    try {
      _isLoading = true;
      final DocumentSnapshot SProDoc = //widget.userId
      await FirebaseFirestore.instance
          .collection('SpecialProducts')
          .doc(widget.productID)
          .get();
      if (SProDoc == null) {
        return;
      }
      else {
        setState(() {
          name = SProDoc.get('name');
          price= SProDoc.get('price');
          imageUrl= SProDoc.get('imageUrl');
          id= SProDoc.get('productID');
        });
      }
    } catch (e) {
      showSnackBar(context: context, message: 'No Data',error: true);
    }finally{
      _isLoading=false;
    }
  }
  @override
  Widget build(BuildContext context){
    final cart = Provider.of<Cart>(context);
    final cart1 = Provider.of<Cart1>(context);
    final cart2 = Provider.of<Cart2>(context);
    return Scaffold(
     backgroundColor: Colors.white,
    appBar: AppBar(
      backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title:Text(
          'My Cart',
          style: TextStyle(
              fontSize: 25,
              color:Colors.black,
          ),
        ),
      ),
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TabBar(
              onTap: (value) {
                setState(() {
                  _indexTab = value;
                });
              },
              controller: _tabController,
              // unselectedLabelColor: Color.fromRGBO(169, 184, 189, 1),
              // labelColor:  Color.fromRGBO(50, 68, 82, 1),
              indicatorColor: Colors.blue,
              labelColor: Colors.black,
              unselectedLabelColor: Colors.grey,
              labelStyle: TextStyle(
                fontSize: 20,
              ),
              indicator: BoxDecoration(
                borderRadius: BorderRadius.circular(6),
                color: Color.fromRGBO(169, 184, 189, 1),
              ),
              // indicator:TabBarIndicatorSize.label,

              tabs: [
              Tab(

                text: 'Category',
              ),
                Tab(
                  text: 'S-Products',

                ),
                Tab(
                  text: 'Products',

                ),

              ],
            ),
          ),
          Row(
            children: [
              Spacer(),
              Padding(
                padding: const EdgeInsets.only(right: 20),
                child: TextButton(
                  onPressed:(){
                    cart.clear();
                    cart1.clear();
                    cart2.clear();
                  },
                  child: Text('Clear all',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.red,
                    fontWeight: FontWeight.bold,
                  ),
                  ),
                ),
              ),
            ],
          ),
          IndexedStack(
            index: _indexTab,
            children: [
              Container(
                child:SizedBox(
                  height: 570,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FbFireStoreController().getProducts(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasData){
                            return InkWell(
                              child: ListView.builder(
                                itemCount:cart.items.length,
                                itemBuilder: (BuildContext ctx, index)=> CartPdt(
                                  text:snapshot.data!.docs[index]['name'],
                                  price: snapshot.data!.docs[index]['price'],
                                  imageUrl:snapshot.data!.docs[index]['imageUrl'],
                                  id:snapshot.data!.docs[index]['productID'],
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
                        }),

                  ),
                ),
              ),
              Container(
              child:   SizedBox(
                height: 570,
                child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FbFireStoreController().getSpecialProducts(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasData){
                            return ListView.builder(
                              itemCount:cart1.items.length,
                              itemBuilder: (BuildContext ctx, index)=> CartPdt(
                                text:snapshot.data!.docs[index]['name'],
                                price: snapshot.data!.docs[index]['price'],
                                imageUrl:snapshot.data!.docs[index]['imageUrl'],
                                id:snapshot.data!.docs[index]['productID'],
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
                        }),

                  ),
              ),
              ),
              Container(
                child:   SizedBox(
                  height: 570,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: StreamBuilder<QuerySnapshot>(
                        stream: FbFireStoreController().getProducts1(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          } else if (snapshot.hasData){
                            return ListView.builder(
                              itemCount:cart2.items.length,
                              itemBuilder: (BuildContext ctx, index)=> CartPdt(
                                text:snapshot.data!.docs[index]['name'],
                                price: snapshot.data!.docs[index]['price'],
                                imageUrl:snapshot.data!.docs[index]['imageUrl'],
                                id:snapshot.data!.docs[index]['productID'],
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
                        }),

                  ),
                ),
              ),
            ],
          ),

        ],
      ),

    );
  }
}
