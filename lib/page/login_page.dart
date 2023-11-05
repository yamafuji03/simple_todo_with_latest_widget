import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_with_latest_widget/model/variable_function.dart';
import 'package:simple_todo_with_latest_widget/view_model/login_page_view_model.dart';

class LoginPage extends HookWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOG Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sign up!', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () async {
                  await signInWithGoogle();
                  // initial list
                  await FirebaseFirestore.instance
                      .collection('user')
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .set({
                    "registerDate": Timestamp.now(),
                    'uid': FirebaseAuth.instance.currentUser!.uid,
                    'email': FirebaseAuth.instance.currentUser!.email,
                  });
                  final randomId =
                      makeRandomId(FirebaseAuth.instance.currentUser!);

                  await FirebaseFirestore.instance
                      .collection('user')
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .collection('list')
                      .doc(randomId)
                      .set({
                    "item": 'テスト',
                    'id': randomId,
                    'listOrder': 0,
                    'archiveOrder': 0,
                    'done': false,
                    'createdAt': Timestamp.now()
                  });

                  context.push('/ListPage');
                },
                child: Text('Google Sign In')),
          ],
        ),
      ),
    );
  }
}
