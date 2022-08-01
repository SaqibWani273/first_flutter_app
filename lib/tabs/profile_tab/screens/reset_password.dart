import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../modals/application_state.dart';

class ResetPassword extends StatefulWidget {
  final ApplicationState appState;
  final void Function(FirebaseAuthException e) errorCallback;
  const ResetPassword(this.appState, this.errorCallback, {Key? key})
      : super(key: key);

  @override
  State<ResetPassword> createState() => _ResetPasswordState();
}

class _ResetPasswordState extends State<ResetPassword> {
  @override
  Widget build(BuildContext context) {
    TextEditingController email = TextEditingController();
    final formKey = GlobalKey<FormState>();
    return Scaffold(
      appBar: AppBar(title: const Text("Set New Password")),
      body: Center(
        child: Form(
          key: formKey,
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
                          TextFormField(
                            textInputAction: TextInputAction.next,
                            keyboardType: TextInputType.emailAddress,
                            controller: email,
                            decoration: const InputDecoration(
                                labelText: 'enter your email '),
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            validator: ((value) =>
                                value != null && !EmailValidator.validate(value)
                                    ? 'Enter a valid email'
                                    : null),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton.icon(
                                style: TextButton.styleFrom(
                                  primary: Colors.redAccent,
                                  backgroundColor: Colors.black12,
                                ),
                                onPressed: () {
                                  widget.appState.cancelRegistration();
                                },
                                icon: const Icon(Icons.cancel),
                                label: const Text('Cancel'),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    widget.appState.changePassword(
                                      email.text.trim(),
                                      widget.errorCallback,
                                    );
                                  }
                                },
                                child: const Text('Submit'),
                              ),
                            ],
                          )
                        ]),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
