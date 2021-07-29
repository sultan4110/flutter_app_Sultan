import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_app/Screens/signin.dart';
import 'package:flutter_app/test.dart';
import 'Screens/home.dart';
import 'package:firebase_app_check/firebase_app_check.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //await FirebaseAppCheck.instance.activate(webRecaptchaSiteKey: 'recaptcha-v3-site-key');
  runApp(MyApp());
}

class MyApp extends StatelessWidget implements PreferredSizeWidget {
  // This widget is the root of your application.
  @override
  Size get preferredSize => const Size.fromHeight(100);

  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

      title: 'Flutter Login UI',
      theme: ThemeData(
        brightness: Brightness.dark,

        scaffoldBackgroundColor: Color(0xff1F1F1F),
        primaryColor: Color(0xff145C9E),
      ),
      home: SignIn(),
    );
  }
}