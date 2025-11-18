import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String senderId;
  final String username;
  final String message;
  final DateTime timestamp;
  final String? messageId;

  MessageModel({
    required this.senderId,
    required this.username,
    required this.message,
    required this.timestamp,
    this.messageId,
  });

  // Convert MessageModel → Firestore
  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'username': username,
      'message': message,
      'timestamp': timestamp,
    };
  }

  // Convert Firestore → MessageModel
  factory MessageModel.fromMap(Map<String, dynamic> map, String id) {
    DateTime ts;

    final t = map['timestamp'];
    if (t is Timestamp) {
      ts = t.toDate();
    } else if (t is String) {
      ts = DateTime.tryParse(t) ?? DateTime.now();
    } else if (t is int) {
      ts = DateTime.fromMillisecondsSinceEpoch(t);
    } else {
      ts = DateTime.now();
    }

    return MessageModel(
      senderId: map['senderId'] ?? '',
      username: map['username'] ?? '',
      message: map['message'] ?? '',
      timestamp: ts,
      messageId: id,
    );
  }
}
