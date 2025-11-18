import 'package:flutter/material.dart';
import 'chat_screen.dart';
import 'profile_screen.dart';
import 'settings_screen.dart';
import '../widgets/board_tile.dart';

class BoardsScreen extends StatelessWidget {
  const BoardsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final boards = [
      {'id': 'global', 'name': 'Global Board', 'subtitle': 'Public chat for everyone'},
      {'id': 'help', 'name': 'Help Board', 'subtitle': 'Ask questions'},
      {'id': 'projects', 'name': 'Projects Board', 'subtitle': 'Group work'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Message Boards'),
        backgroundColor: Colors.deepPurple,
        actions: [
          IconButton(
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ProfileScreen()),
            ),
            icon: const Icon(Icons.person),
          )
        ],
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            const DrawerHeader(
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white),
              ),
              decoration: BoxDecoration(color: Colors.deepPurple),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Message Boards'),
              onTap: () => Navigator.pop(context),
            ),
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProfileScreen()),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => SettingsScreen()),
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: boards.length,
          itemBuilder: (context, i) {
            final b = boards[i];
            return BoardTile(
              title: b['name']!,
              subtitle: b['subtitle']!,
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatScreen(
                    boardId: b['id']!,
                    boardName: b['name']!,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
