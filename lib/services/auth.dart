import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:crypt/crypt.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
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
    } catch (e) {
      print(e.toString());
    }
  }

  Future signUpwithEmailAndPasword(String email, String password) async {
    UserCredential userCredential = await _auth
        .createUserWithEmailAndPassword(email: email, password: password);
    User user = userCredential.user!;

    try {
      await user.sendEmailVerification();
      return user.uid;
    } catch (e) {



    }
  }








  Future resetPassword(String email) async {
    try {
      return await _auth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  }

  Future signOut() async {
    try {
      return await _auth.signOut();
    } catch (e) {
      print(e.toString());
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
