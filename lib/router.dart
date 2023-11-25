// go_routerでinitialページ
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

String firstPage() {
  if (FirebaseAuth.instance.currentUser == null) {
    return '/LoginPage';
  } else {
    return '/ListPage'; //ある程度作ったら、'/ListPage'　に切り変える
    // return '/LoginPage';
  }
}
