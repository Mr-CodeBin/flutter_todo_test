import 'package:flutter/material.dart';

class TAppTheme {
  TAppTheme._();

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'OpenSans',
    disabledColor: const Color(0xFF8E8E93),
    brightness: Brightness.light,
    primaryColor: const Color(0xFF2EAB57),
    scaffoldBackgroundColor: const Color(0xFFf4f3f7),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFFf4f3f7),
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFF000000)),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,
    fontFamily: 'OpenSans',
    disabledColor: const Color(0xFF8E8E93),
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF2EAB57),
    scaffoldBackgroundColor: const Color(0xFF0C0C0C),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF0C0C0C),
      elevation: 0,
      iconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
    ),
  );
}
