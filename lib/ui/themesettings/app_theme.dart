import 'package:flutter/material.dart';

enum AppTheme { White, Dark, LightGreen, DarkGreen }

/// Returns enum value name without enum class name.
String enumName(AppTheme anyEnum) {
  return anyEnum.toString().split('.')[1];
}

final appThemeData = {
  AppTheme.White:
      ThemeData(brightness: Brightness.light, primaryColor: Colors.white),
  AppTheme.Dark: ThemeData.dark().copyWith(
      scaffoldBackgroundColor: Color(0xFF101010),
      cardColor: Color(0xFF222222),
      accentColor: Colors.blueGrey,
      canvasColor: Colors.red),
  AppTheme.LightGreen:
      ThemeData(brightness: Brightness.light, primaryColor: Colors.lightGreen),
  AppTheme.DarkGreen:
      ThemeData(brightness: Brightness.dark, primaryColor: Colors.green)
};
