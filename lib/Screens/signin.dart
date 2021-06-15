import 'package:flutter/material.dart';
import 'package:flutter_app/widget/widget.dart';

class SignIn extends StatefulWidget  {
  const SignIn({Key? key}) : super(key: key);
  @override

  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appBarMain(context),


    );
  }
}
