import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_with_latest_widget/ripository/other_service/order.dart';

final orderProvider = StateNotifierProvider<OrderNotifier, int>((ref) {
  return OrderNotifier();
});
