import 'package:flutter/material.dart';

class MineTheme {
  final BuildContext context;

  MineTheme(this.context);

  ThemeData getLightThemeData() {
    return ThemeData.light();
  }

  ThemeData getDarkThemeData() {
    return ThemeData.dark();
  }

}