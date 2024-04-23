// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:identicare2/components/my_button.dart';
import 'package:identicare2/components/my_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void validateForm() {
    if (formKey.currentState!.validate()) {
      setState(() {
        formValid = true;
      });
    }
  }

  void chooseImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? imageFile =
        await _picker.pickImage(source: ImageSource.gallery);

    if (imageFile != null) {
      setState(() {
        image = File(imageFile.path);
      });
    }
  }

  final TextEditingController newPostController = TextEditingController();
  File? image;
  bool formValid = false;

  void postMessage() async {
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    final String content = newPostController.text;
    final String apiUrl =
        'http://127.0.0.1:8000/api/post'; // Replace with your Laravel API endpoint

    final Map<String, String> data = {
      'user': '1', // Replace with the user ID from the authenticated user
      'content': content,
    };

    final request = http.MultipartRequest('POST', Uri.parse(apiUrl));
    request.fields.addAll(data);

    if (image != null) {
      final imageFile = await http.MultipartFile.fromPath('image', image!.path);
      request.files.add(imageFile);
    }

    try {
      final response = await request.send();

      if (response.statusCode == 201) {
        // Post created successfully
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Post Created'),
            content: const Text('Your post has been successfully created.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  Navigator.pop(context); // Close the post page
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      } else {
        // Post creation failed
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Post Creation Failed'),
            content: Text('Error: ${response.reasonPhrase}'),
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
    } catch (e) {
      // Network error
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Network Error'),
          content:
              const Text('An error occurred while connecting to the server.'),
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
    } finally {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            const Text(
              "Post a message here",
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Expanded(
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: MyTextField(
                        hintText: "Share your insights",
                        labelText: "Post",
                        obscureText: false,
                        controller: newPostController,
                        prefixIcon: null,
                        suffixIcon: null,
                      ),
                    ),
                    MyButton(
                      text: "Choose Image",
                      onTap: chooseImage,
                    ),
                    MyButton(
                      text: "Post",
                      onTap: () {
                        validateForm();
                        if (formValid) {
                          postMessage();
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 50,
            ),
          ],
        ),
      ),
    );
  }
}
