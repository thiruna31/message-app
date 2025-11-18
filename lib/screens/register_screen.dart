import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/firestore_service.dart';
import 'boards_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final first = TextEditingController();
  final last = TextEditingController();
  final email = TextEditingController();
  final pass = TextEditingController();
  String role = 'student';
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);
    final firestore = Provider.of<FirestoreService>(context, listen: false);

    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.deepPurple, title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              TextField(controller: first, decoration: const InputDecoration(hintText: 'First name', filled: true, fillColor: Colors.white)),
              const SizedBox(height: 8),
              TextField(controller: last, decoration: const InputDecoration(hintText: 'Last name', filled: true, fillColor: Colors.white)),
              const SizedBox(height: 8),
              TextField(controller: email, decoration: const InputDecoration(hintText: 'Email', filled: true, fillColor: Colors.white)),
              const SizedBox(height: 8),
              TextField(controller: pass, decoration: const InputDecoration(hintText: 'Password', filled: true, fillColor: Colors.white), obscureText: true),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: role,
                items: const [
                  DropdownMenuItem(value: 'student', child: Text('Student')),
                  DropdownMenuItem(value: 'instructor', child: Text('Instructor')),
                ],
                onChanged: (v) => setState(() => role = v ?? 'student'),
                decoration: const InputDecoration(filled: true, fillColor: Colors.white),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                  onPressed: loading ? null : () async {
                    if (email.text.isEmpty || pass.text.isEmpty || first.text.isEmpty) return;
                    setState(() => loading = true);
                    try {
                      final user = await auth.register(email.text.trim(), pass.text.trim());
                      if (user != null) {
                        await firestore.addUser(user.uid, first.text.trim(), last.text.trim(), role);
                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const BoardsScreen()), (_) => false);
                      }
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                    } finally {
                      setState(() => loading = false);
                    }
                  },
                  child: loading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) : const Text('Register'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
