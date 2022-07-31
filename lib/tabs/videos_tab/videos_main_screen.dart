import 'package:flutter/material.dart';

class VideosTab extends StatelessWidget {
  const VideosTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Videos tab'),
      ),
      body: Column(children: const [
        Icon(Icons.videocam_sharp),
        Text('change it to logged in user'),
      ]),
    );
  }
}
