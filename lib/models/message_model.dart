import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String senderId;
  final String displayName;
  final String text;
  final DateTime timestamp;

  MessageModel({
    required this.senderId,
    required this.displayName,
    required this.text,
    required this.timestamp,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'displayName': displayName,
      'text': text,
      'timestamp': timestamp.toIso8601String(),
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
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
      displayName: map['displayName'] ?? '',
      text: map['text'] ?? '',
      timestamp: ts,
    );
  }
}
