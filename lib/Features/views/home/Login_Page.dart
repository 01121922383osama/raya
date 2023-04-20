// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../views_models/LoginPage_view.dart';
import '../widget/Custom_App_Bar.dart';

class LogInPage extends StatefulWidget {
  const LogInPage({super.key});

  @override
  State<LogInPage> createState() => _LogInPageState();
}

class _LogInPageState extends State<LogInPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: const [
            CustomAppBar(),
            LogInPageView(),
          ],
        ),
      ),
    );
  }
}
