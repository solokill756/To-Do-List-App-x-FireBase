import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginManger {
  Future signIn(email, password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }

  Future forgotPassword(email) async {
    await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
  }
}
