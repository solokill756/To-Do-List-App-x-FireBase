import 'package:flutter/material.dart';
import 'package:todolist/modules/auth/login/login_page.dart';
import 'package:todolist/modules/auth/register/register_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool showLogin = true;
  void toggleScreens() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return LoginPage(showRegister: toggleScreens);
    } else {
      return RegisterPage(showLogin: toggleScreens);
    }
  }
}
