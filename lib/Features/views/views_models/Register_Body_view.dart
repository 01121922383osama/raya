// ignore_for_file: file_names

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:raya/Features/constens/conestans.dart';
import '../widget/Custom_App_Bar.dart';

class RegisterBodyPage extends StatefulWidget {
  const RegisterBodyPage({super.key});

  @override
  State<RegisterBodyPage> createState() => _RegisterBodyPageState();
}

class _RegisterBodyPageState extends State<RegisterBodyPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const CustomAppBar(),
            const Text(
              'Hey There, \n Welcome Back',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 10,
            ),
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
                  email != null && !EmailValidator.validate(email)
                      ? 'Enter Your Password'
                      : null;
                  return null;
                },
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: passwordController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
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
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(40, 40),
                backgroundColor: KAppBarColors,
              ),
              onPressed: () {
                signUp();
              },
              icon: const Icon(
                Icons.admin_panel_settings,
                size: 35,
              ),
              label: const Text(
                'Sign Up',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> signUp() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    final RegExp emailRegex = RegExp('@gmail.com');
    if (!emailRegex.hasMatch(emailController.text.trim())) {
      AwesomeDialog(
        context: context,
        title: 'Error',
        body: Column(
          children: const <Widget>[
            Text('Please provide a valid Google email address.'),
          ],
        ),
        dialogType: DialogType.error,
      ).show();
      return;
    }

    try {
      final userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      final email = userCredential.user!.email;
      await FirebaseFirestore.instance
          .collection('Users')
          .doc(email)
          .set({'email': email});
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      if (e.code == 'weak-password') {
        AwesomeDialog(
          context: context,
          title: 'Error',
          body: Column(
            children: const <Widget>[
              Text('The password provided is too weak.'),
            ],
          ),
          dialogType: DialogType.error,
        ).show().then((_) => Navigator.pop(context));
      } else if (e.code == 'invalid-email') {
        AwesomeDialog(
          context: context,
          title: 'Error',
          body: Column(
            children: const <Widget>[
              Text('Please provide a valid email address.'),
            ],
          ),
          dialogType: DialogType.error,
        ).show();
      } else if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        AwesomeDialog(
          context: context,
          title: 'Error',
          body: Column(
            children: const <Widget>[
              Text('Incorrect email or password.'),
            ],
          ),
          dialogType: DialogType.error,
        ).show().then((_) => Navigator.pop(context));
      } else {
        AwesomeDialog(
          context: context,
          title: 'Error',
          body: Column(
            children: const <Widget>[
              Text('An unexpected error has occurred.'),
            ],
          ),
          dialogType: DialogType.error,
        ).show().then((_) => Navigator.pop(context));
      }
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      AwesomeDialog(
        context: context,
        title: 'Error',
        body: Column(
          children: const <Widget>[
            Text('An unexpected error has occurred.'),
          ],
        ),
        dialogType: DialogType.error,
      ).show().then((_) => Navigator.pop(context));
    }
  }
}
