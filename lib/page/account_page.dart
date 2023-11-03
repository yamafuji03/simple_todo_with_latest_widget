import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class accountPage extends StatelessWidget {
  const accountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You are logging in:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        FirebaseAuth.instance.currentUser!.photoURL!),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  '${FirebaseAuth.instance.currentUser!.email!}',
                  style: TextStyle(fontSize: 25),
                )
              ],
            ),
            SizedBox(height: 60),
            Column(
              children: [
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Sign out?',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
                SizedBox(height: 50),
                Text(
                  'or',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 50),
                ElevatedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.face),
                    label: Text('Delete your account?'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
