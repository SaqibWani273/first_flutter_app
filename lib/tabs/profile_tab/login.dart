import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/tabs/profile_tab/reset_password.dart';

import '../../modals/application_state.dart';

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
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext contxt) {
    // navigatorKey:navigatorKey;
    final mediaQueryHeight = MediaQuery.of(context).size.height * 0.9;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login Page'),
      ),
      body: SizedBox(
        height: mediaQueryHeight,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 60, right: 20, left: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TextFormField(
                  // returns a simple textFormField with some preffered styling
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  controller: email,
                  decoration: const InputDecoration(
                    labelText: 'Email',
                    labelStyle: TextStyle(
                        color: Color.fromRGBO(173, 183, 192, 1),
                        fontWeight: FontWeight.bold),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(173, 183, 192, 1)),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  // returns a simple textFormField with some preffered styling
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  controller: password,
                  decoration: const InputDecoration(
                    labelText: 'password',
                    labelStyle: TextStyle(
                        color: Color.fromRGBO(173, 183, 192, 1),
                        fontWeight: FontWeight.bold),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(173, 183, 192, 1)),
                    ),
                  ),
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
                          widget.appState.resetPassword();
                        },
                        child: const Text('forgot password?'),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          widget.appState.signIn(
                            context,
                            email.text.trim(),
                            password.text.trim(),
                            widget.errorCallback,
                          );
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
                        widget.appState.cancelRegistration();
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
    );
  }
}
