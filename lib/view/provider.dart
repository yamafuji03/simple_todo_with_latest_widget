import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_with_latest_widget/model/list.dart';
import 'package:simple_todo_with_latest_widget/ripository/ripository.dart';

final repositoryProvider =
    StateNotifierProvider<RepositoryNotifier, List>((ref) {
  return RepositoryNotifier();
});
