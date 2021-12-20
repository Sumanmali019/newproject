import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:location_tracker/screens/homepage2.dart';
import 'package:path/path.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// ignore: must_be_immutable
class CameraUpload extends StatefulWidget {
  String? userId;
  CameraUpload({Key? key, userId}) : super(key: key);

  @override
  _CameraUploadState createState() => _CameraUploadState();
}

class _CameraUploadState extends State<CameraUpload> {
  UploadTask? task;
  File? imageFile;
  String? downloadUrl;

  bool? isDone = false;
  bool? show = true;

  @override
  void initState() {
    super.initState();
    isDone = false;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: const Color.fromRGBO(7, 84, 94, 0.9),
        appBar: AppBar(
          elevation: 2,
          backgroundColor: const Color.fromRGBO(7, 84, 94, 0.9),
          title: const Text(
            'Upload photo\'s',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              if (imageFile != null)
                Container(
                  width: 480,
                  height: 480,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey,
                    image: DecorationImage(
                        image: FileImage(imageFile!), fit: BoxFit.cover),
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                )
              else
                Container(
                  width: 500,
                  height: 500,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    border: Border.all(color: Colors.black12),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 5,
                        blurRadius: 10,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const Text(
                    'Take Photo',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          getImage(source: ImageSource.camera);
                          task = null;
                          setState(() {});
                        },
                        child: const Icon(Icons.camera_alt_outlined),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                        )),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: () {
                          uploadImage();
                          task!.whenComplete(() {
                            setState(() {
                              show = false;
                            });
                          });
                          setState(() {
                            isDone = false;
                          });
                        },
                        child: const Icon(
                          Icons.cloud_upload_outlined,
                        ),
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.green),
                        )),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              task != null ? buildUplaodStatus(task!) : Container(),
            ],
          ),
        ),
      ),
    );
  }

  getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(source: source);

    if (file?.path != null) {
      setState(
        () {
          imageFile = File(file!.path);
        },
      );
    }
  }

  Future uploadImage() async {
    if (imageFile == null) return;
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = FirebaseAuth.instance.currentUser;

    final filename = basename(imageFile!.path);
    final destination = '${user!.uid}/$filename';

    task = FirebaseApi.uploadFile(destination, imageFile!);
    task!.whenComplete(() {
      isDone = true;
    });

    setState(() {});

    if (task == null) return;

    final snapshot = await task!.whenComplete(() {
      setState(() {
        imageFile == null;
      });
    });
    final downloadUrl = await snapshot.ref.getDownloadURL();
    // print('download link - $downloadUrl');

    await firebaseFirestore
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('images')
        .add({'downloadUrl': downloadUrl}).whenComplete(() => isDone = true);
  }

  Widget buildUplaodStatus(UploadTask task) => StreamBuilder<TaskSnapshot>(
        stream: task.snapshotEvents,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final snap = snapshot.data!;
            final process = snap.bytesTransferred / snap.totalBytes;
            final percentage = (process * 100).toStringAsFixed(2);

            if (!isDone!) {
              return Text(
                '$percentage %',
                style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
              );
            } else {
              return ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Homepage()));
                  },
                  child: const Icon(Icons.done_outline_rounded),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.green),
                  ));
            }
          } else {
            return Container();
          }
        },
      );
}

class FirebaseApi {
  static UploadTask? uploadFile(String destination, File imageFile) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);

      return ref.putFile(imageFile);
      // ignore: unused_catch_clause
    } on FirebaseException catch (e) {
      return null;
    }
  }
}
