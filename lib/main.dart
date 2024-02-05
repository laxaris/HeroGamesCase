import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home_page.dart';
import 'login_page.dart'; // Bu dosyada LoginPage widget'ını tanımlayın
import 'register_page.dart'; // Bu dosyada RegisterPage widget'ını tanımlayın
import 'splash_page.dart'; // Bu dosyada SplashPage widget'ını tanımlayın

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/splash',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
        '/splash': (context) => const SplashPage(),
      },
    );
  }
}
