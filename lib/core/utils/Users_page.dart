// ignore_for_file: file_names, unnecessary_null_comparison

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UsersData {
  static Widget getUserRow(User user, String photoUrl) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundImage: photoUrl != null ? NetworkImage(photoUrl) : null,
          child: photoUrl == null ? const Icon(Icons.person) : null,
        ),
        const SizedBox(width: 8),
        Text(
          user.providerData
                  .any((element) => element.providerId.contains('google.com'))
              ? user.displayName ?? 'Unknown User'
              : user.email ?? 'Unknown User',
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
