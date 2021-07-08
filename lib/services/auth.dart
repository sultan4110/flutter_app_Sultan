import 'dart:async';
import 'dart:ui';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crypt/crypt.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  FlutterSecureStorage storage = new FlutterSecureStorage(); // initialize FlutterSecureStorage in order to get access to the device's secure storage
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      final User user = userCredential.user!;






      return user.uid;



    } on FirebaseAuthException catch  (e) {
      Fluttertoast.showToast(msg: e.message.toString(), gravity: ToastGravity.CENTER, timeInSecForIosWeb:2,);

    }
  }

  Future signUpwithEmailAndPasword(String email, String password) async {
    try {
    UserCredential userCredential = await _auth
        .createUserWithEmailAndPassword(email: email, password: password);
    User user = userCredential.user!;

      await user.sendEmailVerification();
      return user.uid;
    } on FirebaseAuthException catch  (e) {
      Fluttertoast.showToast(msg: e.message.toString(), gravity: ToastGravity.CENTER, timeInSecForIosWeb:2,);

    }
  }


  Future<UserCredential> signInWithFacebook() async {
    // Trigger the sign-in flow
    final LoginResult result = await FacebookAuth.instance.login();

    // Create a credential from the access token
    final OAuthCredential facebookAuthCredential =
    FacebookAuthProvider.credential(result.accessToken!.token);

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }


  Future<User?> signInWithGoogle() async {
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential = await _auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch  (e) {
        Fluttertoast.showToast(msg: e.message.toString(), gravity: ToastGravity.CENTER, timeInSecForIosWeb:2,);
      }
    }

    return user;
  }









  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch  (e) {
      Fluttertoast.showToast(msg: e.message.toString(), gravity: ToastGravity.CENTER, timeInSecForIosWeb:2,);
    }
  }

  Future signOut() async {
    try {
      await _googleSignIn.signOut();
      await _auth.signOut()  ;
    } on FirebaseAuthException catch  (e) {
      Fluttertoast.showToast(msg: e.message.toString(), gravity: ToastGravity.CENTER, timeInSecForIosWeb:2,);

    }
  }

  String encryptPassword(String password) {
    return Crypt.sha256(password)
        .toString(); // Crypt.sha256 which is a one-way hash function developed by the NSA
  }

  Future<bool> checkPassword(String uid, String password) async {
    String? storedHashedPassword = await storage.read(
        key: uid); // await for  value to return from secure storage
    return Future.value(
        Crypt(storedHashedPassword!).match(password)); // compare
  }
}
