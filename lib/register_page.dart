import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _bioController = TextEditingController();
  final _birthDateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width / 430;
    double h = MediaQuery.of(context).size.height / 932;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Kayıt Ol'),
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
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(labelText: "Adınız"),
            ),
            TextField(
              controller: _bioController,
              decoration: const InputDecoration(labelText: "Biyografi"),
            ),
            TextField(
              onTap: () async {
                DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime.now(),
                );
                if (picked != null) {
                  _birthDateController.text =
                      '${picked.day}/${picked.month}/${picked.year}';
                }
              },
              readOnly: true,
              keyboardType: TextInputType.none,
              controller: _birthDateController,
              decoration: const InputDecoration(labelText: "Doğum Tarihi"),
            ),
            SizedBox(height: 16.0 * h),
            ElevatedButton(
              onPressed: () async {
                try {
                  if (_emailController.text.isEmpty ||
                      _passwordController.text.isEmpty ||
                      _nameController.text.isEmpty ||
                      _bioController.text.isEmpty ||
                      _birthDateController.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text("Lütfen tüm alanları doldurun"),
                      ),
                    );
                    return;
                  }
                  await FirebaseAuth.instance.createUserWithEmailAndPassword(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  final user = FirebaseAuth.instance.currentUser;
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(user!.uid)
                      .set({
                    'email': _emailController.text,
                    'name': _nameController.text,
                    'bio': _bioController.text,
                    'birthDate': _birthDateController.text,
                    'hobbies': [],
                  });

                  Navigator.of(context).pop();
                } on FirebaseAuthException catch (e) {
                  // Hata yönetimi
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(e.message!),
                    ),
                  );
                }
              },
              child: const Text('Kayıt Ol'),
            ),
          ],
        ),
      ),
    );
  }
}
