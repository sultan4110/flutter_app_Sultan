import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/signin.dart';
import 'package:flutter_app/widget/widget.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: appBarMain(context),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(
                height: 150,
              ), // can do it in another way

              Icon(
                Icons.build_circle_outlined,
                color: Colors.white70,
                size: 120,
              ),
              SizedBox(
                height: 20,
              ), // can do it in another way

              Text(
                "Under Construction",
                style: TextStyle(color: Colors.white70, fontSize: 25),
              ),

              SizedBox(
                height: 250,
              ), // can do it in another way

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
            ],
          ),
        ));
  }
}
