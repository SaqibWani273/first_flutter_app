import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import '../../../firebase_options.dart';
import 'user_authentication.dart';

class ApplicationState extends ChangeNotifier {
  ApplicationLoginState _loginState = ApplicationLoginState.loggedOut;
  //initially set to loggedout
  ApplicationLoginState get loginState => _loginState;
  // returns current loginState

  ApplicationState(BuildContext context) {
    //constructor

    init(context);
  }
//init() starts

  Future<void> init(context) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    print('init executed');
    FirebaseAuth.instance.userChanges().listen((user) {
      if (user != null && user.emailVerified) {
        _loginState = ApplicationLoginState.loggedIn;
      } else if (user != null && !user.emailVerified) {
        _loginState = ApplicationLoginState.emailVerification;
      } else if (user != null) {
        _loginState = ApplicationLoginState.loggedOut;
      } else {
        _loginState = ApplicationLoginState.register;
      }
      notifyListeners();
    });

    // navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
  //init( ) ends

// signIn() starts

  Future<void> signIn(
    BuildContext context,
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
    _loginState = ApplicationLoginState.register;
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
      //signOut();
      errorCallback(e);
      return;
      //finally callback function is called here
    }
    _loginState = ApplicationLoginState.emailVerification;
    notifyListeners();
  }
  // registerAccount() ends

  //verify email starts
  Future<void> verifyEmail(
    User user,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      await user.sendEmailVerification();
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
      //finally callback function is called here
    }
    if (FirebaseAuth.instance.currentUser!.emailVerified) {
      _loginState = ApplicationLoginState.loggedOut;
      notifyListeners();
    }
  }

  //verify emial ends
  Future<void> changePassword(
    String email,
    void Function(FirebaseAuthException e) errorCallback,
  ) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      errorCallback(e);
    }
    signOut();
  }

  void sendEmail() {
    _loginState = ApplicationLoginState.emailVerification;
    notifyListeners();
  }

  void signOut() {
    //FirebaseAuth.instance.signOut();
    _loginState = ApplicationLoginState.loggedOut;
    notifyListeners();
  }

  void resetPassword() {
    _loginState = ApplicationLoginState.resetPassword;
    notifyListeners();
  }
}
