import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OrderNotifier extends StateNotifier<int> {
  OrderNotifier() : super(0);

  final _firestore = FirebaseFirestore.instance
      .collection('user')
      .doc(FirebaseAuth.instance.currentUser!.email)
      .collection('list');

  void order({required int oldIndex, required int newIndex}) async {
    final _snapshot = await FirebaseFirestore.instance
        .collection('user')
        .doc(FirebaseAuth.instance.currentUser!.email)
        .collection('list')
        .where('done', isEqualTo: false)
        .orderBy('listOrder')
        .get();

    if (oldIndex < newIndex) {
      // 動かすドキュメントIDを取得

      final moveId = _snapshot.docs[oldIndex].id;
      _firestore.doc(moveId).update({
        // newIndexだと最大値プラス１が取れてしまうため、マイナス１で移動先リストと同じindexになるように調整
        'listOrder': newIndex - 1,
      });

      // ここでforでそれ以外のorderをマイナス１にする
      // 始まりを「１」とするのはorderの値をマイナス１してることから１始まりにしないとorder番号がマイナスになる可能性が出るから
      for (int i = 1; i <= newIndex - 1; i = i + 1) {
        // 他のドキュメントのIDを取得
        final otherId = _snapshot.docs[i].id;
        // 移動させたリストと古いリストのorderが被っているから、もし移動したIDとiのIDが違うなら処理を実行とする。
        if (moveId != otherId) {
          _firestore.doc(otherId).update({
            // orderをi-1にして選択されていないリストの中にあるorderを１ずらす
            'listOrder': i - 1,
          });
        }
      }
    } else {
      // 動かすドキュメントIDを取得
      final moveId = _snapshot.docs[oldIndex].id;

      // ここでforでそれ以外のorderをプラス１にする
      // 始まりを「newIndex」として仮に3から2へ移動する際にorder1には影響が出ないようにする
      for (int i = newIndex; i <= oldIndex; i = i + 1) {
        // 他のドキュメントのIDを取得
        final otherId = _snapshot.docs[i].id;
        // 移動させたリストと古いリストのorderが被ってないなら、orderをプラス１して並び替える。
        if (moveId != otherId) {
          _firestore.doc(otherId).update({
            'listOrder': i + 1,
          });
        }
      }
      _firestore.doc(moveId).update({
        // newIndexをそのままorder番号にする
        'listOrder': newIndex,
      });
    }
  }
}
