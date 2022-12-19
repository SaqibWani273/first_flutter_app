import 'package:firebase_storage/firebase_storage.dart';

class DownloadData {
  final storageRef = FirebaseStorage.instance.ref();
  late Map dataMap = {};

  getVideos() async {
    final videosRef = storageRef.child('uploads');
    // warning: listAll() will list all the folders at a time at this location
    // change it to list() in future
    final ListResult foldersList = await videosRef.listAll();

    for (Reference singleFolder in foldersList.prefixes) {
// contents of folder -> listItems
      final listItems = await singleFolder.listAll();
      List<Reference> listOfItems = listItems.items;
      //listOfItems[0] -> video
      String videoUrl = await listOfItems[0].getDownloadURL();
      //listOfItems[1] -> image
      String imageUrl = await listOfItems[1].getDownloadURL();
      final videoMetaData = await listOfItems[0].getMetadata();
      final customMetaData = videoMetaData.customMetadata;
      final data = dataMap.addAll(
        {
          "speaker": "$customMetaData['speaker']",
          "title": "$customMetaData['title']",
          "date": "$customMetaData['date']",
          "description": "$customMetaData['description]",
          "videoUrl": videoUrl,
          "imageUrl": imageUrl,
        },
      );
      //  print(data.toString());
      print(dataMap.toString());
    }
  }
}
