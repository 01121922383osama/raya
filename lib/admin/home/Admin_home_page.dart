// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:raya/Features/constens/conestans.dart';
import 'package:raya/admin/Body_OfThe_Admin_Page.dart';
import 'package:raya/admin/Drawer_Of_Admin.dart';

class AdminHomePage extends StatefulWidget {
  const AdminHomePage({super.key});

  @override
  State<AdminHomePage> createState() => _AdminHomePageState();
}

class _AdminHomePageState extends State<AdminHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: KAppBarColors,
        title: const Text('Raya'),
        centerTitle: true,
      ),
      drawer: const DraweAdminViewPage(),
      body: const BodyOfTheAdminPage(),
    );
  }
}
