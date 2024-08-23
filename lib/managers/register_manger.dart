import 'package:firebase_auth/firebase_auth.dart';

class RegisterManger {
  Future signUp(email, password, comfirmPassword) async {
    if (CheckPassword(password, comfirmPassword)) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    }
  }

  bool CheckPassword(password, comfirmPassword) {
    if (password == comfirmPassword)
      return true;
    else
      return false;
  }
}
