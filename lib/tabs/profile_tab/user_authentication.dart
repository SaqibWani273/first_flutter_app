import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/tabs/profile_tab/screens/login_screen.dart';
import 'package:flutter_app/tabs/profile_tab/screens/signup_screen.dart';
import 'package:flutter_app/tabs/profile_tab/screens/forgot_password.dart';
import 'dialogs/verify_email.dart';
import 'screens/profile_main_screen.dart';
import 'models/application_state.dart';

enum ApplicationLoginState {
  register,
  emailVerification,
  loggedOut,
  forgotPassword,
  //resettPassword,
  loggedIn,
}

class UserAuthentication extends StatelessWidget {
  final ApplicationState appState;

  const UserAuthentication(this.appState, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    switch (appState.loginState) {
      case ApplicationLoginState.register:
        return SignUp(
          appState,
          (e) => _showErrorDialog(context, 'Failed to create account', e),
          //callback function is first passed to signup() screen
          //which then passes it to resgisterAccount() in applicationState
        );
      //register
      case ApplicationLoginState.emailVerification:
        return VerifyEmail(
          appState,
          (e) => _showErrorDialog(context, 'Failed to Verify Email', e),
        );

      case ApplicationLoginState.loggedOut:
        return Login(
          appState,
          (e) => _showErrorDialog(context, 'Failed to Log in', e),
        );

      case ApplicationLoginState.forgotPassword:
        return ForgotPassword(
          appState,
          (e) => _showErrorDialog(context, 'Failed to send Email', e),
        );

      case ApplicationLoginState.loggedIn:
        return ProfileHome(
            FirebaseAuth.instance.currentUser!.displayName ?? 'Unknown User');
      default:
        return Login(
          appState,
          (e) => _showErrorDialog(context, 'Failed to Log in', e),
        );
    }
  }

  void _showErrorDialog(
      BuildContext context, String title, FirebaseAuthException e) {
    showDialog<void>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(
            title,
            style: const TextStyle(fontSize: 24),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  // '${(e as dynamic).message}',
                  e.code,
                  style: const TextStyle(fontSize: 18),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text(
                'OK',
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        );
      },
    );
  }
}
