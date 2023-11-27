// go_routerでinitialページ
import 'package:firebase_auth/firebase_auth.dart';

String firstPage() {
  if (FirebaseAuth.instance.currentUser == null) {
    return '/LoginPage';
  } else {
    return '/ListPage';
  }
}
