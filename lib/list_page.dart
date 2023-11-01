import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ListPage extends ConsumerWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TODO List'),
        automaticallyImplyLeading: true, //falseで戻るボタン非表示。あとで大体作ったらfalseにしとく
      ),
    );
  }
}
