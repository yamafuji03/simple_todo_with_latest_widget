import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_with_latest_widget/model/list.dart';
import 'package:simple_todo_with_latest_widget/ripository/crud.dart';

final repositoryProvider =
    StateNotifierProvider<RepositoryNotifier, List>((ref) {
  return RepositoryNotifier();
});
