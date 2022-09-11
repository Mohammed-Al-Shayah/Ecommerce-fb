import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fb/controller/fb_controllers/fb_firestore_controller.dart';
import 'package:flutter/material.dart';

import 'details/products_details_screen.dart';

class ProductsScreen extends StatefulWidget {
  final String proID;
  ProductsScreen({
    required this.proID,
  });


  @override
  _ProductsScreenState createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text('Products',style: TextStyle(fontSize: 25,color: Colors.black),),
        centerTitle: true,
        leading: IconButton(icon: Icon(Icons.arrow_back),
        onPressed: (){
          Navigator.pushReplacementNamed(context,'/main_screen');
        },
        color: Colors.black,
        iconSize: 30,
        ),
      ),
      body:   
       Padding(
           padding: const EdgeInsets.only(left:10,top: 5,right: 10),
          
           child: StreamBuilder<QuerySnapshot>(
               stream: FbFireStoreController().getProducts1(),
               builder: (context,snapshot){
                 if (snapshot.connectionState == ConnectionState.waiting) {
                   return Center(
                     child: CircularProgressIndicator(),
                   );
                 }
                 else if(snapshot.hasData){
                   List <QueryDocumentSnapshot> pro =snapshot.data!.docs;
                   return
                     Container(
                   child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 200,
                  childAspectRatio: 3 / 4,
                  crossAxisSpacing: 5,
                  mainAxisSpacing: 5,
                ),
                       itemCount: pro.length,
                itemBuilder: (BuildContext ctx, index) {
                  return InkWell(
                    onTap: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(
                        builder:(context) {
                          return Products1DetailsScreen(
                            productID: snapshot.data!.docs[index]['productID'],
                          );
                        },));
                      // print('ffff');
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Stack(
                        children: [
                          Image(
                            width: double.infinity,
                            fit: BoxFit.cover,
                            height: double.infinity,

                            image: NetworkImage(
                               '${pro[index].get('imageUrl')}',

                            ),



                          ),
                          PositionedDirectional(
                            bottom: 0,
                            end: 0,
                            start: 0,
                            child: Container(
                              alignment: AlignmentDirectional.center,
                              color: Colors.black45,
                              height: 60,
                              child:Column(
                                children: [
                                  Text(
                                  '${pro[index].get('name')}',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                  '${pro[index].get('price')} \$',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 22,
                                  color: Colors.green,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }),
                     );
                 }
                     else{
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
               }
           ),
         ),

    );
  }
}