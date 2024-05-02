import 'package:flutter/material.dart';
import 'package:identicare2/screens/login.dart';
import 'package:identicare2/screens/signup.dart';

class LoginOrSignUp extends StatefulWidget {
  const LoginOrSignUp({super.key});

  @override
  State<LoginOrSignUp> createState() => _LoginOrSignUpState();
}

class _LoginOrSignUpState extends State<LoginOrSignUp> {
  // show login page first
  bool showLogin = true;

  // then toggle between the two pages
  void togglePages() {
    setState(() {
      showLogin = !showLogin;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (showLogin) {
      return Login(onTap: togglePages);
    } else {
      return SignUp(onTap: togglePages);
    }
  }
}