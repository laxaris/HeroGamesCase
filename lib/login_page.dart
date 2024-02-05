import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width / 430;
    double h = MediaQuery.of(context).size.height / 932;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Giriş Yap'),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          left: 16.0 * w,
          right: 16.0 * w,
        ),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'E-posta'),
            ),
            TextField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Şifre'),
              obscureText: true,
            ),
            SizedBox(height: 16.0 * h),
            ElevatedButton(
              onPressed: () async {
                try {
                  await FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );

                  Navigator.of(context).pushReplacementNamed('/home');
                } catch (e) {
                  // Hata yönetimi
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("E-posta veya şifre hatalı"),
                    ),
                  );
                }
              },
              child: const Text('Giriş Yap'),
            ),
            SizedBox(height: 8.0 * h),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/register');
              },
              child: const Text('Hesabın yok mu? Kayıt Ol'),
            ),
          ],
        ),
      ),
    );
  }
}
