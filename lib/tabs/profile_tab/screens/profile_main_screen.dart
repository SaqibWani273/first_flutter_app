import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../modals/application_state.dart';

class ProfileHome extends StatelessWidget {
  final ApplicationState appState;
  const ProfileHome(this.appState, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('welcome  Home  '),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 18.0),
              child: Text(
                '${FirebaseAuth.instance.currentUser!.displayName}',
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.exit_to_app_outlined),
              tooltip: 'LogOut',
              onPressed: () {
                appState.logOut();
              },
            ),
          ],
        ),
        body: const Center(
          child: Text("profile home"),
        ),
      ),
    );
  }
}
