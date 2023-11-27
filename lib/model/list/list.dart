import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:simple_todo_with_latest_widget/model/date_converter.dart';
part 'list.freezed.dart';
part 'list.g.dart';

@freezed
class List with _$List {
  const factory List({
    String? item,
    String? id,
    int? listOrder,
    bool? done,
    bool? check,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? archiveDate,
  }) = _List;
  factory List.fromJson(Map<String, dynamic> json) => _$ListFromJson(json);
}
