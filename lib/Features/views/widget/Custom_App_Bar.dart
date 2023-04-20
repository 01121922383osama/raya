// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../../core/utils/assets.dart';

class CustomAppBar extends StatefulWidget {
  const CustomAppBar({super.key});

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(60.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 70,
            child: Image.asset(AssetsData.logo),
          ),
          const SizedBox(
            height: 5,
          ),
          const Text(
            'Student Raya',
            style: TextStyle(
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
