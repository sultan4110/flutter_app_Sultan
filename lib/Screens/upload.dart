import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app/Screens/signin.dart';
import 'package:flutter_app/services/auth.dart';
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
  AuthMethods authMethods = new AuthMethods();
  File? file;
  String? uploadFileDirectory;
  FileType? uploadFileType;
  FilePickerResult? result;
  static UploadTask? task;
  Future selectFile(uploadFileType) async {
    final result = await FilePicker.platform
        .pickFiles(allowMultiple: false, type: uploadFileType);

    if (result == null) return;
    final path = result.files.single.path!;

    setState(() => file = File(path));
  }

  Future uploadFile(fileName) async {
    final fileType = extension(file!.path);

    if (uploadFileDirectory != null && uploadFileType != null) {
      task = FirebaseStorageMethods.uploadFile(
          "$uploadFileDirectory $fileName", file!);
      setState(() {});

    } else if (uploadFileDirectory != null && fileType != uploadFileType!) {
      Fluttertoast.showToast(
        msg: "File type Does Not Match",
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 3,
      );
    } else {
      task = FirebaseStorageMethods.uploadFile(
          "$uploadFileDirectory $fileName", file!);
      setState(() {});

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

    return Scaffold(
        appBar: PreferredSize(preferredSize: const Size.fromHeight(40),

          child: AppBar(
            title: Text("Upload"),
            centerTitle: true,
            actions: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 35),
                  child: IconButton(
                      icon: Icon(Icons.logout),
                      onPressed: () {
                        authMethods.signOut();

                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => SignIn()));
                      }))
            ],
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
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

              Padding(
                padding: const EdgeInsets.only(right: 13.0, left: 38),
                child: Row(
                  children: [
                    Text(
                      " File Type:  ",
                      style: TextStyle(color: Colors.white70, fontSize: 20),
                    ),
                    Flexible(
                      child: Container(
                        alignment: Alignment.center,
                        margin: const EdgeInsets.only(
                          left: 35,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: DropdownButton<FileType>(
                          hint: Text(
                            "          -",
                            style: TextStyle(fontSize: 30, color: Colors.black),
                          ),
                          icon: const Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          iconSize: 36,
                          isExpanded: true,
                          elevation: 24,
                          dropdownColor: Colors.white,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          underline: SizedBox(),
                          value: uploadFileType,
                          items: [
                            DropdownMenuItem(
                              child: Center(
                                  child: Text(
                                "Image",
                              )),
                              value: FileType.image,
                            ),
                            DropdownMenuItem(
                              child: Center(child: Text("Video")),
                              value: FileType.video,
                            ),
                            DropdownMenuItem(
                                child: Center(child: Text("Audio")),
                                value: FileType.audio),
                            DropdownMenuItem(
                                child: Center(child: Text("Any")),
                                value: FileType.any)
                          ],
                          onChanged: (newValue) {
                            setState(() {
                              uploadFileType = newValue!;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(
                height: 5,
              ),

              Row(
                children: [
                  Text(
                    "   File Destination:  ",
                    style: TextStyle(color: Colors.white70, fontSize: 20),
                  ),
                  Flexible(
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(left: 5, right: 15),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(15)),
                      child: DropdownButton<String>(
                        hint: Text(
                          "          -",
                          style: TextStyle(fontSize: 30, color: Colors.black),
                        ),
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: Colors.black,
                        ),
                        iconSize: 36,
                        isExpanded: true,
                        elevation: 24,
                        dropdownColor: Colors.white,
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 20,
                        ),
                        underline: SizedBox(),
                        value: uploadFileDirectory,
                        items: [
                          DropdownMenuItem(
                            child: Center(child: Text("Images")),
                            value: 'Images/',
                          ), //Todo fix value
                          DropdownMenuItem(
                            child: Center(child: Text("Video")),
                            value: 'Video/',
                          ),
                          DropdownMenuItem(
                              child: Center(child: Text("Audio")),
                              value: 'Audio/'),
                          DropdownMenuItem(
                              child: Center(child: Text("Documents")),
                              value: 'Documents/')
                        ],
                        onChanged: (newValue) {
                          setState(() {
                            uploadFileDirectory = newValue!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(
                height: 20,
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


              SizedBox(
                height: 30,
              ),
              task != null ? buildUploadStatus(task!) : Container(),

              SizedBox(
                height: 100,
              ),

              GestureDetector(
                onTap: () {
                  if (uploadFileType != null)
                    selectFile(uploadFileType);
                  else {
                    Fluttertoast.showToast(
                      msg: "Select a File Type",
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
                    "Select File",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 17,
                    ),
                  ),
                ),
              ),

              SizedBox(
                height: 15,
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
      final percentage = (progress * 100).toStringAsFixed(0);

      return ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(
          children: <Widget>[
            Container(
              height: 20,
              child: LinearProgressIndicator(value: progress,),
              
            ),
            Center(child: Text("$percentage%"),),
          ],
        ),
      );



 /*
        LinearProgressIndicator(
        value: progress,
        semanticsLabel: 'In progress',

      );*/

       /* Text(
        '$percentage %',
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      );*/
    } else {
      return Container();
    }
  },
);