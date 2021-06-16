import 'package:flutter/material.dart';
import 'package:flutter_app/widget/widget.dart';

class First extends StatefulWidget {
  const First({Key? key}) : super(key: key);

  @override
  _FirstState createState() => _FirstState();
}

class _FirstState extends State<First> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(40),
          child: appBarMain(context),
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.build_circle_outlined,
              color: Colors.white70,
              size: 120,
            ),
            Text(
              "Under Construction",
              style: TextStyle(color: Colors.white70, fontSize: 25),
            ),
          ],
        ));
  }
}
