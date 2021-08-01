import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FirebaseStorageMethods {
  late File file;

  static uploadFile(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
        msg: e.message.toString(),
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
      );
    }
  }

  /*static UploadTask? uploadBytes(String destination, Uint8List data) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putData(data);
    } on FirebaseException catch (e) {
      return null;
    }
  }*/





  //----------------------------------------------------------------------------------------------------------------------------
  static Future<List<String>> _getDownloadLinks(List<Reference> refs) async {
    return Future.wait(refs.map((ref) async {return ref.getDownloadURL();}).toList());
  }

  //----------------------------------------------------------------------------------------------------------------------------

  static Future<List<FirebaseFile>> listAll(String path) async {
    final ref = FirebaseStorage.instance.ref(path);
    final result = await ref.listAll();

    final urls = await _getDownloadLinks(result.items);

    return urls.asMap().map((index, url) {
          final ref = result.items[index];
          final name = ref.name;
          final file = FirebaseFile(ref: ref, name: name, url: url);
          return MapEntry(index, file);}).values.toList();
  }
//----------------------------------------------------------------------------------------------------------------------------
}



class FirebaseFile {
  //TODO: add file type
  final Reference ref;
  final String name;
  final String url;
  //final String fileType;
  const FirebaseFile({required this.ref, required this.name, required this.url});
}
