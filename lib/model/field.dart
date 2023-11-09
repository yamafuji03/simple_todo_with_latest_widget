import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'field.freezed.dart';
part 'field.g.dart';

@freezed
class NewList with _$NewList {
  @JsonSerializable(explicitToJson: true)
  const factory NewList({
    // この下に欲しい変数を書く
// 名前

    required String item,
    required String randomId,
    required int listOrder,
    required bool done,
    required bool check,
  }) = _NewList;
// to/fromJsonを使うためのコマンド
  factory NewList.fromJson(Map<String, dynamic> json) =>
      _$NewListFromJson(json);
}



// 上の雛形とpartを描いた後、下のコマンドでgファイルを生成する。 watchは更新されたらその都度書き直してくれる。delete-conflicting-outputsは古いファイルを自動削除してくれるコマンド
// flutter pub run build_runner watch --delete-conflicting-outputs


// // 使い方
// // １、インスタンスの生成
// var NewList = NewList(name: "Suzuki")

// // ２、使う
// text('${NewList.name}')//インスタンス名.変数名