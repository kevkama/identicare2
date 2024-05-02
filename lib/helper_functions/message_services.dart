import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:identicare2/models/message.dart';

class MessageService {
  final String baseUrl = 'http://127.0.0.1:8000/api';

  Future<List<Message>> getMessages() async {
    final response = await http.get(Uri.parse('$baseUrl/messages'));
    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data.map<Message>((json) => Message.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load messages');
    }
  }

  Future<Message> sendMessage(Message message) async {
    final response = await http.post(
      Uri.parse('$baseUrl/messages'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(message.toJson()),
    );
    if (response.statusCode == 201) {
      return Message.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to send message');
    }
  }

  
}