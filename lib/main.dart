import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_with_latest_widget/list_page.dart';
import 'package:simple_todo_with_latest_widget/login_page.dart';

// hooksを使う場合とhooksリバポを使う場合どっちのwidgetか忘れた

void main() {
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(initialLocation: '/LoginPage', routes: [
      //    GoRoute(path: '/遷移先のクラス名', builder: (context, state) => 遷移先のクラス名),
      GoRoute(path: '/LoginPage', builder: (context, state) => LoginPage()),

      GoRoute(path: '/ListPage', builder: (context, state) => ListPage()),
      // GoRoute(path: '/c', builder: (context, state) => PageC()),
    ]);

    return MaterialApp.router(
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
