import 'package:flutter/material.dart';

class MessageTile extends StatelessWidget {
  final String username;
  final String text;
  final DateTime timestamp;
  final bool isMe;

  const MessageTile({
    super.key,
    required this.username,
    required this.text,
    required this.timestamp,
    required this.isMe,
  });

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isMe ? Colors.deepPurple : Colors.grey.shade300,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          crossAxisAlignment:
              isMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
          children: [
            
            Text(
              username,
              style: TextStyle(
                fontSize: 12,
                color: isMe ? Colors.white70 : Colors.black87,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 4),

            
            Text(
              text,
              style: TextStyle(
                fontSize: 16,
                color: isMe ? Colors.white : Colors.black,
              ),
            ),

            const SizedBox(height: 4),

           
            Text(
              timestamp.toString().substring(0, 16), 
              style: TextStyle(
                fontSize: 10,
                color: isMe ? Colors.white70 : Colors.black54,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
