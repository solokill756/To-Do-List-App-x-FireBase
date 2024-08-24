import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';

class RegisterManager {
  Future<void> signUp(String email, String password, String confirmPassword,
      String firstName, String lastName, int age) async {
    if (checkPassword(password, confirmPassword)) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await addUserInfor(email, firstName, lastName, age);
    }
  }

  bool checkPassword(String password, String confirmPassword) {
    if (password.isEmpty || confirmPassword.isEmpty) {
      return false;
    }
    return password == confirmPassword;
  }

  Future<void> addUserInfor(
      String email, String firstName, String lastName, int age) async {
    await FirebaseFirestore.instance.collection("users").add({
      "first name": firstName,
      "last name": lastName,
      "email": email,
      "age": age
    });
  }
}
