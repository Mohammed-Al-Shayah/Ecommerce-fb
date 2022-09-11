import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fb/screens/auth/widgets/elevated_button_auth.dart';
import 'package:ecommerce_fb/screens/auth/widgets/text_field_auth.dart';
import 'package:ecommerce_fb/utils/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<RegisterScreen> with Helpers {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  late TextEditingController _emailEditingController;
  late TextEditingController _passwordEditingController;
  late TextEditingController _fullNameController;
  late TextEditingController _mobilePhoneController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
    _fullNameController = TextEditingController();
    _mobilePhoneController = TextEditingController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _emailEditingController.dispose();
    _passwordEditingController.dispose();
    _fullNameController.dispose();
    _mobilePhoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          '',
          style: TextStyle(
            color: Colors.black,
            fontSize: 27,
          ),
        ),
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login_screen');
            },
            icon: Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 27,
            )),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: ListView(
          children: [
            Text(
              'Create account',
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              'Enter below data',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 20,
            ),
            TextFieldAuth(
              controller: _fullNameController,
              HintText: 'Full name',
              icon: Icon(Icons.person),
              textInputType: TextInputType.name,
              obscureText: false,
            ),
            SizedBox(
              height: 10,
            ),
            TextFieldAuth(
              controller: _emailEditingController,
              HintText: 'Email',
              icon: Icon(Icons.email),
              textInputType: TextInputType.emailAddress,
              obscureText: false,
            ),
            SizedBox(
              height: 10,
            ),
            TextFieldAuth(
              controller: _passwordEditingController,
              HintText: 'Password',
              icon: Icon(Icons.lock),
              textInputType: TextInputType.visiblePassword,
              obscureText: true,
            ),
            SizedBox(
              height: 12,
            ),
            SizedBox(
              height: 12,
            ),
            TextFieldAuth(
              controller: _mobilePhoneController,
              HintText: 'Phone number',
              icon: Icon(Icons.call),
              textInputType: TextInputType.phone,
              obscureText: false,
            ),
            SizedBox(
              height: 12,
            ),

            ElevatedButtonAuth(
              text: 'Register',
              function: () async => await performRegister(),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> performRegister() async {
    if (checkData()) {
      await createAccount(
        context: context,
        email: _emailEditingController.text,
        password: _passwordEditingController.text,
        fullName: _fullNameController.text,
        phoneNumber: _mobilePhoneController.text,
      );
    }
  }

  bool checkData() {
    if (_emailEditingController.text.isNotEmpty &&
        _passwordEditingController.text.isNotEmpty &&
        _fullNameController.text.isNotEmpty &&
        _mobilePhoneController.text.isNotEmpty) {
      Navigator.pushReplacementNamed(context, '/login_screen');
      return true;
    }
    showSnackBar(context: context, message: 'Enter required data', error: true);
    return false;
  }

  Future<bool> createAccount({
    required BuildContext context,
    required String email,
    required String password,
    required String fullName,
    required String phoneNumber,
  }) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      final User? user = _firebaseAuth.currentUser;
      final uid = user!.uid;
      FirebaseFirestore.instance.collection('users').doc(uid).set(
        {
          'id': uid,
          'email': _emailEditingController.text,
          'createAt': Timestamp.now(),
          'fullName': _fullNameController.text,
          'phoneNumber': _mobilePhoneController.text,
        },
      );

      userCredential.user?.sendEmailVerification();
      return true;
    } on FirebaseAuthException catch (e) {
      _controlException(context, e);
    } catch (e) {
      //
    }
    return false;
  }

  void _controlException(
      BuildContext context, FirebaseAuthException exception) {
    showSnackBar(
        context: context,
        message: exception.message ?? 'ERROR !!',
        error: true);
    switch (exception.code) {
      case 'invalid-email':
        break;
      case 'user-disabled':
        break;
      case 'user-not-found':
        break;
      case 'wrong-password':
        break;
    }
  }
}
