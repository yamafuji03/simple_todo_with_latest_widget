import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

// signOut from firebase and google
Future<void> signOut() async {
  // sign out from firebase
  await FirebaseAuth.instance.signOut();
  // Sign Out from Google
  await GoogleSignIn().signOut();
}
