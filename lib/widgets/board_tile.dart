import 'package:flutter/material.dart';

class BoardTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const BoardTile({super.key, required this.title, required this.subtitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        leading: CircleAvatar(backgroundColor: Colors.deepPurple, child: Text(title[0].toUpperCase())),
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }
}
