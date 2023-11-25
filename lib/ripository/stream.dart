import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class GetStream {
  // for listPage
  Stream<QuerySnapshot> snapshotToListPage() {
    return FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('list')
        .where('done', isEqualTo: false)
        .orderBy('listOrder')
        .snapshots();
  }

  // for archivePage
  Stream<QuerySnapshot> snapshotToArchivePage() {
    return FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('list')
        .where('done', isEqualTo: true)
        .orderBy('archiveDate')
        .snapshots();
  }
}
