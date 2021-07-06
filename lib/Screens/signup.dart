import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/signin.dart';
import 'package:flutter_app/helper/rootpage_comtroller.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/services/database.dart';
import 'package:flutter_app/widget/widget.dart';

import 'home.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
  final formKey = GlobalKey<FormState>();
  TextEditingController nameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController =
      new TextEditingController();
  TextEditingController passwordTextEditingController =
      new TextEditingController();
  TextEditingController confirmPasswordTextEditingController =
      new TextEditingController();

  signMeUp() {
    if (formKey.currentState!.validate()) {
      authMethods
          .signUpwithEmailAndPasword(emailTextEditingController.text,
              passwordTextEditingController.text).then((val) async {
        if (val != null) {
          Map<String, String> userDataMap = {
            "userName": nameTextEditingController.text,
            "userEmail": emailTextEditingController.text,
            "userPassword":
                authMethods.encryptPassword(passwordTextEditingController.text)
          };
          databaseMethods.uploadUserInfo(userDataMap);

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home()));
        }

        return null;
      }); //must comes after uploadUserInfo

    }
  }

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
                  Form(
                    key: formKey,
                    autovalidateMode:AutovalidateMode.onUserInteraction ,
                    child: Column(
                      children: [
                        TextFormField(
                          validator: (val) => val!.isEmpty || val.length < 4 ? "Required: must be longer than 3 letters " : null,
                          controller: nameTextEditingController,
                          decoration: textFieldInputDecoration("User Name"),
                          style: simpleTextStyle(),
                        ),
                        TextFormField(
                          // validator: (val) => RegExp(r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$').hasMatch(val!) ? null : "Please provide a valid email",
                          controller: emailTextEditingController,
                          decoration: textFieldInputDecoration("Email"),
                          style: simpleTextStyle(),
                        ),
                        TextFormField(
                        //  validator: (val) => val!.length > 6 && val.contains(RegExp(r'[A-Z]')) && val.contains(RegExp(r'[a-z]')) && val.contains(RegExp(r'[0-9]')) && val.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))? null : "Please provide a valid password ex:@Least8Letters",
                          obscureText: true,
                          controller: passwordTextEditingController,
                          decoration: textFieldInputDecoration("Password"),
                          style: simpleTextStyle(),
                        ),
                        TextFormField(
                          controller: confirmPasswordTextEditingController,
                         // validator: (val) => val!.isEmpty || val != passwordTextEditingController.text ? "password does not match" : null,
                          obscureText: true,
                          decoration:
                              textFieldInputDecoration("Confirm password"),
                          style: simpleTextStyle(),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 8,
                  ), // can do it in another way

                  SizedBox(
                    height: 40,
                  ),
                  GestureDetector(
                    onTap: () {
                      signMeUp();
                    },
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
                        "Sign up",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 14,
                  ),

                  GestureDetector(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => SignIn()));
                    },
                    child: Container(
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
