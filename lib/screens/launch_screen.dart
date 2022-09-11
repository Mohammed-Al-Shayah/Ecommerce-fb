import 'dart:async';
import 'package:ecommerce_fb/controller/fb_controllers/fb_auth_controllers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
class LaunchScreen extends StatefulWidget {
  const LaunchScreen({Key? key}) : super(key: key);

  @override
  _LaunchScreenState createState() => _LaunchScreenState();
}

class _LaunchScreenState extends State<LaunchScreen> {

  late StreamSubscription stream;

  @override
  void initState(){
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 4),(){
      Navigator.pushReplacementNamed(context, '/login_screen');
      stream = FbAuthController().checkUserStates(({required bool loggedIn}) {
        String routeName =loggedIn ?'/app_screen':'/login_screen';
        Navigator.pushReplacementNamed(context, routeName);
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    stream.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:Container(
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin:AlignmentDirectional.topStart,
            end: AlignmentDirectional.bottomEnd,
            colors: [
              Colors.blueGrey,
              Colors.white54,
            ],
          ),
        ),
        child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Welcome To App',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
