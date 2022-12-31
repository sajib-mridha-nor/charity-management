import 'package:flutter/material.dart';

class Palette {
  static const MaterialColor mdlc = MaterialColor(_mdlcPrimaryValue, <int, Color>{
    50: Color(0xFFF1E6F1),
    100: Color(0xFFDDC0DD),
    200: Color(0xFFC696C6),
    300: Color(0xFFAF6BAF),
    400: Color(0xFF9D4C9D),
    500: Color(_mdlcPrimaryValue),
    600: Color(0xFF842784),
    700: Color(0xFF792179),
    800: Color(0xFF6F1B6F),
    900: Color(0xFF5C105C),
  });
  static const int _mdlcPrimaryValue = 0xFF8C2C8C;

  static const MaterialColor mdlcAccent = MaterialColor(_mdlcAccentValue, <int, Color>{
    100: Color(0xFFFF93FF),
    200: Color(_mdlcAccentValue),
    400: Color(0xFFFF2DFF),
    700: Color(0xFFFF14FF),
  });
  static const int _mdlcAccentValue = 0xFFFF60FF;
}