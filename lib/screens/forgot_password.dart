// ignore_for_file: use_build_context_synchronously


import 'package:flutter/material.dart';
import 'package:identicare2/components/my_button.dart';
import 'package:identicare2/components/my_textfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 25.0),
            child: Text(
              "Enter your email to recieve a password reset link",
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          MyTextField(
              hintText: "Email",
              labelText: "Email",
              obscureText: false,
              controller: emailController,
              prefixIcon: const Icon(Icons.mail),
              suffixIcon: null),
          const SizedBox(height: 20),
          MyButton(text: "Reset Password", onTap: (){}),
        ],
      ),
    );
  }
}
