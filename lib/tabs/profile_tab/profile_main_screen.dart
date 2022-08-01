import 'package:flutter/material.dart';
import 'package:flutter_app/modals/application_state.dart';

class ProfileHome extends StatelessWidget {
  final ApplicationState appState;
  const ProfileHome(this.appState, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Row(
            children: [
              const Text("profile home"),
              TextButton(
                style: ButtonStyle(
                  foregroundColor:
                      MaterialStateProperty.all<Color>(Colors.blue),
                ),
                onPressed: () {
                  appState.signOut();
                },
                child: const Text('Log out'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
