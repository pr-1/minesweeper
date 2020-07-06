import 'package:flutter/material.dart';
import 'package:minesweeper/core/colors.dart';
import 'package:minesweeper/widgets/game_board.dart';

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Mine Sweeper'),
      ),
      body: Container(
        color: gameBackgroundColor,
        child: Center(
          child: GameBoard(),
        ),
      ),
    );
  }
}

