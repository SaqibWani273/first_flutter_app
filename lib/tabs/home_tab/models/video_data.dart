import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class VideoData with ChangeNotifier {
  VideoData(BuildContext context);

  late List<Map<String, String>> videosInfo = [];
  List<Map<String, String>> get videosInfoGetter => videosInfo;
  Future<List> fetchVideosData() async {
    try {
      const urlString =
          'https://flutterapp-bb5cd-default-rtdb.firebaseio.com/videosWithDescription.json';
      // firebase realtime database url

      final response = await http.get(Uri.parse(urlString));
      final extractedData = json.decode(response.body) as List<dynamic>;
      List<Map<String, String>> videosInfo1 = [];
      // extractedData.forEach(
      // dart discourages using foreach here
      for (var element in extractedData) {
        videosInfo1.add({
          "speaker": element['speaker'],
          "description": element['description'],
          "date": element['date'],
          "url": element['url'],
          "thumbnail": element['thumbnail'],
        });
      }

      videosInfo = videosInfo1;

      // return videosInfo;
    } catch (err) {
      print(err.toString());
    }
    return videosInfo;
    notifyListeners();
  }
}
