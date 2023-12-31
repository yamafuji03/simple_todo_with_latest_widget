import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:simple_todo_with_latest_widget/auth/auth.dart';
import 'package:simple_todo_with_latest_widget/view_model/account_provider.dart';

class accountPage extends HookConsumerWidget {
  const accountPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final accountNotifier = ref.watch(AccountProvider.notifier);
    bool isChanged = false;
    return Scaffold(
      appBar: AppBar(title: Text('Account Page')),
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
                    await Authentication.signOut();
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
           
                            return StatefulBuilder(
                                builder: (context, setState) {
                              return AlertDialog(
                                  // ウインドウ左上に表示させるもの
                                  title: Text(
                                    'Delete Account Mode',
                                    style: TextStyle(fontSize: 20),
                                  ),
                                  // 内容入力
                                  content: Text('''You can NOT undo the action.
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
                                              onChanged: (_) {
                                           

                                                setState(() {
                                                  // to switch on and off
                                                  isChanged = !isChanged;
                                                });
                                              },
                                            ),
                                            Text(
                                                'Yes, I will delete my account.'),
                                          ],
                                        ),
                                        ElevatedButton(
                                          child: Text('Delete'),
                                          onPressed: !isChanged
                                              ? null
                                              : () async {
                                                  if (isChanged == true) {
                                                    accountNotifier
                                                        .deleteAccount();
                                                    context.go('/LoginPage');
                                                  }
                                                },
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
