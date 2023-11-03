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

// google sign inでログイン
Future<void> signInWithGoogle() async {
  // GoogleSignIn をして得られた情報を Firebase と関連づける
  final googleUser =
      await GoogleSignIn(scopes: ['profile', 'email']) //アプリ登録を考えるとemailだけでいいかも？
          .signIn();

  final googleAuth = await googleUser?.authentication;
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  await FirebaseAuth.instance.signInWithCredential(credential);
  // googleユーザーネーム表示
  print('ユーザー情報:${FirebaseAuth.instance.currentUser?.displayName}');
  print('ユーザー情報:${FirebaseAuth.instance.currentUser?.email}');
}
