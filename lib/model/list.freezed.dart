// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'list.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

List _$ListFromJson(Map<String, dynamic> json) {
  return _List.fromJson(json);
}

/// @nodoc
mixin _$List {
  String? get item => throw _privateConstructorUsedError;
  String? get id => throw _privateConstructorUsedError;
  int? get listOrder => throw _privateConstructorUsedError;
  bool? get done => throw _privateConstructorUsedError;
  bool? get check => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get createdAt => throw _privateConstructorUsedError;
  @TimestampConverter()
  DateTime? get archiveDate => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ListCopyWith<List> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ListCopyWith<$Res> {
  factory $ListCopyWith(List value, $Res Function(List) then) =
      _$ListCopyWithImpl<$Res, List>;
  @useResult
  $Res call(
      {String? item,
      String? id,
      int? listOrder,
      bool? done,
      bool? check,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? archiveDate});
}

/// @nodoc
class _$ListCopyWithImpl<$Res, $Val extends List>
    implements $ListCopyWith<$Res> {
  _$ListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = freezed,
    Object? id = freezed,
    Object? listOrder = freezed,
    Object? done = freezed,
    Object? check = freezed,
    Object? createdAt = freezed,
    Object? archiveDate = freezed,
  }) {
    return _then(_value.copyWith(
      item: freezed == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      listOrder: freezed == listOrder
          ? _value.listOrder
          : listOrder // ignore: cast_nullable_to_non_nullable
              as int?,
      done: freezed == done
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool?,
      check: freezed == check
          ? _value.check
          : check // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      archiveDate: freezed == archiveDate
          ? _value.archiveDate
          : archiveDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ListImplCopyWith<$Res> implements $ListCopyWith<$Res> {
  factory _$$ListImplCopyWith(
          _$ListImpl value, $Res Function(_$ListImpl) then) =
      __$$ListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? item,
      String? id,
      int? listOrder,
      bool? done,
      bool? check,
      @TimestampConverter() DateTime? createdAt,
      @TimestampConverter() DateTime? archiveDate});
}

/// @nodoc
class __$$ListImplCopyWithImpl<$Res>
    extends _$ListCopyWithImpl<$Res, _$ListImpl>
    implements _$$ListImplCopyWith<$Res> {
  __$$ListImplCopyWithImpl(_$ListImpl _value, $Res Function(_$ListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = freezed,
    Object? id = freezed,
    Object? listOrder = freezed,
    Object? done = freezed,
    Object? check = freezed,
    Object? createdAt = freezed,
    Object? archiveDate = freezed,
  }) {
    return _then(_$ListImpl(
      item: freezed == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      listOrder: freezed == listOrder
          ? _value.listOrder
          : listOrder // ignore: cast_nullable_to_non_nullable
              as int?,
      done: freezed == done
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool?,
      check: freezed == check
          ? _value.check
          : check // ignore: cast_nullable_to_non_nullable
              as bool?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime?,
      archiveDate: freezed == archiveDate
          ? _value.archiveDate
          : archiveDate // ignore: cast_nullable_to_non_nullable
              as DateTime?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ListImpl implements _List {
  const _$ListImpl(
      {this.item,
      this.id,
      this.listOrder,
      this.done,
      this.check,
      @TimestampConverter() this.createdAt,
      @TimestampConverter() this.archiveDate});

  factory _$ListImpl.fromJson(Map<String, dynamic> json) =>
      _$$ListImplFromJson(json);

  @override
  final String? item;
  @override
  final String? id;
  @override
  final int? listOrder;
  @override
  final bool? done;
  @override
  final bool? check;
  @override
  @TimestampConverter()
  final DateTime? createdAt;
  @override
  @TimestampConverter()
  final DateTime? archiveDate;

  @override
  String toString() {
    return 'List(item: $item, id: $id, listOrder: $listOrder, done: $done, check: $check, createdAt: $createdAt, archiveDate: $archiveDate)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ListImpl &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.listOrder, listOrder) ||
                other.listOrder == listOrder) &&
            (identical(other.done, done) || other.done == done) &&
            (identical(other.check, check) || other.check == check) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.archiveDate, archiveDate) ||
                other.archiveDate == archiveDate));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, item, id, listOrder, done, check, createdAt, archiveDate);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ListImplCopyWith<_$ListImpl> get copyWith =>
      __$$ListImplCopyWithImpl<_$ListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ListImplToJson(
      this,
    );
  }
}

abstract class _List implements List {
  const factory _List(
      {final String? item,
      final String? id,
      final int? listOrder,
      final bool? done,
      final bool? check,
      @TimestampConverter() final DateTime? createdAt,
      @TimestampConverter() final DateTime? archiveDate}) = _$ListImpl;

  factory _List.fromJson(Map<String, dynamic> json) = _$ListImpl.fromJson;

  @override
  String? get item;
  @override
  String? get id;
  @override
  int? get listOrder;
  @override
  bool? get done;
  @override
  bool? get check;
  @override
  @TimestampConverter()
  DateTime? get createdAt;
  @override
  @TimestampConverter()
  DateTime? get archiveDate;
  @override
  @JsonKey(ignore: true)
  _$$ListImplCopyWith<_$ListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
