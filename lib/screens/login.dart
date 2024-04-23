// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:identicare2/components/my_bottom_nav.dart';
import 'package:identicare2/components/my_button.dart';
import 'package:identicare2/components/my_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class Login extends StatefulWidget {
  final void Function()? onTap;
  // the textediting controller

  const Login({super.key, required this.onTap});

  final storage = const FlutterSecureStorage();

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool isHidden = true;
  void togglePassword() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  



void login() async {
  showDialog(
    context: context,
    builder: (context) => const Center(
      child: CircularProgressIndicator(),
    ),
  );

  final String email = emailController.text;
  final String password = passwordController.text;

  final response = await loginUser(email, password);

  // Hide the progress indicator
  Navigator.of(context).pop();

  if (response.statusCode == 201) {
    // Registration successful
    final responseData = jsonDecode(response.body);
    final token = responseData['token'];

    // Store the token in Flutter Secure Storage
    await widget.storage.write(key: 'token', value: token);

    // Print a success message in the console
    // print('Token stored successfully');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Login Successful'),
        content: const Text('You have successfully Logged in.'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        const MyBottomNav()), //the import of your screen
              );
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  } else {
    // Registration failed
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Login Failed'),
        content: Text('Error: ${response.body}'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: const Text(
              'OK',
            ),
          ),
        ],
      ),
    );
  }
}


  Future<http.Response> loginUser(
    String email,
    String password,
  ) async {
    const String apiUrl =
        'http://127.0.0.1:8000/api/login'; // Replace with your Laravel API endpoint

    final Map<String, String> data = {
      'email': email,
      'password': password,
    };

    final response = await http.post(
      Uri.parse(apiUrl),
      body: jsonEncode(data),
      headers: {'Content-Type': 'application/json'},
    );

    return response;
  }
  


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                children: [
                  // logo
                  Icon(
                    Icons.person,
                    size: 80,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  // app name
                  const Text(
                    "IDENTICARE",
                    style: TextStyle(fontSize: 20),
                  ),

                  const SizedBox(
                    height: 50,
                  ),

                  // email textfield
                  MyTextField(
                    hintText: "E-mail",
                    labelText: "E-mail",
                    obscureText: false,
                    controller: emailController,
                    prefixIcon: const Icon(Icons.mail),
                    suffixIcon: null,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // password textfield

                  MyTextField(
                    hintText: "Password",
                    labelText: "Password",
                    obscureText: isHidden,
                    controller: passwordController,
                    prefixIcon: null,
                    suffixIcon: InkWell(
                      onTap: togglePassword,
                      child: Icon(
                          isHidden ? Icons.visibility_off : Icons.visibility),
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // forgot password tap  text
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(context, '/forgot_password');
                        },
                        child: const Text(
                          "Forgot password?",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  // sign in button
                  MyButton(
                    text: "Login",
                    onTap: login,
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // don't have an account register tap text

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          "Register Here",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Divider(
                    indent: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const Text("Or"),
                  const SizedBox(
                    height: 10,
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      width: 210,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 241, 74, 32),
                        borderRadius: BorderRadius.circular(25),
                      ),
                      child: const Row(
                        children: [
                          Icon(FontAwesomeIcons.google),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            textAlign: TextAlign.center,
                            "Sign in with google",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
