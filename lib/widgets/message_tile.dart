import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  final String text;
  final bool isMe;

  const MessageTile({super.key, required this.text, required this.isMe});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          color: isMe ? Colors.deepPurple : Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 3)],
        ),
        child: Text(
          text,
          style: TextStyle(color: isMe ? Colors.white : Colors.black87),
        ),
      ),
    );
  }
}
