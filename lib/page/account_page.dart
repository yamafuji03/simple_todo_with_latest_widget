import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:simple_todo_with_latest_widget/page/login_page.dart';

class accountPage extends StatelessWidget {
  const accountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Account Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You are logging in:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: CircleAvatar(
                    backgroundImage: NetworkImage(
                        FirebaseAuth.instance.currentUser!.photoURL!),
                  ),
                ),
                SizedBox(width: 10),
                Text(
                  '${FirebaseAuth.instance.currentUser!.email!}',
                  style: TextStyle(fontSize: 25),
                )
              ],
            ),
            SizedBox(height: 60),
            Column(
              children: [
                ElevatedButton(
                  child: Text(
                    'Sign out?',
                    style: TextStyle(fontSize: 30),
                  ),
                  onPressed: () async {
                    // Sign Out from Google
                    await GoogleSignIn().signOut();
                    // sign out from firebase
                    // await FirebaseAuth.instance.signOut();
                    await context.push('/LoginPage');
                  },
                ),
                SizedBox(height: 50),
                Text(
                  'or',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 50),
                ElevatedButton.icon(
                    icon: Icon(Icons.face),
                    label: Text('Delete your account?'),
                    onPressed: () {
                      showDialog(
                          // おまじない
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                                // ウインドウ左上に表示させるもの
                                title: Text(
                                  'Delete Account Mode',
                                  style: TextStyle(fontSize: 20),
                                ),
                                // 内容入力
                                content: Text('''You can't undo the action.
Your all lists will be deleted.'''),
                                actions: [
                                  Column(
                                    children: [
                                      Row(
                                        // mainAxisAlignment:
                                        //     MainAxisAlignment.start,
                                        children: [
                                          // it might be changed. good for now
                                          Checkbox(
                                            value: false,
                                            onChanged: (value) {
                                              true != value;
                                            },
                                          ),
                                          Text(
                                              'Yes, I want to delete my account'),
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          TextButton(
                                              child: Text("Cancel"),
                                              onPressed: () {
                                                context.pop();
                                              }),
                                          TextButton(
                                              child: Text("OK"),
                                              onPressed: () {
                                                // write if (true) {below} else{return}
                                                context.push('/LoginPage');
                                              }),
                                        ],
                                      ),
                                    ],
                                  )
                                ]);
                          });
                    })
              ],
            ),
          ],
        ),
      ),
    );
  }
}
