// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'field.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$NewListImpl _$$NewListImplFromJson(Map<String, dynamic> json) =>
    _$NewListImpl(
      item: json['item'] as String,
      randomId: json['randomId'] as String,
      listOrder: json['listOrder'] as int,
      done: json['done'] as bool,
      check: json['check'] as bool,
    );

Map<String, dynamic> _$$NewListImplToJson(_$NewListImpl instance) =>
    <String, dynamic>{
      'item': instance.item,
      'randomId': instance.randomId,
      'listOrder': instance.listOrder,
      'done': instance.done,
      'check': instance.check,
    };
