import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/signin.dart';

import 'Screens/first.dart';
import 'Screens/signup.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget implements PreferredSizeWidget {
  // This widget is the root of your application.
  @override
  Size get preferredSize => const Size.fromHeight(100);

  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login UI',
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xff1F1F1F),
        primaryColor: Color(0xff145C9E),
      ),
      debugShowCheckedModeBanner: false,
      home: First(),
    );
  }
}