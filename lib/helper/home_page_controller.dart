import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Screens/subbrowse.dart';
import 'package:flutter_app/Screens/upload.dart';

class HomePageController extends StatefulWidget {
  const HomePageController({Key? key}) : super(key: key);

  @override
  _HomePageControllerState createState() => _HomePageControllerState();
}

class _HomePageControllerState extends State<HomePageController> {
  @override
   int pageIndex=0;
  List<Widget> pageList = <Widget>[
    SubBrowse(),
    Upload(),
  ];



  Widget build(BuildContext context) {
    return Scaffold(

body: pageList[pageIndex] ,

 bottomNavigationBar: BottomNavyBar(
      selectedIndex: pageIndex,
      onItemSelected: (index) {
        setState(() => pageIndex = index);
        //_pageController.jumpToPage(index);
      },
   backgroundColor: Colors.black12,
     mainAxisAlignment: MainAxisAlignment.spaceEvenly
      ,items: <BottomNavyBarItem>[
        BottomNavyBarItem(
            title: Text('Home'),
          textAlign: TextAlign.center,
          icon: Icon(Icons.home),
          activeColor: Colors.white,
          inactiveColor:Colors.white60,
        ),
        BottomNavyBarItem(
            title: Text('Upload'),
            textAlign: TextAlign.center,
            icon: Icon(Icons.cloud),
          activeColor: Colors.white,
          inactiveColor:Colors.white60,

        ),

      ],
    ),




    );




  }
}
