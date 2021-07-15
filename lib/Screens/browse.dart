import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/signin.dart';
import 'package:flutter_app/Screens/upload.dart';
import 'package:flutter_app/services/auth.dart';
import 'package:flutter_app/services/firebase_storage_methods.dart';
import 'package:flutter_app/widget/widget.dart';

class Browse extends StatefulWidget {
  const Browse({Key? key}) : super(key: key);

  @override
  _BrowseState createState() => _BrowseState();
}

class _BrowseState extends State<Browse> {
  late Future <List<FirebaseFile>> futureFiles;



  AuthMethods authMethods = new AuthMethods();

@override
  void initState() {

 futureFiles = FirebaseStorageMethods.listAll('files/');



  super.initState();
  }







  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(preferredSize: const Size.fromHeight(40),
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
                Icons.home,
                color: Colors.white70,
                size: 120,
              ),
              SizedBox(
                height: 20,
              ), // can do it in another way

              Text(
                "Welcome Home",
                style: TextStyle(color: Colors.white70, fontSize: 25),
              ),

              SizedBox(
                height: 100,
              ), // can do it in another way


              GestureDetector(
                onTap: () {
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
                    "Images",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,),

              GestureDetector(
                onTap: () {

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
                    " Videos",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 30,)
              ,
              GestureDetector(
                onTap: () {
                  authMethods.signOut();

                  Navigator.pushReplacement(context,
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
                    "Documents",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 70,
              ),
            ],
          ),
        ));
  }
}
