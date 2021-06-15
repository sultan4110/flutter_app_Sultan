
import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/signin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget implements PreferredSizeWidget {
  // This widget is the root of your application.
  @override
  Size get preferredSize => const Size.fromHeight(100);
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Login UI',
      debugShowCheckedModeBanner: false,
      home: SignIn(),
    );
  }
}