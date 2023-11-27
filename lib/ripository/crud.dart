import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_with_latest_widget/model/list/list.dart';
import 'package:simple_todo_with_latest_widget/ripository/common_model.dart';

class CrudNotifier extends StateNotifier<List> {
  CrudNotifier() : super(List());

  final _firestore = FirebaseFirestore.instance.collection('user');


  Future<void> add({required String newText}) async {
    // retrieve from CommonFunction
    final _randomId = CommonFunction.makeRandomId();
    final _listOrder = await CommonFunction.getListOrderLength();

    _firestore
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('list')
        .doc(_randomId)
        .set(state
            .copyWith(
              item: newText,
              id: _randomId,
              listOrder: _listOrder,
              done: false,
              createdAt: DateTime.now(),
              check: false,
              archiveDate: null,
            )
            .toJson());
  }

  Future<void> upDate({required String newText, required int index}) async {
    final _snapshot = await _firestore
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('list')
        .orderBy(
            'listOrder') //why is this needed? that is to order lists by ListOrder
        .get();

    final docId = _snapshot.docs[index].id;

    _firestore
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('list')
        .doc(docId)
        .update({
      'item': newText,
      'createdAt': DateTime.now(),
    });
  }

  Future<void> deleteFromList({required int index}) async {
    final _snapshot = await _firestore
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('list')
        .orderBy('listOrder')
        .get();

    final docId = _snapshot.docs[index].id;

    await _firestore
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('list')
        .doc(docId)
        .delete();
  }

  Future<void> checkFromList({required int index}) async {
    final _snapshot = await _firestore
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('list')
        .orderBy('listOrder')
        .get();

    final docId = _snapshot.docs[index].id;
    final doc = _snapshot.docs[index].data();

    if (doc['check'] == false) {
      _firestore
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('list')
          .doc(docId)
          .update({'check': true});
    } else {
      _firestore
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('list')
          .doc(docId)
          .update({'check': false});
    }
  }

  Future<void> checkFromArchive({required int index}) async {
    final _snapshot = await _firestore
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('list')
        .where('done', isEqualTo: true)
        .orderBy('archiveDate')
        .get();

    final docId = _snapshot.docs[index].id;
    final doc = _snapshot.docs[index].data();

    if (doc['check'] == false) {
      _firestore
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('list')
          .doc(docId)
          .update({'check': true});
    } else {
      _firestore
          .doc(FirebaseAuth.instance.currentUser!.email)
          .collection('list')
          .doc(docId)
          .update({'check': false});
    }
  }

  Future<void> toArchive({required int index}) async {
    final _snapshot = await _firestore
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('list')
        .orderBy('listOrder')
        .get();

    final docId = _snapshot.docs[index].id;

    _firestore
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('list')
        .doc(docId)
        .update({
      'done': true,
      'listOrder': FieldValue.delete(),
      'archiveDate': DateTime.now(),
    });
  }

  Future<void> toList({required int index}) async {
    final _snapshot = await _firestore
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('list')
        .where('done', isEqualTo: true)
        .orderBy('archiveDate')
        .get();
    final docId = _snapshot.docs[index].id;

    _firestore
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('list')
        .doc(docId)
        .update({
      'listOrder': 0,
      'done': false,
      'archiveDate': null,
    });
  }

  Future<void> deleteFromArchive({required int index}) async {
    final _snapshot = await _firestore
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('list')
        .where('done', isEqualTo: true)
        .orderBy('archiveDate')
        .get();
    final docId = _snapshot.docs[index].id;

    await _firestore
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('list')
        .doc(docId)
        .delete();
  }
}
