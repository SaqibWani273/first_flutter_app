import 'package:firebase_storage/firebase_storage.dart';

class DownloadData {
  final storageRef = FirebaseStorage.instance.ref();
  late List<Map<String, String>> dataMap = [];

  Future<List<Map<String, String>>> getVideos() async {
    try {
// strucutre of in firebase cloud
// uploads Folder->speakerName folder->video folder , image folder
//.....................................video file......image file
      final videosRef = storageRef.child('uploads');
      // warning: listAll() will list all the folders at a time at this location
      // change it to list() in future
      final ListResult foldersList = await videosRef.listAll();
      //get data only if its not already received
      if (dataMap.isEmpty) {
        //.prefixes is for folders
        for (var singleFolder in foldersList.prefixes) {
          Reference videoFolder = singleFolder.child('video');
          Reference imageFolder = singleFolder.child('image');
          // to get video file url
          final ListResult videosList = await videoFolder.listAll();
          //items[0]->as there is only one video
          String videoUrl = await videosList.items[0].getDownloadURL();
          // to get image file url
          final ListResult imagesList = await imageFolder.listAll();
          //only one image
          String imageUrl = await imagesList.items[0].getDownloadURL();

          final videoMetaData = await videosList.items[0].getMetadata();
          final customMetaData = videoMetaData.customMetadata;

          dataMap.add(
            {
              "speaker": "${customMetaData!['speaker']}",
              "title": "${customMetaData['title']}",
              "date": "${customMetaData['date']}",
              "description": "${customMetaData['description']}",
              "videoUrl": videoUrl,
              "imageUrl": imageUrl,
            },
          );
        }

        //  print(data.toString());
        print(dataMap.toString());
      }
    } catch (e) {
      print(
        'Error in getting data from firebase cloud :\n${e.toString()}',
      );
    }
    return dataMap;
  }
}
