import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:simple_todo_with_latest_widget/view_model/crud_provider.dart';

import 'package:simple_todo_with_latest_widget/view_model/order_provider.dart';
import 'package:simple_todo_with_latest_widget/view_model/stream_provider.dart';

class ListPage extends HookConsumerWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crudState = ref.watch(crudProvider);
    final crudNotifier = ref.watch(crudProvider.notifier);
    String newText = '';

    final asyncValue = ref.watch(listPageProvider);

    final orderNotifier = ref.watch(orderProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: Text('TODO List'),
        actions: [
          IconButton(
              onPressed: () {
                context.push('/accountPage');
              },
              icon: Icon(Icons.settings))
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    alignment: Alignment.center,
                    height: 60,
                    child: DrawerHeader(
                      child: Text(
                        "Menu",
                      ),
                      decoration: BoxDecoration(),
                    ),
                  ),
                  ListTile(
                    title: Text('Archive'),
                    onTap: () {
                      context.push('/archivePage');
                    },
                  ),
                ],
              ),
            ),
            TextButton(
                onPressed: () {
                  context.pop();
                },
                child: Text('Close'))
          ],
        ),
      ),
      body: asyncValue.when(
          error: (error, _) => Text(error.toString()),
          loading: () => Center(child: CircularProgressIndicator()),
          data: (snapshot) {
            return ReorderableListView.builder(
                onReorder: (int oldIndex, int newIndex) {
                  // orderFunc
                  orderNotifier.order(oldIndex: oldIndex, newIndex: newIndex);
                },

                // ここのsnapshotはstreamで範囲が狭まれた物を対象としてるからいつもと同じ感じでおｋ
                itemCount: snapshot.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot doc = snapshot.docs[index];
                  return Dismissible(
                      // ドキュメントIDの特定し、リストの特定をするdocIDを取得
                      key: Key(doc.id),
                      background: Container(
                        color: Colors.green,
                        child: Icon(Icons.archive),
                        alignment: Alignment.centerLeft,
                      ),
                      secondaryBackground: Container(
                        color: Colors.red,
                        child: Icon(Icons.delete),
                        alignment: Alignment.centerRight,
                      ),
                      onDismissed: (direction) async {
                        // swipe from right to left. throw away list
                        if (direction == DismissDirection.endToStart) {
                          await crudNotifier.deleteFromList(index: index);

                          // documentの個数をリストで取得
                          List<DocumentSnapshot> listDoc = snapshot.docs;

                          // デリートしたのに上のリストではデリートする前のリストを取得してしまうため、デリートした要素をリスト上でも削除する
                          listDoc.removeAt(index);

                          // リストの個数を取得
                          int docCount = listDoc.length;
                          // 削除したリストのindex番号とリストの個数が違ってたら処理が実行。リストのindexとドキュメント数が一緒だったらスルーする
                          if (index != docCount) {
                            // docCountは１始まり、カウンタ変数は0始まりだからマイナス１で帳尻合わせ
                            for (int i = 0; i <= docCount - 1; i = i + 1) {
                              await FirebaseFirestore.instance
                                  .collection('user')
                                  .doc(FirebaseAuth.instance.currentUser!.email)
                                  .collection('list')
                                  .doc(listDoc[i]
                                      .id) //ここは１個から全てのドキュメントを更新していくため、
                                  // 変数doc（指定したドキュメント）「 DocumentSnapshot doc = snapshot.data!.docs[index];」は使用できないため、フルで全部書く
                                  .update({
                                'listOrder': i,
                              });
                            }
                          }
                        }
                        // swipe from left to right. archive
                        if (direction == DismissDirection.startToEnd) {
                          crudNotifier.toArchive(index: index);
                        }
                      },
                      child: Card(
                        child: ListTile(
                          // それぞのdocumentに入ってるのitemの中身を表示
                          title: Text(doc["item"]),
                          subtitle: Text(
                              '${DateFormat('yyyy/MM/dd HH:mm').format(doc['createdAt'].toDate())}',
                              style: TextStyle(fontSize: 11)),

                          // order確認のために使用
                          // Text('Order :${snapshot.data!.docs[index]['listOrder'].toString()}'),

                          trailing: Wrap(
                            children: [
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                        // おまじない
                                        context: context,
                                        builder: (context) {
                                          return AlertDialog(
                                              // ウインドウ左上に表示させるもの
                                              title: Text("Edit mode"),
                                              // 内容入力
                                              content: TextField(
                                                onChanged: (text) {
                                                  newText = text;
                                                },
                                              ),
                                              actions: [
                                                TextButton(
                                                    child: Text("Cancel"),
                                                    onPressed: () {
                                                      context.pop();
                                                    }),
                                                TextButton(
                                                    child: Text("OK"),
                                                    onPressed: () {
                                                      if (newText != "") {
                                                        crudNotifier.upDate(
                                                            newText: newText,
                                                            index: index);
                                                      }
                                                      ;
                                                      context.pop();
                                                    })
                                              ]);
                                        });
                                  },
                                  icon: Icon(Icons.edit)),
                              IconButton(
                                icon: doc['check'] == true
                                    ? Icon(Icons.check,
                                        color: Colors.blue.shade500)
                                    : Icon(Icons.check),
                                onPressed: () {
                                  crudNotifier.checkFromList(index: index);
                                },
                              ),
                            ],
                          ),
                        ),
                      ));
                });
          }),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
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
                      onChanged: (text) {
                        newText = text;
                      },
                    ),
                    actions: [
                      TextButton(
                          child: Text("Cancel"),
                          onPressed: () {
                            context.pop();
                          }),
                      TextButton(
                        child: Text("OK"),
                        onPressed: () {
                          crudNotifier.add(newText: newText);
                          context.pop();
                        },
                      ),
                    ]);
              });
        },
      ),
    );
  }
}
