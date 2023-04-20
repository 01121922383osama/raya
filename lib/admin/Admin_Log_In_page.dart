import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:raya/Features/constens/conestans.dart';

class AdminLogInPage extends StatefulWidget {
  const AdminLogInPage({super.key});

  @override
  State<AdminLogInPage> createState() => _AdminLogInPageState();
}

class _AdminLogInPageState extends State<AdminLogInPage> {
  final _formKey = GlobalKey<FormState>();
  final adminEmail = TextEditingController();
  final adminPassword = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Only For Admin'),
        centerTitle: true,
        backgroundColor: KAppBarColors,
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: adminEmail,
                cursorColor: Colors.white,
                textInputAction: TextInputAction.next,
                decoration: InputDecoration(
                  labelText: 'Email Admin',
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
                validator: (admin) {
                  if (admin!.isEmpty) {
                    return 'Enter your email';
                  }
                  return null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: adminPassword,
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
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: KAppBarColors,
              ),
              onPressed: () async {
                await signIn();
              },
              child: const Text('LogIn'),
            ),
          ],
        ),
      ),
    );
  }

  Future signIn() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
    try {
      // Check if the user is an admin
      await FirebaseFirestore.instance
          .collection('admins')
          .doc('adminEamil') // use the value of the controller
          .get()
          .then((document) {
        if (document.exists) {
          if (document.data()?['email'] == adminEmail.text.trim() &&
              document.data()?['password'] == adminPassword.text.trim()) {
            Navigator.of(context).pushNamedAndRemoveUntil(
                'adminPage', (Route<dynamic> route) => false);
          } else {
            // show error dialog if password is incorrect
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                title: const Text('Error'),
                content: const Text('Invalid email or password.'),
                actions: <Widget>[
                  TextButton(
                    child: const Text('OK'),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            );
          }
        } else {
          // show error dialog if user is not found
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: const Text('User not found.'),
              actions: <Widget>[
                TextButton(
                  child: const Text('OK'),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          );
        }
      }).catchError((e) {
        if (kDebugMode) {
          print(e);
        }
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('Error'),
            content: Text('An error occurred: $e'),
            actions: <Widget>[
              TextButton(
                child: const Text('OK'),
                onPressed: () => Navigator.pop(context),
              ),
            ],
          ),
        );
      });
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      Navigator.pop(context);
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Error'),
          content: const Text('An unknown error occurred, please try again.'),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
    }
  }
}
