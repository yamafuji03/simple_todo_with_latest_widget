import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_with_latest_widget/ripository/common_model.dart';
import 'package:simple_todo_with_latest_widget/model/list.dart';

class RepositoryNotifier extends StateNotifier<List> {
  RepositoryNotifier() : super(List());

  final _firestore = FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection('list');

  Future<void> add({required String newText}) async {
    // retrieve from CommonFunction
    final _randomId = CommonFunction.makeRandomId();
    final _listOrder = await CommonFunction.listOrderLength();

    _firestore.doc(_randomId).set(state
        .copyWith(
          item: newText,
          id: _randomId,
          listOrder: _listOrder,
          done: false,
          createdAt: DateTime.now(),
          check: false,
          archiveDate: DateTime.now(),
        )
        .toJson());
  }

  Future<void> upDate({required String newText, required int index}) async {
    final _snapshot = await _firestore
        .orderBy(
            'listOrder') //why is this needed? that is to order lists by ListOrder
        .get();

    final docId = _snapshot.docs[index].id;

    _firestore.doc(docId).update({
      'item': newText,
      'createdAt': DateTime.now(),
    });
  }

  Future<void> deleteFromList({required int index}) async {
    final _snapshot = await _firestore.orderBy('listOrder').get();

    final docId = _snapshot.docs[index].id;

    await _firestore.doc(docId).delete();
  }

  Future<void> checkFromList({required int index}) async {
    final _snapshot = await _firestore.orderBy('listOrder').get();

    final docId = _snapshot.docs[index].id;
    final doc = _snapshot.docs[index].data();

    if (doc['check'] == false) {
      _firestore.doc(docId).update({'check': true});
    } else {
      _firestore.doc(docId).update({'check': false});
    }
  }

  Future<void> checkFromArchive({required int index}) async {
    final _snapshot = await _firestore
        .where('done', isEqualTo: true)
        .orderBy('archiveDate')
        .get();

    final docId = _snapshot.docs[index].id;
    final doc = _snapshot.docs[index].data();

    if (doc['check'] == false) {
      _firestore.doc(docId).update({'check': true});
    } else {
      _firestore.doc(docId).update({'check': false});
    }
  }

  Future<void> toArchive({required int index}) async {
    final _snapshot = await _firestore.orderBy('listOrder').get();

    final docId = _snapshot.docs[index].id;

    _firestore.doc(docId).update({
      'done': true,
      'listOrder': FieldValue.delete(),
      'archiveDate': DateTime.now(),
    });
  }

  Future<void> toList({required int index}) async {
    final _snapshot = await _firestore
        .where('done', isEqualTo: true)
        .orderBy('archiveDate')
        .get();
    final docId = _snapshot.docs[index].id;

    _firestore.doc(docId).update({'listOrder': 0, 'done': false});
  }

  Future<void> deleteFromArchive({required int index}) async {
    final _snapshot = await _firestore
        .where('done', isEqualTo: true)
        .orderBy('archiveDate')
        .get();
    final docId = _snapshot.docs[index].id;

    _firestore.doc(docId).delete();
  }
}