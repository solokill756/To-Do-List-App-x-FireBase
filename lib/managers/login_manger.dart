import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:todolist/managers/user_manager.dart';
import 'package:todolist/models/user_model.dart';

class LoginManger {
  Future<void> signIn(String email, String password) async {
    UserManager userManager = UserManager();
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      String userId = FirebaseAuth.instance.currentUser!.uid.trim();
      UserModel? userData = await userManager.getUserData(userId);
      if (userData != null) {
        Fluttertoast.showToast(
          msg: "Xin chào ${userData.firstName} ${userData.lastName}!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Không thể tìm thấy dữ liệu người dùng!",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    } catch (e) {
      print("Lỗi đăng nhập: $e");
      Fluttertoast.showToast(
        msg: "Đăng nhập thất bại! Vui lòng kiểm tra lại email và mật khẩu.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      Fluttertoast.showToast(
        msg: "Email đặt lại mật khẩu đã được gửi!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.green,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    } catch (e) {
      print("Lỗi khi gửi email đặt lại mật khẩu: $e");
      Fluttertoast.showToast(
        msg: "Không thể gửi email đặt lại mật khẩu!",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    }
  }
}
