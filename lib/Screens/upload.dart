import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/services/firebase_storage_methods.dart';
import 'package:flutter_app/widget/widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'home.dart';
import 'package:path/path.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);
  @override
  _UploadState createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  File? file;
  String? uploadFileType, uploadFileDirectory;
  FilePickerResult? result;
  static UploadTask? task;
  Future selectFile() async {
    final result = await FilePicker.platform.pickFiles(allowMultiple: false);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile(fileName) async {

    final fileType = extension(file!.path);
    if (uploadFileDirectory != null && fileType == uploadFileType) {
      task = FirebaseStorageMethods.uploadFile("$uploadFileDirectory $fileName", file!);
      Fluttertoast.showToast(msg: "upload successful ", gravity: ToastGravity.CENTER, timeInSecForIosWeb: 3,
      );
    } else if (uploadFileDirectory != null && fileType != uploadFileType!) {
      Fluttertoast.showToast(
        msg: "File type Does Not Match",
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
      );
    } else {
      task = FirebaseStorageMethods.uploadFile(
          "$uploadFileDirectory $fileName", file!);
      Fluttertoast.showToast(
        msg: "Select file type and file category",
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final String fileName =
        file != null ? basename(file!.path) : "No File Selected";
    //  final fileType = extension(file!.path);

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
                height: 50,
              ),

              Icon(
                Icons.cloud_upload_rounded,
                color: Colors.white70,
                size: 120,
              ),

              Text(
                "Upload File",
                style: TextStyle(color: Colors.white70, fontSize: 16),
              ),

              SizedBox(
                height: 50,
              ), // can do it in another way

              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 16, right: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: DropdownButton<String>(
                  hint: Text(
                    "Select File Type",
                    textAlign: TextAlign.center,
                  ),
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 36,
                  isExpanded: true,
                  elevation: 24,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  underline: SizedBox(),
                  value: uploadFileType,
                  items: [
                    DropdownMenuItem(child: Text(".png"), value: ".jpg",),
                    DropdownMenuItem(child: Text(".mp4"), value: ".mp4",),
                    DropdownMenuItem(child: Text(".mp3"), value: ".mp3"),
                    DropdownMenuItem(child: Text(".pdf"), value: ".pdf")
                  ],
                  onChanged: (newValue) {
                    setState(() {
                      uploadFileType = newValue!;
                    });
                  },
                ),
              ),

              SizedBox(
                height: 5,
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.only(left: 16, right: 16),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                child: DropdownButton<String>(
                  hint: Text(
                    "Select File Category",
                    textAlign: TextAlign.center,
                  ),
                  icon: const Icon(Icons.arrow_drop_down),
                  iconSize: 36,
                  isExpanded: true,
                  elevation: 24,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                  ),
                  underline: SizedBox(),
                  value: uploadFileDirectory,
                  items: [
                    DropdownMenuItem(
                      child: Text("Images"),
                      value: 'Images/',
                    ), //Todo fix value
                    DropdownMenuItem(
                      child: Text("Video"),
                      value: 'Video/',
                    ),
                    DropdownMenuItem(child: Text("Audio"), value: 'Audio/'),
                    DropdownMenuItem(
                        child: Text("Documents"), value: 'Documents/')
                  ],
                  onChanged: (newValue) {
                    setState(() {
                      uploadFileDirectory = newValue!;
                    });
                  },
                ),
              ),

              SizedBox(
                height: 15,
              ),

              Center(
                child: Text(
                  "File Name: $fileName",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Colors.white70),
                ),
              ),


              task != null ? buildUploadStatus(task!) : Container(),

              SizedBox(
                height: 150,
              ),

              GestureDetector(
                onTap: () {
                  selectFile();
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
                    "Select File",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),

              GestureDetector(
                onTap: () {
                  if (file != null)
                    uploadFile(fileName);
                  else {
                    Fluttertoast.showToast(
                      msg: "Select a File to upload",
                      gravity: ToastGravity.CENTER,
                      timeInSecForIosWeb: 3,
                    );
                  }
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
                    "Upload File",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 10,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (context) => Home()));
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


Widget buildUploadStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
  stream: task.snapshotEvents,
  builder: (context, snapshot) {
    if (snapshot.hasData) {
      final snap = snapshot.data!;
      final progress = snap.bytesTransferred / snap.totalBytes;
      final percentage = (progress * 100).toStringAsFixed(2);

      return Text(
        '$percentage %',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold , color: Colors.white70),
      );
    } else {
      return Container();
    }
  },
);