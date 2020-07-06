import 'package:flutter/material.dart';
import 'package:minesweeper/screens/game_screen.dart';

enum AppRoute {
  GAME_SCREEN
}

extension StringValues on AppRoute {
String get id => const {
  AppRoute.GAME_SCREEN: 'GAME'
}[this];

Widget get screen => {
  AppRoute.GAME_SCREEN: GameScreen()
}[this];
}

Map<String, WidgetBuilder> getRoutes() {
  return {
    AppRoute.GAME_SCREEN.id: (context) => AppRoute.GAME_SCREEN.screen
  };
}
