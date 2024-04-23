// ignore_for_file: depend_on_referenced_packages
// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:identicare2/components/my_button.dart';
import 'package:identicare2/components/my_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:identicare2/screens/login.dart';

class SignUp extends StatefulWidget {
  final void Function()? onTap;

  const SignUp({super.key, required this.onTap});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  bool isHidden = true;
  void togglePassword() {
    setState(() {
      isHidden = !isHidden;
    });
  }

  // the textediting controller
  final TextEditingController emailController = TextEditingController();

  final TextEditingController passwordController = TextEditingController();

  final TextEditingController confirmPWController = TextEditingController();

  final TextEditingController usernameController = TextEditingController();

  void signUpUser() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    final String username = usernameController.text;
    final String email = emailController.text;
    final String password = passwordController.text;
    final String passwordConfirmation = confirmPWController.text;


    final response = await registerUser(username, email, password,passwordConfirmation );

    // Hide the progress indicator
    Navigator.of(context).pop();

    if (response.statusCode == 201) {
      // Registration successful
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Registration Successful'),
          content: const Text('You have successfully registered.'),
          actions: [
            TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) =>  Login(onTap: (){},)),//the import of your screen
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
          title: const Text('Registration Failed'),
          content: Text('Error: ${response.body}'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  Future<http.Response> registerUser(
      String username, String email, String password, String passwordConfirmation ) async {
    const String apiUrl =
        'http://127.0.0.1:8000/api/register'; // Replace with your Laravel API endpoint

    final Map<String, String> data = {
      'name': username,
      'email': email,
      'password': password,
      'password_confirmation': passwordConfirmation
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
                mainAxisAlignment: MainAxisAlignment.center,
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

                  // user name textfield
                  MyTextField(
                    hintText: "User Name",
                    labelText: "User Name",
                    obscureText: false,
                    controller: usernameController,
                    prefixIcon: const Icon(Icons.person),
                    suffixIcon: null,
                  ),

                  const SizedBox(
                    height: 10,
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
                        child: Icon(isHidden
                            ? Icons.visibility_off
                            : Icons.visibility)),
                  ),

                  const SizedBox(
                    height: 10,
                  ),

                  // confirm password textfield
                  MyTextField(
                    hintText: "Confirm Password",
                    labelText: " Confirm Password",
                    obscureText: isHidden,
                    controller: confirmPWController,
                    prefixIcon: null,
                    suffixIcon: InkWell(
                        onTap: togglePassword,
                        child: Icon(isHidden
                            ? Icons.visibility_off
                            : Icons.visibility)),
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  // sign in button
                  MyButton(
                    text: "Sign Up",
                    onTap: signUpUser,
                  ),

                  const SizedBox(
                    height: 25,
                  ),

                  // don't have an account register tap text

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
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
                          "Login Here",
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
