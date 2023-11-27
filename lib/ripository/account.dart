import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_with_latest_widget/model/account/account.dart';
import 'package:simple_todo_with_latest_widget/ripository/common_model.dart';

class AccountNotifier extends StateNotifier<Account> {
  AccountNotifier() : super(Account());

  Future<void> createAccount() async {
    FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .set(state
            .copyWith(
              registerDate: DateTime.now(),
              uid: FirebaseAuth.instance.currentUser!.uid,
              email: FirebaseAuth.instance.currentUser!.email,
            )
            .toJson());
  }
}
