import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

class archivePage extends HookConsumerWidget {
  const archivePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('user')
            .doc(FirebaseAuth.instance.currentUser!.email)
            .collection('list')
            .where('done', isEqualTo: true)
            .orderBy('archiveDate')
            .snapshots(),
        builder: ((context, snapshot) {
          return Scaffold(
            appBar: AppBar(
              title: Text('Archive'),
            ),
            body: !snapshot.hasData
                ? Center(
                    child: Text("You have no archives yet"),
                  )
                : ListView.builder(

                    // ここのsnapshotはstreamで範囲が狭まれた物を対象としてるからいつもと同じ感じでおｋ
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (BuildContext context, int index) {
                      DocumentSnapshot doc = snapshot.data!.docs[index];
                      return Dismissible(
                          // ドキュメントIDの特定し、リストの特定をするdocIDを取得
                          key: Key(doc.id),
                          // 左から右にスワイプしたときの背景（削除）
                          background: Container(
                            color: Colors.red,
                            child: Icon(Icons.delete),
                            alignment: Alignment.centerLeft,
                          ),
                          // 右にスワイプしかさせない設定
                          direction: DismissDirection.startToEnd,
                          onDismissed: (direction) {
                            // スワイプ方向が左から右の場合の処理
                            if (direction == DismissDirection.startToEnd) {
                              // ランダムに生成したドキュメントIDを取得
                              final fieldId = doc.id;
                              // Firestoreからfield_idからドキュメントIDを取得してドキュメントを削除
                              FirebaseFirestore.instance
                                  .collection('user')
                                  .doc(FirebaseAuth.instance.currentUser!.email)
                                  .collection('list')
                                  .doc(fieldId)
                                  .delete();
                            }
                          },
                          child: Card(
                            child: ListTile(
                              // それぞのdocumentに入ってるのitemの中身を表示
                              title: Text(doc["item"]),
                              subtitle: Text(
                                'Archived at ${DateFormat('yyyy/MM/dd HH:mm').format(doc['archiveDate'].toDate())}',
                                style: TextStyle(fontSize: 11),
                              ),
                              trailing: Wrap(children: [
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
                              ]),
                            ),
                          ));
                    }),
          );
        }));
  }
}
