import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AudiosTab extends StatelessWidget {
  const AudiosTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home tab'),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Icon(Icons.home),
              Text(
                '${FirebaseAuth.instance.currentUser == null ? "Anonymous User" : FirebaseAuth.instance.currentUser!.displayName}',
              ),
            ]),
      ),
    );
  }
}
