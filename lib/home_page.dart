import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width / 430;
    double h = MediaQuery.of(context).size.height / 932;
    final user = FirebaseAuth.instance.currentUser;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Profil'),
        ),
        body: Padding(
          padding: EdgeInsets.only(
            left: 16.0 * w,
            right: 16.0 * w,
          ),
          child: FutureBuilder(
              future: FirebaseFirestore.instance
                  .collection('users')
                  .doc(user!.uid)
                  .get(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                final userData = snapshot.data?.data() as Map<String, dynamic>;
                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Card(
                        child: ListTile(
                          title: const Text("Ad"),
                          subtitle: Text(userData['name']),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: const Text("E-posta"),
                          subtitle: Text(userData['email']),
                        ),
                      ),
                      Card(
                        child: ListTile(
                          title: const Text("Doğum Tarihi"),
                          subtitle: Text(userData['birthDate']),
                        ),
                      ),
                      Card(
                          child: ListTile(
                        title: const Text("Biyografi"),
                        subtitle: Text(userData['bio']),
                      )),
                      Card(
                        child: ListTile(
                            title: const Text("Hobiler"),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: (userData['hobbies'] as List<dynamic>)
                                  .map((hobby) => Text(hobby))
                                  .toList(),
                            )),
                      ),
                      TextField(
                        controller: _controller,
                        decoration: InputDecoration(
                          labelText: 'Yeni Hobi Ekle',
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              setState(() {
                                onAddHobby(_controller.text);
                                _controller.clear();
                              });
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 16.0 * h),
                      ElevatedButton(
                          onPressed: () {
                            FirebaseAuth.instance.signOut();
                            Navigator.of(context)
                                .pushReplacementNamed('/login');
                          },
                          child: const Text('Çıkış Yap', style: TextStyle())),
                    ],
                  ),
                );
              }),
        ));
  }
}

Future onAddHobby(String hobby) async {
  final user = FirebaseAuth.instance.currentUser;
  await FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
    'hobbies': FieldValue.arrayUnion([hobby]),
  });
}
