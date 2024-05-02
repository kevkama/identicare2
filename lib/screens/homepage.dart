// ignore_for_file: use_build_context_synchronously, unnecessary_null_comparison

import 'package:app_bar_with_search_switch/app_bar_with_search_switch.dart';
import 'package:flutter/material.dart';
import 'package:identicare2/components/my_drawer.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:identicare2/helper_functions/helper_alert_msg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Post> posts = [];

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> fetchPosts() async {
    final response =
        await http.get(Uri.parse('http://127.0.0.1:8000/api/post'));
    if (response.statusCode == 200) {
      final List<dynamic> postsJson = jsonDecode(response.body);
      setState(() {
        posts = postsJson.map((post) => Post.fromJson(post)).toList();
      });
    } else {
      // Handle error
      displayMessageToUser('Failed to load posts', context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBarWithSearchSwitch(appBarBuilder: (context) {
        return AppBar(
          title: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "IDENTICARE",
              ),
            ],
          ),
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
          elevation: 0,
          actions: const [AppBarSearchButton()],
        );
      }),
      drawer: const MyDrawer(),
      body: posts.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                final post = posts[index];
                return Column(
                  children: [
                    Card(
                      child: Image(
                        width: double.infinity,
                        image: post.image != null
                            ? NetworkImage('http://127.0.0.1:8000/storage/${post.image}')
                            : const AssetImage('assets/no-image.png')
                                as ImageProvider,
                      ),
                    ),
                    ListTile(
                      title: Text(post.name),
                      subtitle: Text(post.content),
                      leading: CircleAvatar(
                        backgroundImage: post.image != null
                            ? NetworkImage(
                                'http://127.0.0.1:8000/storage/${post.image}')
                            : const AssetImage('assets/no-image.png')
                                as ImageProvider,
                      ),
                      onTap: () {
                        // Handle post tap
                      },
                    ),
                  ],
                );
              },
            ),
    );
  }
}

class Post {
  final int id;
  final int userId;
  final String content;
  final String image;
  final String name;
  final DateTime createdAt;
  final DateTime updatedAt;

  Post({
    required this.id,
    required this.userId,
    required this.content,
    required this.image,
    required this.createdAt,
    required this.updatedAt,
    required this.name,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
      id: json['id'],
      userId: json['user'],
      content: json['content'] ?? '',
      name: json['name'],
      image: json['image'] ??
          'https://via.placeholder.com/150',
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
