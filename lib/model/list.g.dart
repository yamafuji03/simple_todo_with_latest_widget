// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ListImpl _$$ListImplFromJson(Map<String, dynamic> json) => _$ListImpl(
      item: json['item'] as String?,
      id: json['id'] as String?,
      listOrder: json['listOrder'] as int?,
      done: json['done'] as bool?,
      check: json['check'] as bool?,
      createdAt:
          const TimestampConverter().fromJson(json['createdAt'] as Timestamp?),
      archiveDate: const TimestampConverter()
          .fromJson(json['archiveDate'] as Timestamp?),
    );

Map<String, dynamic> _$$ListImplToJson(_$ListImpl instance) =>
    <String, dynamic>{
      'item': instance.item,
      'id': instance.id,
      'listOrder': instance.listOrder,
      'done': instance.done,
      'check': instance.check,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'archiveDate': const TimestampConverter().toJson(instance.archiveDate),
    };
