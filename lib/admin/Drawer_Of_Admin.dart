// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:getwidget/getwidget.dart';
import 'package:raya/Features/constens/conestans.dart';
import 'package:raya/admin/Student_page.dart';
import 'package:raya/core/utils/assets.dart';
import 'home/Admin_Data_for_users.dart';

class DraweAdminViewPage extends StatelessWidget {
  const DraweAdminViewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GFDrawer(
      color: Colors.green,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GFDrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  AssetsData.drawelogo,
                ),
                fit: BoxFit.fill,
              ),
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: KPrimaryColor,
              minimumSize: const Size(40, 40),
            ),
            onPressed: () async {
              Get.to(() => const StudentRayaPage(),
                  transition: Transition.zoom,
                  duration: const Duration(milliseconds: 250));
            },
            icon: const Icon(
              Icons.person,
              size: 32,
            ),
            label: const Text(
              'Students Users',
              style: TextStyle(
                fontSize: 24,
                color: Colors.black,
              ),
            ),
          ),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(
              backgroundColor: KPrimaryColor,
              minimumSize: const Size(40, 40),
            ),
            onPressed: () async {
              Get.to(() => const AdminDataForUsers(),
                  transition: Transition.zoom,
                  duration: const Duration(milliseconds: 250));
            },
            icon: const Icon(
              Icons.person,
              size: 32,
            ),
            label: const Text(
              'Data',
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
}
