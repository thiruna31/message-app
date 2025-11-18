import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Settings'), backgroundColor: Colors.deepPurple),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            ListTile(leading: const Icon(Icons.color_lens), title: const Text('Theme (placeholder)'), onTap: () {}),
            ListTile(leading: const Icon(Icons.notifications), title: const Text('Notifications (placeholder)'), onTap: () {}),
            ListTile(leading: const Icon(Icons.security), title: const Text('Privacy (placeholder)'), onTap: () {}),
          ],
        ),
      ),
    );
  }
}
