// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'field.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

NewList _$NewListFromJson(Map<String, dynamic> json) {
  return _NewList.fromJson(json);
}

/// @nodoc
mixin _$NewList {
// この下に欲しい変数を書く
// 名前
  String get item => throw _privateConstructorUsedError;
  String get randomId => throw _privateConstructorUsedError;
  int get listOrder => throw _privateConstructorUsedError;
  bool get done => throw _privateConstructorUsedError;
  bool get check => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NewListCopyWith<NewList> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NewListCopyWith<$Res> {
  factory $NewListCopyWith(NewList value, $Res Function(NewList) then) =
      _$NewListCopyWithImpl<$Res, NewList>;
  @useResult
  $Res call(
      {String item, String randomId, int listOrder, bool done, bool check});
}

/// @nodoc
class _$NewListCopyWithImpl<$Res, $Val extends NewList>
    implements $NewListCopyWith<$Res> {
  _$NewListCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
    Object? randomId = null,
    Object? listOrder = null,
    Object? done = null,
    Object? check = null,
  }) {
    return _then(_value.copyWith(
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as String,
      randomId: null == randomId
          ? _value.randomId
          : randomId // ignore: cast_nullable_to_non_nullable
              as String,
      listOrder: null == listOrder
          ? _value.listOrder
          : listOrder // ignore: cast_nullable_to_non_nullable
              as int,
      done: null == done
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool,
      check: null == check
          ? _value.check
          : check // ignore: cast_nullable_to_non_nullable
              as bool,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$NewListImplCopyWith<$Res> implements $NewListCopyWith<$Res> {
  factory _$$NewListImplCopyWith(
          _$NewListImpl value, $Res Function(_$NewListImpl) then) =
      __$$NewListImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String item, String randomId, int listOrder, bool done, bool check});
}

/// @nodoc
class __$$NewListImplCopyWithImpl<$Res>
    extends _$NewListCopyWithImpl<$Res, _$NewListImpl>
    implements _$$NewListImplCopyWith<$Res> {
  __$$NewListImplCopyWithImpl(
      _$NewListImpl _value, $Res Function(_$NewListImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? item = null,
    Object? randomId = null,
    Object? listOrder = null,
    Object? done = null,
    Object? check = null,
  }) {
    return _then(_$NewListImpl(
      item: null == item
          ? _value.item
          : item // ignore: cast_nullable_to_non_nullable
              as String,
      randomId: null == randomId
          ? _value.randomId
          : randomId // ignore: cast_nullable_to_non_nullable
              as String,
      listOrder: null == listOrder
          ? _value.listOrder
          : listOrder // ignore: cast_nullable_to_non_nullable
              as int,
      done: null == done
          ? _value.done
          : done // ignore: cast_nullable_to_non_nullable
              as bool,
      check: null == check
          ? _value.check
          : check // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

@JsonSerializable(explicitToJson: true)
class _$NewListImpl implements _NewList {
  const _$NewListImpl(
      {required this.item,
      required this.randomId,
      required this.listOrder,
      required this.done,
      required this.check});

  factory _$NewListImpl.fromJson(Map<String, dynamic> json) =>
      _$$NewListImplFromJson(json);

// この下に欲しい変数を書く
// 名前
  @override
  final String item;
  @override
  final String randomId;
  @override
  final int listOrder;
  @override
  final bool done;
  @override
  final bool check;

  @override
  String toString() {
    return 'NewList(item: $item, randomId: $randomId, listOrder: $listOrder, done: $done, check: $check)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$NewListImpl &&
            (identical(other.item, item) || other.item == item) &&
            (identical(other.randomId, randomId) ||
                other.randomId == randomId) &&
            (identical(other.listOrder, listOrder) ||
                other.listOrder == listOrder) &&
            (identical(other.done, done) || other.done == done) &&
            (identical(other.check, check) || other.check == check));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, item, randomId, listOrder, done, check);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$NewListImplCopyWith<_$NewListImpl> get copyWith =>
      __$$NewListImplCopyWithImpl<_$NewListImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$NewListImplToJson(
      this,
    );
  }
}

abstract class _NewList implements NewList {
  const factory _NewList(
      {required final String item,
      required final String randomId,
      required final int listOrder,
      required final bool done,
      required final bool check}) = _$NewListImpl;

  factory _NewList.fromJson(Map<String, dynamic> json) = _$NewListImpl.fromJson;

  @override // この下に欲しい変数を書く
// 名前
  String get item;
  @override
  String get randomId;
  @override
  int get listOrder;
  @override
  bool get done;
  @override
  bool get check;
  @override
  @JsonKey(ignore: true)
  _$$NewListImplCopyWith<_$NewListImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
