import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import 'login_screen.dart';
import 'boards_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(milliseconds: 900), checkLogin);
  }

  void checkLogin() {
    final auth = Provider.of<AuthService>(context, listen: false);
    if (auth.currentUser != null) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const BoardsScreen()));
    } else {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Color(0xfff3eaff),
      body: Center(
        child: Text('Message Board', style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.deepPurple)),
      ),
    );
  }
}
