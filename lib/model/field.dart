import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'field.freezed.dart';
part 'field.g.dart';

@freezed
class NewList with _$NewList {
  @JsonSerializable(explicitToJson: true)
  const factory NewList({


    required String item,
    required String randomId,
    required int listOrder,
    required bool done,
    required bool check,
  }) = _NewList;

  factory NewList.fromJson(Map<String, dynamic> json) =>
      _$NewListFromJson(json);
}



