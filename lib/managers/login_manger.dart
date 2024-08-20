import 'package:firebase_auth/firebase_auth.dart';

class LoginManger {
  Future signIn(email, password) async {
    await FirebaseAuth.instance
        .signInWithEmailAndPassword(email: email, password: password);
  }
}
