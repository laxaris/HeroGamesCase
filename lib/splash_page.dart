import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 1), () {
      if (FirebaseAuth.instance.currentUser == null) {
        Navigator.of(context).pushReplacementNamed('/login');
      } else {
        Navigator.of(context).pushReplacementNamed('/home');
      }
    });
    double w = MediaQuery.of(context).size.width / 430;
    double h = MediaQuery.of(context).size.height / 932;
    return Scaffold(
      body: Center(
        child:
            Icon(Icons.gamepad_outlined, size: 100.0 * w, color: Colors.blue),
      ),
    );
  }
}
