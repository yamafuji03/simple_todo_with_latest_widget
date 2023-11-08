import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'account_page_riverpod.g.dart';

// appbar title for practice
@riverpod
String appbarTitle(AppbarTitleRef ref) {
  return 'Account Page';
}

// middle of comment
@riverpod
String accountName(AccountNameRef ref) {
  return "You are logging in:";
}
