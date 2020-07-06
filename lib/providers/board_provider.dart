import 'package:flutter/material.dart';
import 'package:minesweeper/core/enums/theme_type.dart';

class BoardProvider with ChangeNotifier {
  ThemeType _themeType = ThemeType.LIGHT;

  ThemeType get themeType => _themeType;

  set themeType(ThemeType value) {
    _themeType = value;
    notifyListeners();
  }

  changeThemeType() {
    if(_themeType == ThemeType.LIGHT) {
      _themeType = ThemeType.DARK;
    } else {
      _themeType = ThemeType.LIGHT;
    }
    notifyListeners();
  }
}