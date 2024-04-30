// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:identicare2/components/login_or_signup.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:identicare2/helper_functions/helper_alert_msg.dart';

class MyDrawer extends StatefulWidget {
  const MyDrawer({super.key});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  final storage = const FlutterSecureStorage();
  Future<void> logout() async {
    // Get the token from secure storage
    final token = await storage.read(key: 'token');

    // Revoke the token from the backend
    final response = await http.post(
      Uri.parse('http://127.0.0.1:8000/api/logout'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer $token', // Include the token in the Authorization header
      },
    );

    if (response.statusCode == 200) {
      // Token revoked successfully
      //print('Token revoked');

      // Remove the token from secure storage
      await storage.delete(key: 'token');
      //print('Token removed from secure storage');

      // Navigate to the login screen

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const LoginOrSignUp()),
      );
    } else {
      // Handle error
      displayMessageToUser('Failed to revoke token: ${response.body}', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // header
          Column(
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);

                  // navigate to users
                  Navigator.pushNamed(context, '/profile');
                },
                child: const DrawerHeader(
                  child: Icon(Icons.favorite),
                ),
              ),

              // home tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.home),
                  title: const Text("H O M E"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),

              // user tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.group),
                  title: const Text("U S E R S"),
                  onTap: () {
                    Navigator.pop(context);

                    // navigate to users
                    Navigator.pushNamed(context, '/users');
                  },
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // Communities tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.group),
                  title: const Text("C O M M U N I T I E S"),
                  onTap: () {
                    Navigator.pop(context);

                    // navigate to users
                    Navigator.pushNamed(context, '/users');
                  },
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // Communities tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.group),
                  title: const Text("EVENTS &  CHARITIES"),
                  onTap: () {
                    Navigator.pop(context);

                    // navigate to users
                    Navigator.pushNamed(context, '/users');
                  },
                ),
              ),

              const SizedBox(
                height: 20,
              ),

              // Communities tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: const Icon(Icons.group),
                  title: const Text("TELEHEALTH"),
                  onTap: () {
                    Navigator.pop(context);

                    // navigate to users
                    Navigator.pushNamed(context, '/users');
                  },
                ),
              ),

              const SizedBox(
                height: 20,
              ),
            ],
          ),

          // logout
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25),
            child: ListTile(
              leading: const Icon(Icons.logout),
              title: const Text("L O G O U T"),
              onTap: logout,
            ),
          )
        ],
      ),
    );
  }
}
