import 'package:cloud_firestore/cloud_firestore.dart';

class FbFireStoreController{

  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot> getProducts1()async*{
  yield*  _firebaseFirestore.collection('products1').snapshots();
  }

  Stream<QuerySnapshot> getProducts()async*{
    yield*  _firebaseFirestore.collection('products').snapshots();
  }

  Stream<QuerySnapshot> getSpecialProducts()async*{
    yield*  _firebaseFirestore.collection('SpecialProducts').snapshots();
  }

}