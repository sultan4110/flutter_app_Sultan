import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context){

  return AppBar(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))),
    title:Image.asset("assets/imagess/logo.png", height: 50)


  );
}
