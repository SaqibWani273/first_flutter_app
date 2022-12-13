import 'package:universal_html/html.dart';
//https://firebase.google.com/docs/storage/flutter/start

import 'package:firebase_storage/firebase_storage.dart';

class fetchVideosFromFCloud {
  final cloudStorage = FirebaseStorage.instance;
  //storageRef is a pointer to a cloud file
  final storageRef = FirebaseStorage.instance.ref();
  final storageRef1 = FirebaseStorage.instance.ref().child('videos');
  //using late becoz storageRef must be initialized first
  late final videoRef = storageRef.child('videos/');
  late final singleVideoRef =
      videoRef.child('Dr_Mubashir Ahsan Wani Almadni.mp4');

  // Create a reference to a file from a Google Cloud Storage URI
  final gsReference =
      FirebaseStorage.instance.refFromURL("gs://YOUR_BUCKET/images/stars.jpg");
  display() async {
    final singleVideoUrl = await videoRef
        .child('Dr_Mubashir Ahsan Wani Almadni.mp4')
        .getDownloadURL();
    try {
      final storageRef1 = FirebaseStorage.instance.ref().child("videos");
      final listResult = await storageRef1.listAll();
      // final videosList = await videoRef.listAll;
      // Create reference to the file whose metadata we want to retrieve
      final forestRef = storageRef1.child(
        "Justice of Islam & Law _ Shaykh Ab Lateef Bhat Almadni Hafizaullah.mp4",
      );
      // Get metadata properties
      final metadata = await forestRef.getMetadata();
      print("${metadata.size}Bytes${metadata.md5Hash}");
      for (var item in listResult.items) {
        var link = await item.getDownloadURL();
        //print(link);
      }
    } on FirebaseException catch (err) {
      print('error occurred:${err.code}:${err.message}');
    }
  }
}
