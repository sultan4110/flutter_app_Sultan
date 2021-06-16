import 'package:flutter/material.dart';
import 'package:flutter_app/widget/widget.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController nameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  TextEditingController
      confirmPasswordTextEditingControllerTextEditingController =
      new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(40),
        child: appBarMain(context),
      ),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          alignment: Alignment.bottomCenter,
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(
                    Icons.account_circle_outlined,
                    color: Colors.white70,
                    size: 120,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TextField(
                    controller: nameTextEditingController,
                    decoration: textFieldInputDecoration("Name"),
                    style: simpleTextStyle(),
                  ),
                  TextField(
                    controller: emailTextEditingController,
                    decoration: textFieldInputDecoration("Email"),
                    style: simpleTextStyle(),
                  ),
                  TextField(
                    controller: passwordTextEditingController,
                    decoration: textFieldInputDecoration("Password"),
                    style: simpleTextStyle(),
                  ),
                  TextField(
                    controller:
                        confirmPasswordTextEditingControllerTextEditingController,
                    decoration: textFieldInputDecoration("Confirm password"),
                    style: simpleTextStyle(),
                  ),
                  SizedBox(
                    height: 8,
                  ), // can do it in another way

                  SizedBox(
                    height: 40,
                  ),
                  Container(
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
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 14,
                  ),

                  Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 15),
                    // Fix size latter...
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30)),

                    child: Text(
                      "Back",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14,
                  ),
                  SizedBox(
                    height: 16,
                  ),

                  SizedBox(
                    height: 50,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
