import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:simple_todo_with_latest_widget/model/variable_function.dart';

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
            .where('done', isEqualTo: false)
            .orderBy('listOrder')
            .snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
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
            body: !snapshot.hasData
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ReorderableListView.builder(
                    onReorder: (int oldIndex, int newIndex) {
                      if (oldIndex < newIndex) {
                        // 動かすドキュメントIDを取得
                        final moveId = snapshot.data!.docs[oldIndex].id;
                        FirebaseFirestore.instance
                            .collection('user')
                            .doc(FirebaseAuth.instance.currentUser!.email)
                            .collection('list')
                            .doc(moveId)
                            .update({
                          // newIndexだと最大値プラス１が取れてしまうため、マイナス１で移動先リストと同じindexになるように調整
                          'listOrder': newIndex - 1,
                        });

                        // ここでforでそれ以外のorderをマイナス１にする
                        // 始まりを「１」とするのはorderの値をマイナス１してることから１始まりにしないとorder番号がマイナスになる可能性が出るから
                        for (int i = 1; i <= newIndex - 1; i = i + 1) {
                          // 他のドキュメントのIDを取得
                          final otherId = snapshot.data!.docs[i].id;
                          // 移動させたリストと古いリストのorderが被っているから、もし移動したIDとiのIDが違うなら処理を実行とする。
                          if (moveId != otherId) {
                            FirebaseFirestore.instance
                                .collection('user')
                                .doc(FirebaseAuth.instance.currentUser!.email)
                                .collection('list')
                                .doc(otherId)
                                .update({
                              // orderをi-1にして選択されていないリストの中にあるorderを１ずらす
                              'listOrder': i - 1,
                            });
                          }
                        }
                      } else {
                        // 動かすドキュメントIDを取得
                        final moveId = snapshot.data!.docs[oldIndex].id;

                        // ここでforでそれ以外のorderをプラス１にする
                        // 始まりを「newIndex」として仮に3から2へ移動する際にorder1には影響が出ないようにする
                        for (int i = newIndex; i <= oldIndex; i = i + 1) {
                          // 他のドキュメントのIDを取得
                          final otherId = snapshot.data!.docs[i].id;
                          // 移動させたリストと古いリストのorderが被ってないなら、orderをプラス１して並び替える。
                          if (moveId != otherId) {
                            FirebaseFirestore.instance
                                .collection('user')
                                .doc(FirebaseAuth.instance.currentUser!.email)
                                .collection('list')
                                .doc(otherId)
                                .update({
                              'listOrder': i + 1,
                            });
                          }
                        }
                        FirebaseFirestore.instance
                            .collection('user')
                            .doc(FirebaseAuth.instance.currentUser!.email)
                            .collection('list')
                            .doc(moveId)
                            .update({
                          // newIndexをそのままorder番号にする
                          'listOrder': newIndex,
                        });
                      }
                    },

                    // ここのsnapshotはstreamで範囲が狭まれた物を対象としてるからいつもと同じ感じでおｋ
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot doc = snapshot.data!.docs[index];
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
                          onDismissed: (direction) {
                            // swipe from right to left. throw away list
                            if (direction == DismissDirection.endToStart) {
                              // ランダムに生成したドキュメントIDを取得
                              final fieldId = doc.id;
                              // Firestoreからfield_idからドキュメントIDを取得してドキュメントを削除
                              FirebaseFirestore.instance
                                  .collection('user')
                                  .doc(FirebaseAuth.instance.currentUser!.email)
                                  .collection('list')
                                  .doc(fieldId)
                                  .delete();

                              // documentの個数をリストで取得
                              List<DocumentSnapshot> listDoc =
                                  snapshot.data!.docs;

                              // デリートしたのに上のリストではデリートする前のリストを取得してしまうため、デリートした要素をリスト上でも削除する
                              listDoc.removeAt(index);

                              // リストの個数を取得
                              int docCount = listDoc.length;
                              // 削除したリストのindex番号とリストの個数が違ってたら処理が実行。リストのindexとドキュメント数が一緒だったらスルーする
                              if (index != docCount) {
                                // docCountは１始まり、カウンタ変数は0始まりだからマイナス１で帳尻合わせ
                                for (int i = 0; i <= docCount - 1; i = i + 1) {
                                  FirebaseFirestore.instance
                                      .collection('user')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.email)
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
                              FirebaseFirestore.instance
                                  .collection('user')
                                  .doc(FirebaseAuth.instance.currentUser!.email)
                                  .collection('list')
                                  .doc(doc.id)
                                  .update({
                                'done': true,
                                'listOrder': -1,
                                'archiveDate': Timestamp.now(),
                              });
                            }
                          },
                          child: Card(
                            child: ListTile(
                              // それぞのdocumentに入ってるのitemの中身を表示
                              title: Text(doc["item"]),
                              subtitle: Text(
                                '${DateFormat('yyyy/MM/dd HH:mm').format(doc['createdAt'].toDate())}',
                                style: TextStyle(fontSize: 11),
                              ),

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
                                                    onChanged: (newText) {
                                                      newItem.value = newText;
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
                                                          if (newItem.value !=
                                                              "") {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'user')
                                                                .doc(FirebaseAuth
                                                                    .instance
                                                                    .currentUser!
                                                                    .email)
                                                                .collection(
                                                                    'list')
                                                                .doc(doc.id)
                                                                .update({
                                                              "item":
                                                                  newItem.value,
                                                              'createdAt':
                                                                  Timestamp
                                                                      .now()
                                                            });
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
                                      if (doc['check'] == false) {
                                        FirebaseFirestore.instance
                                            .collection('user')
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.email)
                                            .collection('list')
                                            .doc(doc.id)
                                            .update({'check': true});
                                      } else {
                                        FirebaseFirestore.instance
                                            .collection('user')
                                            .doc(FirebaseAuth
                                                .instance.currentUser!.email)
                                            .collection('list')
                                            .doc(doc.id)
                                            .update({'check': false});
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ));
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
                            onChanged: (newtext) {
                              newItem.value = newtext;
                            },
                          ),
                          actions: [
                            // 「Navigator.pop(context);」は何も起きないで暗くなったページが元に戻る
                            TextButton(
                                child: Text("Cancel"),
                                onPressed: () {
                                  context.pop();
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
                                  'listOrder': snapshot.data!.docs.length,
                                  'done': false,
                                  'createdAt': Timestamp.now(),
                                  'check': false,
                                  'archiveDate': Timestamp.now(),
                                });
                                context.pop();
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
