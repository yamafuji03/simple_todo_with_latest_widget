import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

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

// signOut from firebase and google
Future<void> signOut() async {
  // sign out from firebase
  await FirebaseAuth.instance.signOut();
  // Sign Out from Google
  await GoogleSignIn().signOut();
}
