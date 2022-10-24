import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

class Authentication {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  Future<String?> login(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: password);

    return userCredential.user?.uid;
  }

  Future<String?> signUp(String email, String password) async {
    UserCredential userCredential = await _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: password);
    return userCredential.user?.uid;
  }

  void signOut() async {
    return _firebaseAuth.signOut();
  }

  User? getUser() {
    return _firebaseAuth.currentUser;
  }
}
