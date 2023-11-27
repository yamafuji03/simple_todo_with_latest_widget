// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AccountImpl _$$AccountImplFromJson(Map<String, dynamic> json) =>
    _$AccountImpl(
      email: json['email'] as String?,
      uid: json['uid'] as String?,
      registerDate: const TimestampConverter()
          .fromJson(json['registerDate'] as Timestamp?),
    );

Map<String, dynamic> _$$AccountImplToJson(_$AccountImpl instance) =>
    <String, dynamic>{
      'email': instance.email,
      'uid': instance.uid,
      'registerDate': const TimestampConverter().toJson(instance.registerDate),
    };
