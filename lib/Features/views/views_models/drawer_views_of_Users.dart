import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:getwidget/getwidget.dart';
import 'package:raya/Features/constens/conestans.dart';

class DrawerView extends StatelessWidget {
  const DrawerView({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Scaffold(
        body: Center(
          child: Text('User is not signed in'),
        ),
      );
    }

    List<UserInfo?> providerData = user.providerData;
    String? photoUrl = providerData
            .any((element) => element!.providerId.contains('google.com'))
        ? user.photoURL
        : null;
    return GFDrawer(
      color: KPrimaryColor,
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          GFDrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.green,
            ),
            centerAlign: true,
            currentAccountPicture: Container(
              alignment: Alignment.center,
              child: CircleAvatar(
                backgroundImage:
                    photoUrl != null ? NetworkImage(photoUrl) : null,
                radius: 40,
                child: photoUrl == null ? const Icon(Icons.person) : null,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 8),
                Text(
                  user.providerData.any((element) =>
                          element.providerId.contains('google.com'))
                      ? user.displayName ?? 'Unknown User'
                      : user.email ?? 'Unknown User',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: KPrimaryColor,
              minimumSize: const Size(40, 40),
            ),
            onPressed: () async {
              await signOut();
            },
            icon: const Icon(
              Icons.arrow_back,
              size: 32,
            ),
            label: const Text(
              'Sign Out',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
