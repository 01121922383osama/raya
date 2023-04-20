// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../views_models/Register_Body_view.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: RegisterBodyPage(),
    );
  }
}
