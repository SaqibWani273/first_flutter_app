import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import '../firebase_options.dart';
import 'user_authentication.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  //initially set to loggedout
  ApplicationLoginState get loginState => _loginState;
  // returns current loginState

  String? _email;
  // is assigned after email is verified in verifyEmail()
  String? get email => _email;
  ApplicationState() {
    //constructor
    init();
  }
//init() starts
  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null) {
        _loginState = ApplicationLoginState.loggedIn;
      } else {
        _loginState = ApplicationLoginState.loggedOut;
      }
      notifyListeners();
    });
  }
  //init( ) ends

//verifyEmail() starts
  Future<void> verifyEmail(
    String email,
    void Function(FirebaseAuthException e) errorCallback,
    // refrence of function,that is defined somewhere else and will be called
    // within this verfiyEmail function using this refrence
  ) async {
    try {
      var methods =
          await FirebaseAuth.instance.fetchSignInMethodsForEmail(email);
      if (methods.contains('password')) {
        _loginState = ApplicationLoginState.password;
      } else {
        _loginState = ApplicationLoginState.register;
      }
      _email = email;
      notifyListeners();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }

  // verifyEmail() ends

// signIn() starts
  Future<void> signIn(
    String email,
    String password,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
  }
  // signIn() ends

  void cancelRegistration() {
    _loginState = ApplicationLoginState.emailAddress;
    notifyListeners();
  }

//registerAccount() starts
  Future<void> registerAccount(
    String email,
    String displayName,
    String password,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      var credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user!.updateDisplayName(displayName);
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
      //finally callback function is called here
    }
  }
  // registerAccount() ends

  void signOut() {
    FirebaseAuth.instance.signOut();
  }
}
