// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NewListImpl _$$NewListImplFromJson(Map<String, dynamic> json) =>
    _$NewListImpl(
      item: json['item'] as String? ?? '',
      randomId: json['randomId'] as String? ?? '',
      listOrder: json['listOrder'] as int? ?? 0,
      done: json['done'] as bool? ?? false,
      check: json['check'] as bool? ?? false,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp?),
      archiveDate: const TimestampConverter()
          .fromJson(json['archiveDate'] as Timestamp?),
    );

Map<String, dynamic> _$$NewListImplToJson(_$NewListImpl instance) =>
    <String, dynamic>{
      'item': instance.item,
      'randomId': instance.randomId,
      'listOrder': instance.listOrder,
      'done': instance.done,
      'check': instance.check,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'archiveDate': const TimestampConverter().toJson(instance.archiveDate),
    };
