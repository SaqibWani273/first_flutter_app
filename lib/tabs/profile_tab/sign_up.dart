import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/modals/application_state.dart';

class SignUp extends StatefulWidget {
  final ApplicationState appState;
  final void Function(FirebaseAuthException e) errorCallback;
  // passed to pass it to registerAccount() where it will be finally called
  SignUp(this.appState, this.errorCallback, {Key? key}) : super(key: key);
  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController userName = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  @override
  void dispose() {
    email.dispose();
    password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext contxt) {
    // navigatorKey:navigatorKey;
    final mediaQueryHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text('SignUp Page'),
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
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  controller: userName,
                  decoration: const InputDecoration(
                    labelText: 'username',
                    labelStyle: TextStyle(
                        color: Color.fromRGBO(173, 183, 192, 1),
                        fontWeight: FontWeight.bold),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(173, 183, 192, 1)),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
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
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
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
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.next,
                  controller: confirmPassword,
                  decoration: const InputDecoration(
                    labelText: 'Confirm Password',
                    labelStyle: TextStyle(
                        color: Color.fromRGBO(173, 183, 192, 1),
                        fontWeight: FontWeight.bold),
                    enabledBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: Color.fromRGBO(173, 183, 192, 1)),
                    ),
                  ),
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
                        widget.appState.registerAccount(
                          email.text.trim(),
                          userName.text.trim(),
                          password.text.trim(),
                          widget.errorCallback,
                        );
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
    );
  }
}
