// ignore_for_file: use_build_context_synchronously, file_names

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:email_validator/email_validator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:raya/Features/views/home/Login_Page.dart';

import '../../constens/conestans.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text('Reset Password'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              const Text(
                'Receive an email to\nreset your password',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: emailController,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.done,
                decoration: const InputDecoration(labelText: 'Email'),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (email) =>
                    email != null && !EmailValidator.validate(email)
                        ? 'Enter a valid email'
                        : null,
              ),
              const SizedBox(
                height: 15,
              ),
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: KAppBarColors,
                ),
                onPressed: () async {
                  var forgotPas = emailController.text.trim();
                  try {
                    await FirebaseAuth.instance
                        .sendPasswordResetEmail(email: forgotPas);
                    if (kDebugMode) {
                      print('send email');
                    }
                    AwesomeDialog(
                      context: context,
                      title: 'Success',
                      body: const Text('Check Your Email.'),
                      dialogType: DialogType.success,
                    ).show();
                    Get.to(() => const LogInPage());
                  } on FirebaseAuthException catch (e) {
                    if (kDebugMode) {
                      print("error$e");
                    }
                    AwesomeDialog(
                      context: context,
                      title: 'Error',
                      body: Text(
                          'An error occurred while resetting your password: ${e.message}'),
                      dialogType: DialogType.error,
                    ).show();
                  }
                },
                icon: const Icon(Icons.email_outlined),
                label: const Text(
                  'Reset Password',
                  style: TextStyle(
                    fontSize: 24,
                    
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
