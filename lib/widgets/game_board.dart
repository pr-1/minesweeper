import 'dart:math';

import 'package:flutter/material.dart';
import 'package:minesweeper/core/enums/block_state.dart';
import 'package:minesweeper/widgets/covered_block.dart';
import 'package:minesweeper/widgets/open_block.dart';

class GameBoard extends StatefulWidget {
  @override
  _GameBoardState createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  final int rows = 9;
  final int cols = 9;
  final int numOfMines = 11;

  int bombProbability = 3;
  int maxProbability = 15;

  int bombCount = 0;
  List<List<BlockState>> uiState;
  List<List<bool>> tiles;

  void resetBoard() {
    uiState = new List<List<BlockState>>.generate(rows, (row) {
      return new List<BlockState>.filled(cols, BlockState.COVERED);
    });

    tiles = new List<List<bool>>.generate(rows, (row) {
      return new List<bool>.filled(cols, false);
    });

    Random random = Random();
    int remainingMines = numOfMines;
    while (remainingMines > 0) {
      int pos = random.nextInt(rows * cols);
      int row = pos ~/ rows;
      int col = pos % cols;
      if (!tiles[row][col]) {
        tiles[row][col] = true;
        remainingMines--;
      }
    }
  }

  @override
  void initState() {
    resetBoard();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Row> boardRow = <Row>[];
    for (int i = 0; i < rows; i++) {
      List<Widget> rowChildren = <Widget>[];
      for (int j = 0; j < cols; j++) {
        BlockState state = uiState[i][j];
        if (state == BlockState.COVERED || state == BlockState.FLAGGED) {
          rowChildren.add(GestureDetector(
            child: Listener(
                child: CoveredMineTile(
                  flagged: state == BlockState.FLAGGED,
                  posX: i,
                  posY: j,
                )),
          ));
        } else {
          rowChildren.add(OpenMineTile(
            state: state,
            count: 1,
          ));
        }
      }
      boardRow.add(Row(
        children: rowChildren,
        mainAxisAlignment: MainAxisAlignment.center,
        key: ValueKey<int>(i),
      ));
    }
    return Container(
      color: Colors.grey[700],
      padding: EdgeInsets.all(10.0),
      child: Column(
        children: boardRow,
      ),
    );
  }
}
