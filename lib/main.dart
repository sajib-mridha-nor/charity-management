import 'package:donation_tracker/feature/theme/dlc_theme.dart';
import 'package:donation_tracker/pages/home_page.dart';
import 'package:donation_tracker/utils/path_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() async {
  runApp(const MyApp());
  await AppPathProvider.initPath();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    AppPathProvider.initPath();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: DonationTrackerTheme.lightTheme(),
      home: HomePage(),
    );
  }
}
