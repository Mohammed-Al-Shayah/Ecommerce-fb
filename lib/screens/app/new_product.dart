import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fb/controller/fb_controllers/fb_firestore_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'details/s_products_screen.dart';

class NewProducts extends StatefulWidget {
  // const NewProducts({ Key? key }) : super(key: key);

  @override
  _NewProductsState createState() => _NewProductsState();
}

class _NewProductsState extends State<NewProducts> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
         appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text('New Products',
        style: TextStyle(
          color: Colors.black,
          fontSize: 30,
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
      body:
       Padding(
           padding: const EdgeInsets.only(left:10,top: 20,right: 10,bottom: 10),         
           child: StreamBuilder<QuerySnapshot>(
               stream: FbFireStoreController().getSpecialProducts(),
               builder: (context,snapshot){
                 if (snapshot.connectionState == ConnectionState.waiting) {
                   return Center(
                     child: CircularProgressIndicator(),
                   );
                 }
                 else if(snapshot.hasData){
                   List <QueryDocumentSnapshot> prodref =snapshot.data!.docs;
                   return
                    ListView(
        children: [
          SizedBox(
            height: 660,
            child: ListView.builder(
           itemCount: prodref.length,
            itemBuilder:(context, index) {
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
             width: double.infinity,
             height: 200,
             decoration: BoxDecoration(
             borderRadius: BorderRadius.circular(20),
             ),
             child:  Stack(
               children: [
                  Image(
                            width: double.infinity,
                            fit: BoxFit.cover,
                            image: NetworkImage(
                               '${prodref[index].get('imageUrl')}'
                            ),

                          ),

                              PositionedDirectional(
                          bottom: 0,
                          end: 0,
                          start:0,
                          child: Container(
                            alignment: AlignmentDirectional.center,
                            color: Colors.black.withOpacity(0.3),
                            height: 60,
                            child:Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 10),
                                  child: Column(
                                    children: [
                                      Text(
                                        '${prodref[index].get('name')}',
                                        style: TextStyle(
                                          fontSize: 22,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.start,
                                      ),

                                      Text(
                                        'New Price :${prodref[index].get('newPrice')} \$',
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
                                Spacer(),
                                Container(
                                  height: 100,
                                  width: 60,
                                  child:IconButton(
                                    onPressed: (){
                                      Navigator.pushReplacement(context, MaterialPageRoute(
                                        builder:(context) {
                                          return SProductsScreen(productID:snapshot.data!.docs[index]['productID']);
                                        },));                                    },
                                    icon: Icon(
                                      Icons.arrow_forward_ios_sharp,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),


               ],
             ),
                        clipBehavior: Clip.antiAlias,
            ),
                ),
              ],
            );
          },),
          ),
        ],
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

               }
           ),
         ),
    );
    
  }


}