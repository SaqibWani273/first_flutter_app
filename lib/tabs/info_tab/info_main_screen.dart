import 'package:flutter/material.dart';

class InfoTab extends StatelessWidget {
  const InfoTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Info tab'),
      ),
      body: Column(children: const [
        Icon(Icons.info_outline_rounded),
        Text('change it to logged in user'),
      ]),
    );
  }
}
