import 'package:flutter/material.dart';
import 'package:identicare2/Themes/dark_mode.dart';
import 'package:identicare2/Themes/light_mode.dart';
import 'package:identicare2/components/login_or_signup.dart';
import 'package:identicare2/components/my_bottom_nav.dart';
import 'package:identicare2/screens/forgot_password.dart';
import 'package:identicare2/screens/homepage.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const LoginOrSignUp(),
      theme: lightMode,
      darkTheme: darkMode,
      routes: {
        '/homepage': (context) => const HomePage(),
        '/forgot_password': (context) => const ForgotPasswordPage(),
        '/bottomnav':(context) => const MyBottomNav(),
        '/loginOrSignUp' :(context) => const LoginOrSignUp()
      },
    );
  }
}
