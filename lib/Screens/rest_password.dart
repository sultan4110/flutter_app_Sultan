import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/signin.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/widget/widget.dart';

class RestPassword extends StatefulWidget {
  const RestPassword({Key? key}) : super(key: key);

  @override
  _RestPasswordState createState() => _RestPasswordState();
}

class _RestPasswordState extends State<RestPassword> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  AuthMethods authMethods = new AuthMethods();

  TextEditingController emailTextEditingController = new TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawerScrimColor: Color(0xff145C9E),
        appBar: AppBar(),
        body: Center(
            child: SingleChildScrollView(
              child: Column(
          children: <Widget>[
              SizedBox(height: 80),
              Image.asset("lib/assets/icons/lock_outlined.png", height: 100),
              SizedBox(
                height: 35,
              ),
              Text(
                "Enter your email",
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 50, right: 50, top: 8),
                child: Text(
                  "We are going to send you a link to reset your password there.",
                  style: TextStyle(color: Colors.white70, fontSize: 18),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(
                height: 80,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Form(
                  key: formKey,
                  child: TextFormField(
                     validator: (val) => RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(val!) ? null : "Please provide a valid email",
                            controller: emailTextEditingController,
                    decoration: updatedTextFieldInputDecoration(
                        "Email", Icons.email_outlined),
                  ),
                ),
              ),
              SizedBox(
                height: 100,
              ),
              GestureDetector(
                onTap: () {

                  authMethods.resetPassword(emailTextEditingController.text);
                  Navigator.push( context, MaterialPageRoute(builder: (context) => SignIn()));


                },
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 11.0, right: 11, bottom: 15),
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    // Fix size latter...
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                          const Color(0xff007EF4),
                          const Color(0xff2A75BC)
                        ]),
                        borderRadius: BorderRadius.circular(30)),

                    child: Text(
                      "Reset Password",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Text(
                "Having a problem? Contact support ",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),
          ],
        ),
            )));
  }
}
