// go_routerでinitialページ
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

// void firstPage(){if(FirebaseAuth.instance.currentUser == null) {変数==LOGIN PAGE} ELSE {変数==LISTPAGE}}

// google sign in でログイン登録
Future<void> signInWithGoogle() async {
  // GoogleSignIn をして得られた情報を Firebase と関連づける
  final googleUser = await GoogleSignIn(scopes: ['profile', 'email']).signIn();

  final googleAuth = await googleUser?.authentication;
  final credential = GoogleAuthProvider.credential(
    accessToken: googleAuth?.accessToken,
    idToken: googleAuth?.idToken,
  );

  await FirebaseAuth.instance.signInWithCredential(credential);
  print('ユーザー情報:${FirebaseAuth.instance.currentUser?.displayName}');
}
