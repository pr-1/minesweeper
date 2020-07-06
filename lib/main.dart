import 'package:flutter/material.dart';
import 'package:minesweeper/dependency_injection.dart';
import 'package:minesweeper/providers/board_provider.dart';
import 'package:minesweeper/providers/register_providers.dart';
import 'package:provider/provider.dart';

import 'core/enums/app_routes.dart';
import 'core/enums/theme_type.dart';
import 'core/mine_theme.dart';

void main() {
  setupLocator();
  runApp(MineSweeper());
}

class MineSweeper extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: supplyProviders(),
      child: Consumer<BoardProvider>(
        builder: (context, _boardProvider, child) {
          return  MaterialApp(
            title: 'Mine Sweeper',
            theme: _boardProvider.themeType == ThemeType.DARK? MineTheme(context).getDarkThemeData(): MineTheme(context).getLightThemeData(),
            debugShowCheckedModeBanner: false,
            initialRoute: AppRoute.GAME_SCREEN.id,
            routes: getRoutes(),
          );
        },
      ),
    );
  }
}

