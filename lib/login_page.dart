import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class LoginPage extends HookConsumerWidget {
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login page'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              context.push('/ListPage');
            },
            child: Text('Google Sign In')),
      ),
    );
  }
}
