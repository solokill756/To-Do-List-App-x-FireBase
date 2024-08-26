import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_cloud_firestore/firebase_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_toastr/flutter_toastr.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterManager {
  Future<void> signUp(String email, String password, String confirmPassword,
      String firstName, String lastName, int age) async {
    if (checkPassword(password, confirmPassword)) {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      String? id = FirebaseAuth.instance.currentUser?.uid;
      if (id == null) {
        print("cannot find the id user");
      } else {
        addUserInfor(email, firstName, lastName, age, id);
      }
      Fluttertoast.showToast(
        msg: "Xin chào $firstName $lastName !",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  bool checkPassword(String password, String confirmPassword) {
    if (password.isEmpty || confirmPassword.isEmpty) {
      return false;
    }
    return password == confirmPassword;
  }

  Future<void> addUserInfor(String email, String firstName, String lastName,
      int age, String id) async {
    await FirebaseFirestore.instance.collection("users").add({
      "id": id,
      "first name": firstName,
      "last name": lastName,
      "email": email,
      "age": age
    });
  }
}
