// ignore_for_file: file_names

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:raya/main.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../constens/conestans.dart';
import '../home/Register_Page.dart';
import 'Forgot_Pasword_Page.dart';
import 'logIn_dmin_Page_views.dart';

class LogInPageView extends StatefulWidget {
  const LogInPageView({Key? key}) : super(key: key);

  @override
  State<LogInPageView> createState() => _LogInPageViewState();
}

class _LogInPageViewState extends State<LogInPageView> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    navigateKeyCircle.call();
    super.dispose();
  }

  Future<UserCredential?> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser =
        await GoogleSignIn(scopes: <String>['email']).signIn();

    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    await saveUsers(googleUser);
    return await FirebaseAuth.instance.signInWithCredential(credential);
  }

  Future<UserCredential?> saveUsers(GoogleSignInAccount? account) async {
    if (account != null) {
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(account.email)
          .set({
        "email": account.email,
        "name": account.displayName,
        "profilePic": account.photoUrl,
      });
      if (kDebugMode) {
        print('... save user ...');
      }
    } else {
      if (kDebugMode) {
        print('... save user failed: account is null ...');
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          const LogInAdminPageView(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: emailController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'Email',
                labelStyle: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[600]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
              validator: (email) {
                if (email!.isEmpty) {
                  return 'Enter a valid email address';
                }
                return null;
              },
            ),
          ),
          const SizedBox(
            height: 2,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: passwordController,
              cursorColor: Colors.white,
              textInputAction: TextInputAction.next,
              decoration: InputDecoration(
                labelText: 'password',
                labelStyle: TextStyle(
                  color: Colors.grey[600],
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide(color: Colors.grey[600]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.white),
                ),
              ),
              obscureText: true,
              validator: (password) {
                if (password!.isEmpty) {
                  return 'Enter a password';
                }
                return null;
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  child: const Text(
                    'Forgot Password',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: Colors.orange,
                      fontSize: 15,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => const ForgotPasswordPage()));
                  },
                ),
              ],
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: KAppBarColors,
            ),
            onPressed: () async {
              await signIn();
            },
            icon: const Icon(
              Icons.lock_open,
            ),
            label: const Text(
              'Sign In',
              style: TextStyle(
                fontSize: 24,
              ),
            ),
          ),
          const SizedBox(
            height: 8,
          ),

          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(color: Colors.black),
                  text: 'Don`t have account!',
                ),
              ),
              TextButton(
                onPressed: () {
                  Get.to(() => const RegisterPage());
                },
                child: const Text(
                  'Register',
                  style: TextStyle(
                    color: Colors.orange,
                  ),
                ),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text('Or Sign In with '),
              Text(
                'Google',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          // Container(
          //   width: 150,
          //   height: 2,
          //   decoration: BoxDecoration(
          //     color: Colors.black,
          //     borderRadius: BorderRadius.circular(15),
          //     boxShadow: [
          //       BoxShadow(
          //         color: Colors.grey[400]!,
          //         offset: const Offset(0, 2),
          //         blurRadius: 6,
          //       ),
          //     ],
          //   ),
          // ),
          const SizedBox(
            height: 15,
          ),
          ////////////////////
          GestureDetector(
            onTap: () {
              signInWithGoogle();
            },
            child: CircleAvatar(
              backgroundColor: KPrimaryColor,
              radius: 25,
              child: Image.asset(
                'assets/google.png',
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future signIn() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      // Check if user's email already exists in Firestore
      final user = userCredential.user!;
      final userRef =
          FirebaseFirestore.instance.collection('Users').doc(user.uid);
      final userDoc = await userRef.get();
      if (!userDoc.exists) {
        // Save user's email in Firestore
        await userRef.set({
          'email': user.email,
        });
      }
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Navigator.pop(context);
      String errorMessage = e.message ?? 'An error occurred, please try again.';
      return AwesomeDialog(
              context: context,
              title: 'Error',
              body: Column(
                children: <Widget>[
                  Text(errorMessage),
                ],
              ),
              dialogType: DialogType.error)
          .show();
    }
    navigateKeyCircle();
  }

  void navigateKeyCircle() {
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }
}
