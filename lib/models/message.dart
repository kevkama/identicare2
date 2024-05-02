class Message {
  final String content;
  final String sender;
  final String receiver;
  final DateTime sentAt;

  Message({
    required this.content,
    required this.sender,
    required this.receiver,
    DateTime? sentAt,
  }) : sentAt = sentAt ?? DateTime.now();

  static fromJson(json) {}

  Object? toJson() {
    return null;
  }
}