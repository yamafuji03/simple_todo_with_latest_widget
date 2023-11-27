import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_with_latest_widget/model/account/account.dart';
import 'package:simple_todo_with_latest_widget/ripository/account.dart';

final AccountProvider = StateNotifierProvider<AccountNotifier, Account>((ref) {
  return AccountNotifier();
});
