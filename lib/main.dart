import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_with_latest_widget/firebase_options.dart';
import 'package:simple_todo_with_latest_widget/router.dart';
import 'package:simple_todo_with_latest_widget/view/account_page.dart';
import 'package:simple_todo_with_latest_widget/view/archive_page.dart';
import 'package:simple_todo_with_latest_widget/view/list_page.dart';
import 'package:simple_todo_with_latest_widget/view/login_page.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(initialLocation: firstPage(), routes: [
      //    GoRoute(path: '/遷移先のクラス名', builder: (context, state) => 遷移先のクラス名),
      GoRoute(path: '/LoginPage', builder: (context, state) => LoginPage()),

      GoRoute(path: '/ListPage', builder: (context, state) => ListPage()),
      GoRoute(path: '/archivePage', builder: (context, state) => archivePage()),
      GoRoute(path: '/accountPage', builder: (context, state) => accountPage()),
    ]);

    return MaterialApp.router(
      routeInformationProvider: router.routeInformationProvider,
      routeInformationParser: router.routeInformationParser,
      routerDelegate: router.routerDelegate,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    );
  }
}
