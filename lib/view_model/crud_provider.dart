import 'package:simple_todo_with_latest_widget/model/list/list.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_with_latest_widget/ripository/crud.dart';

final crudProvider = StateNotifierProvider<CrudNotifier, List>((ref) {
  return CrudNotifier();
});
