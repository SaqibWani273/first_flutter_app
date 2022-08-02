import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/tabs/profile_tab/screens/my_textformfield.dart';

import '../modals/application_state.dart';

class newSignUp extends StatefulWidget {
  final ApplicationState appState;
  final void Function(FirebaseAuthException e) errorCallback;
  // passed to pass it to registerAccount() where it will be finally called
  newSignUp(this.appState, this.errorCallback, {Key? key}) : super(key: key);
  @override
  State<newSignUp> createState() => _newSignUpState();
}

class _newSignUpState extends State<newSignUp> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    email.dispose();
    password.dispose();
    confirmPassword.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext contxt) {
    // navigatorKey:navigatorKey;
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('newSignUp Page'),
      ),
      body: SizedBox(
        height: mediaQueryHeight,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(mediaQueryHeight * 0.1),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  MyTextField().getCustomEditTextArea(
                    labelValue: 'UserName',
                    hintValue: 'Enter Your UserName',
                    controller: userName,
                    validationErrorMsg: 'Enter valid Username',
                    validation: true,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MyTextField().getCustomEditTextArea(
                    labelValue: 'Email',
                    hintValue: 'Enter Valid Email',
                    controller: email,
                    validationErrorMsg: 'Email not correctly formatted',
                    validation: true,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MyTextField().getCustomEditTextArea(
                    labelValue: 'Password',
                    hintValue: 'Enter Strong Password',
                    controller: password,
                    validationErrorMsg: 'Password too short(min. 8 characters)',
                    validation: true,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  MyTextField().getCustomEditTextArea(
                    labelValue: 'Confirm Password',
                    hintValue: 'Passwords should match',
                    controller: confirmPassword,
                    validationErrorMsg: 'Password not matching error',
                    validation: true,
                    //   password: password.text,
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Row(
                    children: [
                      TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        onPressed: () {
                          widget.appState.signOut();
                        },
                        child: const Text('Login'),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          if (formKey.currentState!.validate() &&
                              password.text == confirmPassword.text)
                          //to do show snackbar if passwords do not match
                          {
                            widget.appState.registerAccount(
                              email.text.trim(),
                              userName.text.trim(),
                              password.text.trim(),
                              widget.errorCallback,
                            );
                          }
                        },
                        icon: const Icon(Icons.lock_outline_rounded),
                        label: const Text('Sign Up'),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
