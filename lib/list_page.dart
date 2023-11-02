import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ListPage extends ConsumerWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('user')
            .doc('email')
            .collection('todo')
            .orderBy('order')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text('TODO List'),
              automaticallyImplyLeading:
                  true, //falseで戻るボタン非表示。あとで大体作ったらfalseにしとく
            ),
            body: !snapshot.hasData
                ? const SizedBox(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                    height: 50,
                    width: 50,
                  )
                : ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {}),
          );
        });
  }
}
