import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:simple_todo_with_latest_widget/view_model/crud_provider.dart';
import 'package:simple_todo_with_latest_widget/view_model/stream_provider.dart';

class archivePage extends HookConsumerWidget {
  const archivePage({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final crudState = ref.watch(crudProvider);
    final crudNotifier = ref.watch(crudProvider.notifier);

    final asyncValue = ref.watch(archivePageProvider);

    return Scaffold(
        appBar: AppBar(
          title: Text('Archive'),
        ),
        body: asyncValue.when(
          error: (error, _) => Text(error.toString()),
          loading: () => CircularProgressIndicator(),
          data: (snapshot) {
            return ListView.builder(
                itemCount: snapshot.docs.length,
                itemBuilder: (BuildContext context, int index) {
                  DocumentSnapshot doc = snapshot.docs[index];
                  return Dismissible(
                      // ドキュメントIDの特定し、リストの特定をするdocIDを取得
                      key: Key(doc.id),
                      background: Container(
                        color: Colors.blue,
                        child: Icon(Icons.restore_from_trash),
                        alignment: Alignment.centerLeft,
                      ),
                      secondaryBackground: Container(
                        color: Colors.red,
                        child: Icon(Icons.delete),
                        alignment: Alignment.centerRight,
                      ),
                      onDismissed: (direction) async {
                        // swipe left to right. return to List Page
                        crudNotifier.toList(index: index);

                        // スワイプ方向が左から右の場合の処理
                        if (direction == DismissDirection.endToStart) {
                          // swipe right to left for delete the list
                          await crudNotifier.deleteFromArchive(index: index);
                        }
                      },
                      child: Card(
                        child: ListTile(
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
                                crudNotifier.checkFromArchive(index: index);
                              },
                            ),
                          ]),
                        ),
                      ));
                });
          },
        ));
  }
}
