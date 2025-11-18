import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import 'register_screen.dart';
import 'boards_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final email = TextEditingController();
  final pass = TextEditingController();
  bool loading = false;

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthService>(context, listen: false);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text('Welcome', style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
                const SizedBox(height: 30),
                TextField(controller: email, decoration: const InputDecoration(hintText: 'Email', filled: true, fillColor: Colors.white)),
                const SizedBox(height: 12),
                TextField(controller: pass, decoration: const InputDecoration(hintText: 'Password', filled: true, fillColor: Colors.white), obscureText: true),
                const SizedBox(height: 20),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.deepPurple),
                    onPressed: loading ? null : () async {
                      if (email.text.isEmpty || pass.text.isEmpty) return;
                      setState(() => loading = true);
                      try {
                        final user = await auth.login(email.text.trim(), pass.text.trim());
                        if (user != null) {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const BoardsScreen()));
                        }
                      } catch (e) {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
                      } finally {
                        setState(() => loading = false);
                      }
                    },
                    child: loading ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2)) : const Text('Login'),
                  ),
                ),
                const SizedBox(height: 12),
                TextButton(onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RegisterScreen())), child: const Text('Create account')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
