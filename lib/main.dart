import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'services/auth_service.dart';
import 'services/firestore_service.dart';
import 'screens/splash_screen.dart';
import 'screens/login_screen.dart';
import 'screens/boards_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<FirestoreService>(create: (_) => FirestoreService()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Message Board App',
        theme: ThemeData(
          primarySwatch: Colors.deepPurple,
          scaffoldBackgroundColor: const Color(0xfff3eaff),
        ),
        home: const SplashScreen(),
        routes: {
          '/login': (_) => const LoginScreen(),
          '/boards': (_) => const BoardsScreen(),
        },
      ),
    );
  }
}
