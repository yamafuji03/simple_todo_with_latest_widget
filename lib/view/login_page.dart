import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_with_latest_widget/auth/auth.dart';
import 'package:simple_todo_with_latest_widget/view_model/account_provider.dart';
import 'package:simple_todo_with_latest_widget/view_model/crud_provider.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountNotifier = ref.watch(AccountProvider.notifier);

    final crudNotifier = ref.watch(crudProvider.notifier);
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('Sign up!', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            ElevatedButton(
                onPressed: () async {
                  await Authentication.signInWithGoogle();

                  final userData = await FirebaseFirestore.instance
                      .collection('user')
                      .doc(FirebaseAuth.instance.currentUser!.email)
                      .get();
                  print(userData);
                  if (userData.exists) {
                    context.push('/ListPage');
                  } else {
// initial list
                    await accountNotifier.createAccount();

                    await crudNotifier.add(
                        newText: 'Add new Todo on the bottom button');
                    await crudNotifier.add(
                        newText: 'Edit and check with the right side');
                    await crudNotifier.add(newText: 'Swipe for delete a list');
                    await crudNotifier.add(
                        newText: 'You can move lists. Give it a try!');
                    context.push('/ListPage');
                  }
                },
                child: Text('Google Sign In')),
          ],
        ),
      ),
    );
  }
}
