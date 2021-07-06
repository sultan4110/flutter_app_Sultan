import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/signin.dart';

class RootPageController extends StatefulWidget {
  const RootPageController({Key? key}) : super(key: key);

  @override
  _RootPageControllerState createState() => _RootPageControllerState();
}

class _RootPageControllerState extends State<RootPageController> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;
  late Timer timer;

  @override
  void initState() {
    user = _auth.currentUser!;
    user.sendEmailVerification();
    timer = Timer.periodic(Duration(seconds: 5), (timer) {

       checkEmailVerified();
    });

    super.initState();
  }

  void disposer() {
    timer.cancel();
    super.dispose();
  }

  Future<void> checkEmailVerified() async {
    user = _auth.currentUser!;
    await user.reload();
    if (user.emailVerified) {
      timer.cancel();
      Navigator.push(context, MaterialPageRoute(builder: (context) => SignIn()));

      print("verified");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
