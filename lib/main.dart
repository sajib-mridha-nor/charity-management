import 'package:donation_tracker/feature/theme/dlc_theme.dart';
import 'package:donation_tracker/pages/auth/login_page.dart';
import 'package:donation_tracker/pages/home_page.dart';
import 'package:donation_tracker/utils/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

main() async {
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  await AppPathProvider.initPath();
}

class MyApp extends StatefulWidget {
  MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  GetStorage box = GetStorage();
  @override
  void initState() {
    AppPathProvider.initPath();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: DonationTrackerTheme.lightTheme(),
      home: box.read("token") == null ? LoginPage() : HomePage(),
    );
  }
}
