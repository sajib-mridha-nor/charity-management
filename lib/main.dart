import 'package:donation_tracker/feature/theme/color_schemes.dart';
import 'package:donation_tracker/feature/theme/donation_them.dart';
import 'package:donation_tracker/pages/auth/login_page.dart';
import 'package:donation_tracker/pages/home_page.dart';
import 'package:donation_tracker/utils/hexcolor.dart';
import 'package:donation_tracker/utils/path_provider.dart';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'pages/auth/registration_page.dart';
import 'pages/test.dart';

main() async {
  await GetStorage.init();
  await AppPathProvider.initPath();
  runApp(MyApp());
  WidgetsFlutterBinding.ensureInitialized();
  // AppPathProvider.initPath().then((value) => runApp(MyApp()));
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
    // AppPathProvider.initPath();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // AppPathProvider.initPath();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: new ThemeData(
          fontFamily: "Raleway",
          appBarTheme: AppBarTheme(elevation: 0),
          primarySwatch: generateMaterialColorFromColor(Color(0xFF1D3EB1)),
          primaryTextTheme:
              TextTheme(headline6: TextStyle(color: Colors.white))),
      home: box.read("token") == null ? LoginPage():HomePage() ,
    );
  }
}
