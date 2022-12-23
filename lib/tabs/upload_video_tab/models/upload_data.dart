//import 'dart:html';
import 'dart:async';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

import 'package:flutter/material.dart';

class UploadData extends ChangeNotifier {
  UploadData(BuildContext context);
  var isVideoSelected = false;
  var isImageSelected = false;
  var isUploading = false;
  var isPaused = false;
  late PlatformFile selectedVideo;
  late PlatformFile selectedImage;
  late String selectedImagePath;
  late Reference videoRef;
  late Reference imageRef;

  late UploadTask uploadTask;
  int progress = 0;
  var isUploadSuccessfull = false;
  var isUploadCancelled = false;
  // function to select video using filePicker
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

// function to select image using filePicker()
  Future selectImage() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    selectedImage = result!.files.first;
    selectedImagePath = result.files.first.path!;
    isImageSelected = true;
    notifyListeners();
  }

//function to cancel ongoing upload
  cancelUploading(BuildContext contxt) {
    print('cancel uploading called');
    //when video is cancelled ,delete the uploaded image
    imageRef.delete();
    uploadTask.cancel();

    isUploadCancelled = true;
    ScaffoldMessenger.of(contxt).showSnackBar(
      SnackBar(
        content: Text(
          'Uploading Cancelled !!!',
        ),
      ),
    );

    notifyListeners();
  }

  pauseUploading() {
    uploadTask.pause();
    isPaused = true;
    notifyListeners();
  }

  resumeUploading() {
    uploadTask.resume();
    isPaused = false;
    notifyListeners();
  }

// function to finally upload video to firebase
// using selected video, selected thumbnail image and other details
  uploadVideo({
    required String title,
    required String date,
    required String speaker,
    required String description,
    required BuildContext context,
  }) async {
    final length = await FirebaseStorage.instance
        .ref()
        .child('uploads')
        .listAll()
        .then((value) => value.prefixes.length);

    // firebase path to upload videos at
    String videoFilePath =
        'uploads/$speaker _$length/video/${selectedVideo.name}';
    String imageFilePath =
        'uploads/$speaker _$length/image/${selectedImage.name}';
    final videoFile = File(selectedVideo.path!);
    final imageFile = File(selectedImagePath);

    try {
      videoRef = FirebaseStorage.instance.ref(videoFilePath);
      imageRef = FirebaseStorage.instance.ref(imageFilePath);
      imageRef.putFile(imageFile);
      uploadTask = videoRef.putFile(videoFile);

      // to listen to ongoing progress while uploading
      uploadTask.snapshotEvents.listen(
        (taskSnapshot) {
          switch (taskSnapshot.state) {
            // case 1:
            case TaskState.running:
              progress = (100 *
                      taskSnapshot.bytesTransferred /
                      taskSnapshot.totalBytes)
                  .floor();

              notifyListeners();
              break;
            //case 2:
            case TaskState.paused:
              //this works fine
              print('taskState paused called');
              break;
            //case 3:
            case TaskState.success:
              final metaData = SettableMetadata(customMetadata: {
                "title": title,
                "speaker": speaker,
                "description": description,
                "date": date,
              });
              print(date);
              videoRef.updateMetadata(metaData);

              print('success executed');
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    'video Uploaded Successfully !',
                  ),
                ),
              );
              isUploadSuccessfull = true;
              notifyListeners();
              break;
// case 4:
            case TaskState.canceled:
              // not getting executed...
              print('task state cancelled called');
              break;
//case 5:
            case TaskState.error:
              print('taskstate.error executed');
              // ...
              break;
          }
        },
      );
    } catch (e) {
      //
      print(
          'error type = ${e.runtimeType}\nand error.toString=${e.toString()}');
    }
    isUploading = true;
    notifyListeners();
  }
}
