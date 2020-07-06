import 'package:flutter/material.dart';

class MineTheme {
  final BuildContext context;

  MineTheme(this.context);

  ThemeData getLightThemeData() {
    return ThemeData(
      primarySwatch: Colors.red,
      primaryColor: Colors.white,
      backgroundColor: Color(0xffF1F5FB),
      indicatorColor: Color(0xffCBDCF8),
      buttonColor: Color(0xffF1F5FB),
      hintColor: Color(0xffEECED3),
      highlightColor: Color(0xffFCE192),
      hoverColor: Color(0xff4285F4),
      focusColor: Color(0xffA8DAB5),
      disabledColor: Colors.grey,
      textSelectionColor: Colors.black,
      cardColor: Colors.white,
      canvasColor: Colors.grey[50],
      brightness: Brightness.light,
      buttonTheme: Theme.of(context)
          .buttonTheme
          .copyWith(colorScheme: ColorScheme.light()),
      appBarTheme: AppBarTheme(
          elevation: 0.0, color: Colors.cyan,
      textTheme: TextTheme(bodyText1: TextStyle(color: Colors.black))),
    );
  }

  ThemeData getDarkThemeData() {
    return ThemeData(
      primarySwatch: Colors.red,
      primaryColor: Colors.black,
      backgroundColor: Colors.grey,
      indicatorColor: Color(0xff0E1D36),
      buttonColor: Color(0xff3B3B3B),
      hintColor: Color(0xff280C0B),
      highlightColor: Color(0xff372901),
      hoverColor: Color(0xff3A3A3B),
      focusColor: Color(0xff0B2512),
      disabledColor: Colors.grey,
      textSelectionColor: Colors.white,
      cardColor: Color(0xFF151515),
      canvasColor: Colors.black,
      brightness: Brightness.dark,
      buttonTheme: Theme.of(context)
          .buttonTheme
          .copyWith(
          colorScheme: ColorScheme.dark(),
        highlightColor: Colors.black,
        splashColor: Colors.black,
        buttonColor: Colors.black
      ),
      appBarTheme: AppBarTheme(
          elevation: 0.0, color: Colors.black,
          textTheme: TextTheme(bodyText1: TextStyle(color: Colors.white))),
    );
  }
}
