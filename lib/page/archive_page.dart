import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class archivePage extends HookConsumerWidget {
  const archivePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Archves'),
      ),
    );
  }
}
