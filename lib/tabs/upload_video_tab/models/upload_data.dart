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
  late String selectedImagePath;
  var progress = 0.0;
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
    selectedImagePath = result!.files.first.path!;
    isImageSelected = true;
    notifyListeners();
  }

  cancelUploading() {
    //...code to cancel video uplaod
  }
  uploadVideo({
    required String title,
    required String date,
    required String speaker,
    required String description,
  }) async {
    // firebase path to upload videos at
    String filePath = 'uploads/${selectedVideo.name}';
    final videoFile = File(selectedVideo.path!);

    try {
      final ref = FirebaseStorage.instance.ref(filePath);
      await ref.putFile(videoFile).snapshotEvents.listen((taskSnapshot) {
        switch (taskSnapshot.state) {
          case TaskState.running:
            progress =
                100 * taskSnapshot.bytesTransferred / taskSnapshot.totalBytes;
            notifyListeners();
            break;
          case TaskState.paused:
            // ...
            break;
          case TaskState.success:
            final metaData = SettableMetadata(customMetadata: {
              "title": title,
              "speaker": speaker,
              "description": description,
              "date": date,
            });
            print(date);
            ref.updateMetadata(metaData);
            isVideoSelected = !isVideoSelected;
            isUploading = !isUploading;
            notifyListeners();
            break;
          case TaskState.canceled:
            // ...
            break;
          case TaskState.error:
            // ...
            break;
        }
      });
    } catch (e) {
      // ...
      print(e.toString());
    }
    isUploading = true;
    notifyListeners();
  }
}
