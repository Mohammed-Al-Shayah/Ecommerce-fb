import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../controller/fb_controllers/fb_auth_controllers.dart';
import '../../widgets/list_tile_profile.dart';

class HomeScreen extends StatefulWidget {
  final String userId;

  const HomeScreen({required this.userId});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = false;
  String email ='';
  String fullName ='';
  String phoneNumber ='';
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    getUserData();
  }

  void getUserData() async {
    _isLoading = true;
    try {
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(widget.userId)
          .get();
      if (userDoc == null) {
        return;
      } else {
        setState(() {
          email = userDoc.get('email');
          fullName = userDoc.get('fullName');
          phoneNumber = userDoc.get('phoneNumber');
        });
        User? user = _firebaseAuth.currentUser;
        String uid = user!.uid;
      }
    } catch (e) {
      //
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Profile Screen',
          style: TextStyle(
            fontSize: 30,
            color: Colors.black,
          ),
        ),
         leading: IconButton(
           onPressed: ()=>
               Navigator.pushReplacementNamed(context, '/main_screen'),
           icon: Icon(
             Icons.arrow_back,
             color: Colors.black,
             size: 30,
           ),
         ),
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          SizedBox(
            height: 20,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: Colors.lightBlueAccent,
                  borderRadius: BorderRadius.circular(60),
                  border: Border.all(color: Colors.white70,width: 3),
                ),
                child: Image.network(
                  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR-3XIZuMnGZSM9c4c2huLkoHkKIA5BmMrKQsI1dpZR3sVFroorXKzhajLDONaANwxte4E&usqp=CAU',
                fit: BoxFit.cover,
                ),
                clipBehavior: Clip.antiAlias,

              ),
            SizedBox(height: 6,),
            InkWell(
              onTap: (){
                print('add image');
              },
              child: Text(
                'Add image',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                  fontStyle: FontStyle.italic,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            ],
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 15, left: 15, right: 15, bottom: 10),
            child: ListTileCon(
              text: '${fullName}',
              leadding: Icon(Icons.man,color: Colors.black,size: 28,),
              trealing: Icon(Icons.star,color: Colors.white,size: 28,),
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
            child: ListTileCon(
              text: '${email}',
              leadding: Icon(Icons.email,color: Colors.black,size: 28,),
              trealing: Icon(Icons.star,color: Colors.white,size: 28,),
            ),
          ),
          Padding(
            padding:
            const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
            child: ListTileCon(
              text: '+970- ${phoneNumber}',
              leadding: Icon(Icons.phone,color: Colors.black,size: 28,),
              trealing: Icon(Icons.star,color: Colors.amberAccent,size: 28,),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
            child: Container(
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

                  title: Text(
                    'Change your password',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold),
                  ),
                  trailing:IconButton(
                    onPressed:(){
                      Navigator.pushReplacementNamed(context, '/forget_password');
                    },
                   icon:Icon( Icons.arrow_forward_ios_sharp,
                    color: Colors.black,
                    size: 28,
                   ),
                  ),
                ),
              ),
            ),
          ),

         Padding(
        padding: const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 10),
        child: Container(
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

              title: Text(
                'LOGOUT ',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              trailing:
              IconButton(
                onPressed: () => showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                    title: const Text('Logout',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.w400,
                    ),
                    ),
                    content: const Text('Are you sure you want logout'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () => Navigator.pop(context, 'Cancel'),
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () async {
                          await FbAuthController().signOut();
                          Navigator.pushReplacementNamed(context, '/login_screen');
                        },
                        child: const Text('OK'),
                      ),
                    ],
                  ),
                ),
              icon:Icon(Icons.logout,color: Colors.black,size: 28,),),
            ),
          ),
        ),
      ),

        ],
      ),
    );
  }
}

