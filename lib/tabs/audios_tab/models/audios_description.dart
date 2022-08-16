import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class AudioDescription with ChangeNotifier {
  //AudioDescription(BuildContext context);
  List<Map<String, String>> audiosInfo = [];

  Future<List> fetchAudioDetails() async {
    print('fetch executes');
    final response = await http.get(
      Uri.parse(
          'https://flutterapp-bb5cd-default-rtdb.firebaseio.com/audiosWithDescription.json'),
    );

    if (response.statusCode == 200) {
      // if server return ok response
      final extractedData = json.decode(response.body); //as List<dynamic>;

      for (var element in extractedData) {
        audiosInfo.add({
          "speaker": element['speaker'],
          "audioUrl": element['audioUrl'],
          "audioPicture": element['pictureUrl'],
          "details": element['details'],
          "title": element['title'],
        });
        //  print(audiosInfo.toString());

      }

      return audiosInfo;
    } else {
      print('exception occurred');
      throw Exception('Error occurred while fetching data');
    }
  }
}
