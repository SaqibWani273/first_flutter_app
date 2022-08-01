import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/modals/application_state.dart';

import '../../main.dart';

class ResetPassword extends StatelessWidget {
  final ApplicationState appState;
  final void Function(FirebaseAuthException e) errorCallback;
  const ResetPassword(this.appState, this.errorCallback, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    TextEditingController confirmPassword = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text("Set New Password")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Enter email to verify your account'),
            Container(
              margin: const EdgeInsets.only(top: 30),
              width: MediaQuery.of(context).size.width * 0.7,
              height: MediaQuery.of(context).size.height * 0.5,
              child: Card(
                elevation: 20,
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        TextField(
                          controller: email,
                          decoration: const InputDecoration(
                              labelText: 'enter your email '),
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            await appState.changePassword(
                              email.text.trim(),
                              errorCallback,
                            );
                          },
                          child: const Text('submit'),
                        )
                      ]),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
