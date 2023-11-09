import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'field.freezed.dart';
part 'field.g.dart';

@freezed
class NewList with _$NewList {
  @JsonSerializable(explicitToJson: true)
  const factory NewList({
    @Default('') String item,
    @Default('') String randomId,
    @Default(0) int listOrder,
    @Default(false) bool done,
    @Default(false) bool check,
    @TimestampConverter() DateTime? createdAt,
    @TimestampConverter() DateTime? archiveDate,
  }) = _NewList;
  factory NewList.fromJson(Map<String, dynamic> json) =>
      _$NewListFromJson(json);
}

// converter for date
class TimestampConverter implements JsonConverter<DateTime?, Timestamp?> {
  const TimestampConverter();
  @override
  DateTime? fromJson(Timestamp? json) => json?.toDate();

  @override
  Timestamp? toJson(DateTime? object) =>
      object == null ? null : Timestamp.fromDate(object);
}
