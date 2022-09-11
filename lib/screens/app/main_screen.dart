import 'package:ecommerce_fb/model/bn_screen.dart';
import 'package:ecommerce_fb/screens/app/app_screen.dart';
import 'package:ecommerce_fb/screens/app/cart.dart';
import 'package:ecommerce_fb/screens/app/personal_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'favirote_screen.dart';
class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late int _currentIndex = 0;
  final List<BnScreen> _bnScreen = <BnScreen>[
    const BnScreen(widget: AppScreen(), title: 'App'),
    const BnScreen(widget: FaviroteScreen(), title: 'Favorite'),
    const BnScreen(widget: PersonalScreen(), title: 'Personal'),
    const BnScreen(widget: NotificationScreen(productID: ''), title: 'notification'),
  ];
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
    final User? user =_firebaseAuth.currentUser;
    final uid =user!.uid;
    return Scaffold(
      backgroundColor: Colors.grey.shade300,

      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.0),
          topRight: Radius.circular(30.0),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          onTap: (int value) {
            setState(() {
              _currentIndex = value;
            });
          },
          currentIndex: _currentIndex,

          showSelectedLabels: false,
          showUnselectedLabels: false,
          unselectedItemColor: Colors.grey.shade600,
          iconSize: 30,
          selectedIconTheme: IconThemeData(color: Colors.blue.withOpacity(0.8)),
          items:[
            BottomNavigationBarItem(
              label: "Home",
              icon: Icon(Icons.home,),
            ),
            BottomNavigationBarItem(
              label: "information",
              icon: Icon(Icons.favorite),
            ),
            BottomNavigationBarItem(
              label: "Notification",
              icon: Icon(Icons.notifications),
            ),
            BottomNavigationBarItem(
              label: "Card",
              icon: Icon(Icons.card_travel_rounded),
            ),
          ],
        ),
      ),
      body: _bnScreen[_currentIndex].widget,
    );
  }


}
