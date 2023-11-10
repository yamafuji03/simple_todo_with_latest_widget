import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'list_page_riverpod.g.dart';

@riverpod
class Newtext extends _$Newtext {
  @override
  String build() {
    return state = "";
  }

  void changeText(String text) {
    state = text;
  }
}
