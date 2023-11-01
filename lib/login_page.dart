import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_with_latest_widget/view_model.dart';

class LoginPage extends HookWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('LOG IN'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              signInWithGoogle();
              context.push('/ListPage');
            },
            child: Text('Google Sign In')),
      ),
    );
  }
}
