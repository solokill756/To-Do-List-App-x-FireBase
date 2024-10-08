import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:todolist/managers/login_manger.dart';
import 'package:todolist/modules/auth/forgotPassword/forgotPassword_page.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback showRegister;
  const LoginPage({super.key, required this.showRegister});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final LoginManger loginManger = LoginManger();
  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 139, 99, 99),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'HELLO AGAIN!',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                "Welcome back , you've been missed",
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 15),
                      border: InputBorder.none,
                      hintText: "Email",
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: TextField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      contentPadding: EdgeInsets.only(left: 15),
                      border: InputBorder.none,
                      hintText: "Password",
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: () async {
                    await loginManger.signIn(_emailController.text.trim(),
                        _passwordController.text.trim());
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                      child: Text(
                        'Sign in',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return const ForgotpasswordPage();
                            },
                          ),
                        );
                      },
                      child: const Text(
                        'Forgot Password ?',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Not a menber ?',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.showRegister,
                    child: const Text(
                      ' Register',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
