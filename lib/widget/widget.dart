import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(title: Container()
      //Image.asset("assets/imagess/logo.png", height: 50) //logo image...

      );
}

//modularization in programing

InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
        color: Colors.white54,
      ),
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
}

TextStyle simpleTextStyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 16,
  );
}

TextStyle mediumTextStyle() {
  return TextStyle(
    color: Colors.white,
    fontSize: 17,
  );

  Container customButton(BuildContext context, buttonText, Color buttonColor) {
    alignment:
    Alignment.center;
    width:
    MediaQuery.of(context).size.width;
    padding:
    EdgeInsets.symmetric(vertical: 15);
    // Fix size latter...
    decoration:
    BoxDecoration(color: Colors.red, borderRadius: BorderRadius.circular(30));

    child:
    Text(
      buttonText,
      style: TextStyle(
        color: buttonColor,
        fontSize: 17,
      ),
    );
  }
}
