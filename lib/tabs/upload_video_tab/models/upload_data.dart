//import 'dart:html';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class UploadData extends ChangeNotifier {
  UploadData(BuildContext context);
  var isVideoSelected = false;
  var isImageSelected = false;
  var isUploading = false;
  late PlatformFile selectedVideo;
  // late String fileName;
  Future selectVideo() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.video,
    );

    if (result != null) {
      print('user selected a video');

      selectedVideo = result.files.first;
      isVideoSelected = true;

      notifyListeners();
    } else {
      // User canceled the picker
      print('user did not select any video');
    }
  }

  Future selectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    isImageSelected = true;
    notifyListeners();
  }

  cancelUploading() {
    //...code to cancel video uplaod
  }
  uploadVideo() async {
    // firebase path to upload videos at
    String filePath = 'uploads/${selectedVideo.name}';
    final videoFile = File(selectedVideo.path!);

    try {
      final ref = FirebaseStorage.instance.ref(filePath);
      await ref.putFile(videoFile);
    } catch (e) {
      // ...
      print(e.toString());
    }
    isUploading = true;
    notifyListeners();
  }
}
