// user_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:identicare2/models/user.dart';

class UserService {
  static const String _baseUrl = 'http://127.0.0.1:8000/api';

  Future<List<User>> getUsers() async {
    final response = await http.get(Uri.parse('$_baseUrl/myuser'));

    if (response.statusCode == 200) {
      final jsonList = jsonDecode(response.body) as List;
      return jsonList.map((json) => User(id: json['id'], name: json['name'])).toList();
    } else {
      throw Exception('Failed to load users');
    }
  }
}