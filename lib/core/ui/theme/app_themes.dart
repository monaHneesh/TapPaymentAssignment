import 'package:flutter/material.dart';

enum AppTheme {
  LightTheme,
  DarkTheme,

}

final appThemeData = {
  AppTheme.LightTheme: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.black,
  ),
  AppTheme.DarkTheme: ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.grey,
  ),

};