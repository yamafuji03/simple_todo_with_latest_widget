import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_with_latest_widget/variable_function.dart';

class ListPage extends HookConsumerWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newItem = useState('');

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('user')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection('list')
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
                    // ここのsnapshotはstreamで範囲が狭まれた物を対象としてるからいつもと同じ感じでおｋ
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot doc = snapshot.data!.docs[index];
                      return ListTile(
                        title: Text(doc['item']),
                        subtitle: Text('order番号:${doc['order'].toString()}'),
                      );
                    }),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                showDialog(
                    // おまじない
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                          // ウインドウ左上に表示させるもの
                          title: Text("Create mode"),
                          // 内容入力
                          content: TextField(
                            onChanged: (newtext) {
                              newItem.value = newtext;
                            },
                          ),
                          actions: [
                            // 「Navigator.pop(context);」は何も起きないで暗くなったページが元に戻る
                            TextButton(
                                child: Text("Cancel"),
                                onPressed: () {
                                  Navigator.pop(context);
                                }),
                            TextButton(
                              child: Text("OK"),
                              onPressed: () {
                                final randomId = makeRandomId(
                                    FirebaseAuth.instance.currentUser!);

                                FirebaseFirestore.instance
                                    .collection('user')
                                    .doc(FirebaseAuth
                                        .instance.currentUser!.email)
                                    .collection('list')
                                    .doc(randomId)
                                    .set({
                                  "item": newItem.value,
                                  'id': randomId,
                                  'order': snapshot.data!.docs.length,
                                  'done': false,
                                  'createdAt': Timestamp.now()
                                });
                                Navigator.pop(context);
                              },
                            ),
                          ]);
                    });
              },
            ),
          );
        });
  }
}
