import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../services/auth_service.dart';
import 'login_screen.dart';
import 'settings_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  Future<Map<String, dynamic>?> fetchUserData(String uid) async {
    final doc = await FirebaseFirestore.instance
        .collection('users')
        .doc(uid)
        .get();
    return doc.data();
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context);

    final user = auth.currentUser; // safer
    final uid = user?.uid;

    return Scaffold(
      backgroundColor: const Color(0xfff3eaff),
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.deepPurple,
      ),
      body: uid == null
          ? const Center(child: Text("User not logged in"))
          : FutureBuilder<Map<String, dynamic>?>(
              future: fetchUserData(uid),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(
                      color: Colors.deepPurple,
                    ),
                  );
                }

                final data = snapshot.data ?? {};

                return Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const CircleAvatar(
                        radius: 45,
                        backgroundColor: Colors.deepPurple,
                        child: Icon(Icons.person, color: Colors.white, size: 60),
                      ),
                      const SizedBox(height: 20),

                     
                      Text(
                        "${data['firstname'] ?? ''} ${data['lastname'] ?? ''}",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.deepPurple,
                        ),
                      ),

                      const SizedBox(height: 10),

                     
                      Text(
                        user?.email ?? "",
                        style: const TextStyle(
                          fontSize: 18,
                          color: Colors.black54,
                        ),
                      ),
                      const SizedBox(height: 30),

                      const Divider(),

                      const SizedBox(height: 20),

                      
                      ListTile(
                        leading: const Icon(Icons.settings, color: Colors.deepPurple),
                        title: const Text("Settings"),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const SettingsScreen(),
                            ),
                          );
                        },
                      ),

                      
                      ListTile(
                        leading: const Icon(Icons.logout, color: Colors.red),
                        title: const Text("Logout"),
                        onTap: () async {
                          await auth.logout();

                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (_) => const LoginScreen()),
                            (_) => false,
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
