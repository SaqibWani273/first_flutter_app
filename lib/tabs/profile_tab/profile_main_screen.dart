import 'package:flutter/material.dart';
class ProfileHome extends StatelessWidget {
  const ProfileHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text("profile home"),
        ),
      ),
    );
  }
}
