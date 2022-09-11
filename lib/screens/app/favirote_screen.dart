import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/fb_controllers/fb_firestore_controller.dart';
import '../../provider/orders.dart';
class FaviroteScreen  extends StatefulWidget {
  const FaviroteScreen({Key? key}) : super(key: key);

  @override
  State<FaviroteScreen> createState() => _FaviroteScreenState();
}

class _FaviroteScreenState extends State<FaviroteScreen> {
  @override
  Widget build(BuildContext context) {
    bool _isSelected=false;

    final FavoriteProducts =Provider.of<FavProducts>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Favorite Screen',style: TextStyle(color: Colors.black,fontSize:27,),),
        centerTitle: true,
      ),
      body:SizedBox(
        height: 600,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<QuerySnapshot>(
              stream: FbFireStoreController().getProducts(),
              builder: (context, snapshot){
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (snapshot.hasData){
                  return ListView.builder(
                    itemCount:FavoriteProducts.favProduct.length,
                    itemBuilder: (BuildContext ctx, index){
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          height: 100,
                          decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.black,
                                width: 1,
                              ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Center(
                            child: ListTile(
                              leading:Container(
                                height: 100,
                                width: 100,
                                child: Image.network(snapshot.data!.docs[index]['imageUrl']),
                              ),
                              title: Text(snapshot.data!.docs[index]['name'],),
                              trailing: IconButton(
                                onPressed: (){

                                },
                                icon: Icon(Icons.favorite,color: Colors.red,),
                              ),
                            ),
                          ),
                        ),
                      );
                    }
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
    );
  }
}
