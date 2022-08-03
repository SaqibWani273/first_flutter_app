import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models/application_state.dart';

class VerifyEmail extends StatelessWidget {
  final ApplicationState appState;
  final void Function(FirebaseAuthException e) errorCallback;
  const VerifyEmail(this.appState, this.errorCallback, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Center(
        child: Text(
          'Verify Your Email !',
          style: TextStyle(fontSize: 24),
        ),
      ),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Column(
              children: const [
                Text(
                  "we'll send a email confirmation link to the email address provided",
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Make Sure to check your spam folder ',
                  style: TextStyle(fontSize: 10),
                )
              ],
            ),
          ],
        ),
      ),
      actions: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(primary: Colors.red),
              onPressed: () {
                appState.register();
                //send user to signUp page
                FirebaseAuth.instance.currentUser!.delete();
              },
              child: const Text(
                'Cancel signUp !',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                appState.verifyEmail(
                  FirebaseAuth.instance.currentUser!,
                  errorCallback,
                );
                appState.signOut();
              },
              child: const Text(
                'OK Send Email',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
