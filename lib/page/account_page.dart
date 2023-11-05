import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:simple_todo_with_latest_widget/page/login_page.dart';
import 'package:simple_todo_with_latest_widget/view_model/account_page_view_model.dart';

class accountPage extends StatelessWidget {
  const accountPage({super.key});

  @override
  Widget build(BuildContext context) {
    bool isChanged = false;
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
                    // sign out from firebase
                    await signOut();
                    context.go('/LoginPage');
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
                            // might take away 　Statefulbuilder when refactoring with riverpod
                            return StatefulBuilder(
                                builder: (context, setState) {
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
                                            Checkbox(
                                              value: isChanged,
                                              onChanged: (value) {
                                                setState(() {
                                                  isChanged != value;
                                                });
                                              },
                                            ),
                                            Text(
                                                'Yes, I will delete my account'),
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
                                                onPressed: () async {
                                                  // wrap up later with if statement after making switch
                                                  // delete each of documents in list
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('user')
                                                      .doc(FirebaseAuth.instance
                                                          .currentUser!.email)
                                                      .collection('list')
                                                      .get()
                                                      .asStream()
                                                      .forEach((element) {
                                                    for (var element
                                                        in element.docs) {
                                                      element.reference
                                                          .delete();
                                                    }
                                                  });
                                                  // delete email document
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('user')
                                                      .doc(FirebaseAuth.instance
                                                          .currentUser!.email)
                                                      .delete();
                                                  await signOut();
                                                  context.go('/LoginPage');
                                                }),
                                          ],
                                        ),
                                      ],
                                    )
                                  ]);
                            });
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
