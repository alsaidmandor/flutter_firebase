import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum AuthStatus { unAuthenticated, authenticating, authenticated, }

class AuthProvider
    with ChangeNotifier {

  FirebaseAuth _auth;

  User _user;

  AuthStatus _authStatus = AuthStatus.unAuthenticated;

  String errorMessage;


  AuthProvider() {
    _auth = FirebaseAuth.instance ;
    _auth.authStateChanges().listen((User user) {
      if (user == null) {
        _authStatus = AuthStatus.authenticated;
      } else {
        _user = user;
      }
      notifyListeners();
    });
  }

  User get user => _user;

  AuthStatus get authStatus => _authStatus;

  Future<bool> login(String email, String password) async
  {
    try {
      _authStatus = AuthStatus.authenticating;

      notifyListeners();

      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      _authStatus = AuthStatus.authenticated;
      notifyListeners();
      return true;
  } on FirebaseAuthException catch (e) {
  if (e.code == 'invalid-email') {
    errorMessage = 'Invalid email';
  }
  else if (e.code == 'user-not-found') {
    errorMessage = 'user not found';

  //show snackBar
  }
  else if (e.code == 'wrong-password') {
  // show snackBar
    errorMessage = 'wrong password';

  }
  _authStatus = AuthStatus.unAuthenticated ;
  notifyListeners() ;
  return false ;
  }
  }

  logOut() async
  {
    await _auth.signOut();
    _authStatus = AuthStatus.unAuthenticated;
    notifyListeners();
  }
}