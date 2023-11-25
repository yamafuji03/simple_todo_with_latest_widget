import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_with_latest_widget/ripository/common_model.dart';
import 'package:simple_todo_with_latest_widget/model/list.dart';

class RepositoryNotifier extends StateNotifier<List> {
  RepositoryNotifier() : super(List());

  Future<void> add({required String newText}) async {
    // retrieve from CommonFunction
    final randomId = CommonFunction.makeRandomId();
    final listOrder = await CommonFunction.listOrderLength();

    FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('list')
        .doc(randomId)
        .set(state
            .copyWith(
              item: newText,
              id: randomId,
              listOrder: listOrder,
              done: false,
              createdAt: DateTime.now(),
              check: false,
              archiveDate: DateTime.now(),
            )
            .toJson());
  }

  Future<void> upDate({required String newText, required int index}) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('list')
        .orderBy(
            'listOrder') //why is this needed? that is to order lists by ListOrder
        .get();

    final docId = snapshot.docs[index].id;

    FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('list')
        .doc(docId)
        .update({
      'item': newText,
      'createdAt': DateTime.now(),
    });
  }

  Future<void> delete({required int index}) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('list')
        .orderBy('listOrder')
        .get();

    final docId = snapshot.docs[index].id;

    // Firestoreからfield_idからドキュメントIDを取得してドキュメントを削除
    await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('list')
        .doc(docId)
        .delete();
  }

  Future<void> done({required int index}) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('list')
        .orderBy('listOrder')
        .get();

    final docId = snapshot.docs[index].id;
    final doc = snapshot.docs[index].data();

    if (doc['check'] == false) {
      FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('list')
          .doc(docId)
          .update({'check': true});
    } else {
      FirebaseFirestore.instance
          .collection('user')
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('list')
          .doc(docId)
          .update({'check': false});
    }
  }

  Future<void> toArchive({required int index}) async {
    final snapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('list')
        .orderBy('listOrder')
        .get();

    final docId = snapshot.docs[index].id;

    FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('list')
        .doc(docId)
        .update({
      'done': true,
      'listOrder': FieldValue.delete(),
      'archiveDate': DateTime.now(),
    });
  }

  // 次アーカイブからリストに戻すのとアーカイブの中で削除（ソートの仕方が違うため別途作る必要がある）
}
