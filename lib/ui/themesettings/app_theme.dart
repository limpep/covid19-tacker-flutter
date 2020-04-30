import 'package:flutter/material.dart';

enum AppTheme { White, Dark, LightGreen, DarkGreen }

/// Returns enum value name without enum class name.
String enumName(AppTheme anyEnum) {
  return anyEnum.toString().split('.')[1];
}

final appThemeData = {
  AppTheme.White: ThemeData(
      brightness: Brightness.light,
      scaffoldBackgroundColor: Colors.lightBlueAccent,
      cardColor: Colors.cyanAccent),
  AppTheme.Dark: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Color(0xFF101010),
      cardColor: Color(0xFF222222),
      accentColor: Color(0xFF222222),
      canvasColor: Colors.blueGrey),
  AppTheme.LightGreen:
      ThemeData(brightness: Brightness.light, primaryColor: Colors.lightGreen),
  AppTheme.DarkGreen:
      ThemeData(brightness: Brightness.dark, primaryColor: Colors.green)
};

class CompanyColors {
  CompanyColors._(); // this basically makes it so you can instantiate this class
  static const _blackPrimaryValue = 0xFF000000;

  static const MaterialColor black = const MaterialColor(
    _blackPrimaryValue,
    const <int, Color>{
      50: const Color(0xFFe0e0e0),
      100: const Color(0xFFb3b3b3),
      200: const Color(0xFF808080),
      300: const Color(0xFF4d4d4d),
      400: const Color(0xFF262626),
      500: const Color(_blackPrimaryValue),
      600: const Color(0xFF000000),
      700: const Color(0xFF000000),
      800: const Color(0xFF000000),
      900: const Color(0xFF000000),
    },
  );
}
