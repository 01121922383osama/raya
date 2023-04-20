// ignore_for_file: avoid_print

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'Features/constens/conestans.dart';
import 'Features/views/splash_Screen.dart';
import 'admin/home/Admin_home_page.dart';
import 'core/utils/Utils_page.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  )
      .then((value) => print('Firebase initialized successfully'))
      .catchError((error) => print('Firebase failed to initialize: $error'));
  await GetStorage.init();
  runApp(const Raya());
}

final navigatorKey = GlobalKey<NavigatorState>();

class Raya extends StatelessWidget {
  const Raya({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      scaffoldMessengerKey: Utils.messengerKey,
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Raya',
      theme: ThemeData.light().copyWith(
        scaffoldBackgroundColor: KPrimaryColor,
      ),
      home: const SplashScreen(),
      routes: {
        'adminPage': (context) => const AdminHomePage(),
      },
    );
  }
}
