import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'package:simple_todo_with_latest_widget/ripository/stream.dart';

final getStream = GetStream();
//  for listPage
final listPageProvider = StreamProvider((ref) {
  return getStream.snapshotToListPage();
});
// for archivePage
final archivePageProvider = StreamProvider((ref) {
  return getStream.snapshotToArchivePage();
});
