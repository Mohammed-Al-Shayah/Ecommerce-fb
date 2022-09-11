import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ecommerce_fb/utils/helpers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

typedef UserAuthStates = void Function({required bool loggedIn});

class FbAuthController with Helpers {
  // GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  Future<bool> signIn(
      {required BuildContext context,
      required String email,
      required String password}) async {
    try {
      UserCredential userCredential = await _firebaseAuth
          .signInWithEmailAndPassword(email: email, password: password);

      if (userCredential.user != null) {
        if (userCredential.user!.emailVerified) {
          return true;
        } else {
          await signOut();
          showSnackBar(
              context: context,
              message: 'Verify email to login into the app!',
              error: true);
          return false;
        }
      }
      return false;
    } on FirebaseAuthException catch (e) {
      _controlException(context, e);
    } catch (e) {
      //
    }
    return false;
  }
  //
  // Future<bool> createAccount(
  //     {required BuildContext context,
  //     required String email,
  //     required String password}) async {
  //   try {
  //     UserCredential userCredential = await _firebaseAuth
  //         .createUserWithEmailAndPassword(email: email, password: password);
  //      final User? user =  _firebaseAuth.currentUser;
  //      final uid= user!.uid;
  //
  //     userCredential.user?.sendEmailVerification();
  //     return true;
  //   } on FirebaseAuthException catch (e) {
  //     _controlException(context, e);
  //   } catch (e) {
  //     //
  //   }
  //   return false;
  // }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  bool loggedIn() => _firebaseAuth.currentUser != null;

  StreamSubscription<User?> checkUserStates(UserAuthStates userAuthStates) {
    return _firebaseAuth.authStateChanges().listen((event) {
      userAuthStates(loggedIn: event != null);
    });
  }

  Future<bool> resetPassword(
      {required String email, required BuildContext context}) async {
    await _firebaseAuth.sendPasswordResetEmail(email: email);
    return true;
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
