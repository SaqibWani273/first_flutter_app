import 'package:flutter/material.dart';
import 'package:flutter_app/modals/application_state.dart';
import 'package:flutter_app/tabs/profile_tab/error_page.dart';
import 'package:flutter_app/tabs/profile_tab/login.dart';
import 'package:flutter_app/tabs/profile_tab/profile_main_screen.dart';
import 'package:flutter_app/tabs/profile_tab/reset_password.dart';
import 'package:flutter_app/tabs/profile_tab/sign_up.dart';
import '../tabs/profile_tab/verify_email.dart';

enum ApplicationLoginState {
  register,
  emailVerification,
  loggedOut,
  forgotPassword,
  passwordResetCode,
  resetPassword,
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
          //callback function is first passed to signup()
          //which then passes it to resgisterAccount()
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

      case ApplicationLoginState.resetPassword:
        return ResetPassword(
          appState,
          (e) => _showErrorDialog(context, 'Failed to send Email', e),
        );

      case ApplicationLoginState.loggedIn:
        return ProfileHome(appState);

      default:
        return const ErrorPage();
    }
  }

  void _showErrorDialog(BuildContext context, String title, Exception e) {
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
                  '${(e as dynamic).message}',
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
