import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VideoData with ChangeNotifier {
  VideoData(BuildContext context);

  late List<Map<String, String>> videosInfo = [];
  Future<List> fetchVideosData() async {
    try {
      const urlString =
          'https://flutterapp-bb5cd-default-rtdb.firebaseio.com/videosWithDescription.json';
      // firebase realtime database url

      final response = await http.get(Uri.parse(urlString));
      final extractedData = json.decode(response.body) as List<dynamic>;

      if (videosInfo.isEmpty) {
        // extractedData.forEach(
        // dart discourages using foreach here
        for (var element in extractedData) {
          videosInfo.add({
            "speaker": element['speaker'],
            "description": element['description'],
            "date": element['date'],
            "url": element['url'],
            "thumbnail": element['thumbnail'],
          });
        }
      }
      // return videosInfo;
    } catch (err) {
      print(err.toString());
    }
    return videosInfo;
  }
}
