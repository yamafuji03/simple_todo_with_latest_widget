// ドキュメントのランダムID作成
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

String makeRandomId(User user) {
  // 個々のuid内でランダムIDを生成し、戻り値をStringとして返す
  return FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection('list')
      .doc()
      .id;
}
