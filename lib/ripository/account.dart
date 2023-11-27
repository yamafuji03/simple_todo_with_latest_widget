import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_with_latest_widget/auth/auth.dart';
import 'package:simple_todo_with_latest_widget/model/account/account.dart';
import 'package:simple_todo_with_latest_widget/ripository/common_model.dart';

class AccountNotifier extends StateNotifier<Account> {
  AccountNotifier() : super(Account());

  Future<void> createAccount() async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .set(state
            .copyWith(
              registerDate: DateTime.now(),
              uid: FirebaseAuth.instance.currentUser!.uid,
              email: FirebaseAuth.instance.currentUser!.email!,
            )
            .toJson());
  }

  Future<void> deleteAccount() async {
    await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('list')
        .get()
        .asStream()
        .forEach((element) {
      for (var element in element.docs) {
        element.reference.delete();
      }
    });
    // delete email document
    await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .delete();
    await Authentication.signOut();
  }
}
