import 'package:ecommerce_fb/controller/fb_controllers/fb_auth_controllers.dart';
import 'package:ecommerce_fb/screens/auth/widgets/elevated_button_auth.dart';
import 'package:ecommerce_fb/screens/auth/widgets/elevated_button_social.dart';
import 'package:ecommerce_fb/screens/auth/widgets/text_field_auth.dart';
import 'package:ecommerce_fb/utils/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with Helpers {
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
    await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  late TextEditingController _emailEditingController;
  late TextEditingController _passwordEditingController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          '',
          style: TextStyle(
            color: Colors.black,
            fontSize: 27,
          ),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: ListView(
          children: [
            Text(
              'Welcome back',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'Enter email & password',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),

            SizedBox(
              height: 20,
            ),
            TextFieldAuth(
              controller: _emailEditingController,
              icon: Icon(Icons.email),
              HintText: 'Email',
              textInputType: TextInputType.emailAddress,
              obscureText: false,
            ),
            SizedBox(
              height: 10,
            ),
            TextFieldAuth(
              controller: _passwordEditingController,
              icon: Icon(Icons.lock),
              HintText: 'Password',
              textInputType: TextInputType.visiblePassword,
              obscureText: true,

            ),
            SizedBox(
              height: 12,
            ),
            ElevatedButtonAuth(
              text: 'LOGIN',
              function: () async => await performLogin(),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'don\'t have an account ?',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, '/register_screen');
                  },
                  child: Text(
                    ' Create account',
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () =>
                        Navigator.pushReplacementNamed(
                            context, '/forget_password'),
                    child: Text(
                      ' forget password !',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],),
            ),
            SizedBox(
              height: 6,
            ),
            Row(
              children: [
                Expanded(
                    flex: 3,
                    child: Divider(
                      color: Colors.grey,
                      height: 2,
                      thickness: 2,
                    )),
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Text(
                    'OR',
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                ),
                Expanded(
                    flex: 3,
                    child: Divider(
                      color: Colors.grey,
                      height: 2,
                      thickness: 2,
                    )),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButtonSocial(text: 'Sign in with Google',
                imageUrl: 'images/google1.png',
                function: () async=> await performLogin(),
            ),
            SizedBox(
              height: 15,
            ),
            ElevatedButtonSocial(text: 'Sign in with Facebook',
              imageUrl: 'images/facebook.jpg',
              function: () async=> await performLogin(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> performLogin() async {
    if (checkData()) {
      await login();
    }
  }

  bool checkData() {
    if (_emailEditingController.text.isNotEmpty &&
        _passwordEditingController.text.isNotEmpty) {
      return true;
    }
    return false;
  }

  Future<void> login() async {
    bool states = await FbAuthController().signIn(
        context: context,
        email: _emailEditingController.text,
        password: _passwordEditingController.text);
    if (states) {
      Navigator.pushReplacementNamed(context, '/main_screen');
    }
  }
}

