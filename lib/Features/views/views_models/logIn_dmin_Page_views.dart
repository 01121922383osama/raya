import 'package:flutter/material.dart';
import 'package:raya/admin/Admin_Log_In_page.dart';

class LogInAdminPageView extends StatelessWidget {
  const LogInAdminPageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          TextButton.icon(
            style: TextButton.styleFrom(
              iconColor: Colors.orange,
            ),
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AdminLogInPage()));
            },
            icon: const Icon(Icons.admin_panel_settings_outlined),
            label: const Text(
              'Admin',
              style: TextStyle(
                color: Colors.orange,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
