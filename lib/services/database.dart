import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  getUserByUsername(String name) {
    FirebaseFirestore.instance
        .collection("users")
        .where("userName", isEqualTo: name);
  }

  uploadUserInfo(userMap) {
    FirebaseFirestore.instance.collection("users").add(userMap);
  }
}







