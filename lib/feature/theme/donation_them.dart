import 'package:donation_tracker/feature/theme/color_schemes.dart';
import 'package:flutter/material.dart';

class DonationTrackerTheme {
  static ThemeData lightTheme() {
    // ThemeData(
    //     primarySwatch: Palette.mdlc,
    //     tabBarTheme: const TabBarTheme(
    //         labelColor: Colors.white, unselectedLabelColor: Colors.black),
    //     scaffoldBackgroundColor: Colors.white,
    //     appBarTheme: AppBarTheme(
    //       backgroundColor: Colors.white,
    //       iconTheme: IconThemeData(color: Colors.black),
    //       elevation: 8,
    //       shadowColor: Colors.black26,
    //       actionsIconTheme: IconThemeData(color: Colors.black),
    //       centerTitle: false,
    //       titleTextStyle: TextStyle(
    //           color: Colors.black,
    //           fontSize: 18,
    //           fontFamily: box.read("lang") == "en" ? null : 'RuhulAminUnicode'),
    //     ));
    return ThemeData(
      useMaterial3: true,
      fontFamily: "NotoSerifToto",
      appBarTheme: AppBarTheme(shadowColor: Colors.black26, elevation: 8),
      tabBarTheme: const TabBarTheme(
          labelColor: Colors.white, unselectedLabelColor: Colors.black),
      colorScheme: lightColorScheme,
    );
  }
}
