import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetStream {
  final _firestore = FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection('list');

  // for listPage
  Stream<QuerySnapshot> snapshotToListPage() {
    return _firestore
        .where('done', isEqualTo: false)
        .orderBy('listOrder')
        .snapshots();
  }

  // for archivePage
  Stream<QuerySnapshot> snapshotToArchivePage() {
    return _firestore
        .where('done', isEqualTo: true)
        .orderBy('archiveDate')
        .snapshots();
  }
}
