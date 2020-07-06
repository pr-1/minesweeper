import 'package:flutter/material.dart';
import 'package:minesweeper/core/colors.dart';
import 'package:minesweeper/core/enums/theme_type.dart';
import 'package:minesweeper/providers/board_provider.dart';
import 'package:minesweeper/widgets/game_board.dart';
import 'package:provider/provider.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  @override
  Widget build(BuildContext context) {
    return Consumer<BoardProvider>(
      builder: (BuildContext context, BoardProvider value, Widget child) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Mine Sweeper',),
          actions: <Widget>[
            IconButton(
                icon: Icon(
                    value.themeType == ThemeType.LIGHT? Icons.brightness_high: Icons.brightness_2,
                ),
                onPressed: () {
                  value.changeThemeType();
                })
          ],
        ),
        body: Container(
          color: Theme.of(context).backgroundColor,
          child: Center(
            child: GameBoard(),
          ),
        ),
      );
    },);
  }
}

