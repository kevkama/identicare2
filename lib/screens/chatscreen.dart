// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:identicare2/helper_functions/helper_alert_msg.dart';
import 'package:identicare2/models/message.dart';
import 'package:identicare2/helper_functions/message_services.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final MessageService _messageService = MessageService();
  List<Message> _messages = [];
  final TextEditingController _messageController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    try {
      final messages = await _messageService.getMessages();
      setState(() {
        _messages = messages;
      });
    } catch (e) {
      displayMessageToUser('$e', context);
    }
  }

  Future<void> _sendMessage() async {
    final message = Message(
      content: _messageController.text,
      sender: 'currentUser', 
      receiver: 'otherUser', 
    );

    try {
      final newMessage = await _messageService.sendMessage(message);
      setState(() {
        _messages.add(newMessage);
        _messageController.clear();
      });
    } catch (e) {
      displayMessageToUser('$e', context);;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                return ListTile(
                  title: Text(message.content),
                  subtitle: Text('From: ${message.sender}'),
                );
              },
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _messageController,
                  decoration: const InputDecoration(
                    hintText: 'Type a message...',
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: _sendMessage,
              ),
            ],
          ),
        ],
      ),
    );
  }
}