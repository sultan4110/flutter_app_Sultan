import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/Utilities/Validator.dart';

Widget appBarMain(BuildContext context) {
  return AppBar(title: Container()
      //Image.asset("assets/imagess/logo.png", height: 50) //logo image...

      );
}

//modularization in programing


Future<Widget> buildUploadStatus(UploadTask task) async {
  return StreamBuilder<TaskSnapshot>(
  stream: task.snapshotEvents,
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      final snap = snapshot.data!;
      final progress = snap.bytesTransferred * 100 / snap.totalBytes;

      return Text(
        '$progress %',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      );
    } else {
      return Container();
    }
  },
);
}


InputDecoration textFieldInputDecoration(String hintText) {
  return InputDecoration(
      labelText: hintText,
      labelStyle: TextStyle(color: Colors.white54,),
      floatingLabelBehavior: FloatingLabelBehavior.auto,
      focusedBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
      enabledBorder:
          UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
}

InputDecoration updatedTextFieldInputDecoration(String hintText,IconData icon) {
  return InputDecoration(
    hintText: hintText,
    suffixIcon: Icon(icon, color: Color(0xff687089)),
    hintStyle: TextStyle(color: Color(0xff687089)),
    filled: true,
    fillColor: Color(0xffc6c6c6),
    focusedBorder: OutlineInputBorder(),
    enabledBorder: OutlineInputBorder(), // fix border size
  );
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
