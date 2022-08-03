import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/application_state.dart';
import 'my_textformfield.dart';

class Login extends StatefulWidget {
  final ApplicationState appState;
  final void Function(FirebaseAuthException e) errorCallback;
  const Login(this.appState, this.errorCallback, {Key? key}) : super(key: key);
  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final formKey = GlobalKey<FormState>();
  MyTextField customTextFormField = MyTextField();
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext contxt) {
    final mediaQueryHeight = MediaQuery.of(context).size.height * 0.9;
    // 90% of device height
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: SizedBox(
        height: mediaQueryHeight,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 60, right: 20, left: 20),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  MyTextField().getCustomEditTextArea(
                    //MyTextField()=customTextFormField
                    labelValue: 'Email',
                    hintValue: 'Enter Registered Email',
                    controller: email,
                    validationErrorMsg: 'Email not correctly formatted',
                    validation: true,
                  ),
                  const SizedBox(height: 20),
                  customTextFormField.getCustomEditTextArea(
                    labelValue: 'Password',
                    hintValue: 'Enter your Password',
                    controller: password,
                    validationErrorMsg: 'Password not valid',
                    validation: true,
                  ),
                  const SizedBox(height: 30),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          style: ButtonStyle(
                            foregroundColor:
                                MaterialStateProperty.all<Color>(Colors.blue),
                          ),
                          onPressed: () {
                            widget.appState.forgotPassword();
                          },
                          child: const Text('forgot password?'),
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        ElevatedButton.icon(
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              widget.appState.signIn(
                                context,
                                email.text.trim(),
                                password.text.trim(),
                                widget.errorCallback,
                              );
                            }
                          },
                          icon: const Icon(Icons.done_outline_rounded),
                          label: const Text('Sign In'),
                        ),
                      ]),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Not Registered yet?'),
                      const SizedBox(
                        width: 10,
                      ),
                      TextButton(
                        style: ButtonStyle(
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        onPressed: () {
                          widget.appState.register();
                        },
                        child: const Text('Create Account'),
                      ),
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
