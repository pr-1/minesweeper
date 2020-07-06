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
    return Container(
      padding: EdgeInsets.all(10.0),
      child: GridView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: cols,
          ),
          itemCount: rows*cols,
          itemBuilder: (context, index) {
            int i = (index / cols).floor();
            int j = (index % cols);
            BlockState state = uiState[i][j];
            if (state == BlockState.COVERED || state == BlockState.FLAGGED) {
              return GestureDetector(
                onLongPress: () => showFlag(j, i),
                onTap: () => openSingleBlock(j, i),
                child: Listener(
                  child: CoveredMineTile(
                    flagged: state == BlockState.FLAGGED,
                    posX: j,
                    posY: i,
                  ),
                ),
              );
            } else {
              return OpenMineTile(
                state: state,
                count: mineCount(j, i),
              );
            }
          }),
    );
  }

  bool isInsideBoard(int x, int y) => x>=0&&x<cols && y>=0 &&y<rows;

  int getBombInBlock(int x, int y) => isInsideBoard(x, y) && tiles[y][x] ? 1 : 0;

  int mineCount(int x, int y) {
    int count = 0;
    count += getBombInBlock(x -1, y);
    count += getBombInBlock(x +1, y);
    count += getBombInBlock(x, y-1);
    count += getBombInBlock(x, y+1);
    count += getBombInBlock(x-1, y-1);
    count += getBombInBlock(x+1, y-1);
    count += getBombInBlock(x-1, y+1);
    count += getBombInBlock(x+1, y+1);
    return count;
  }

  // TO DISPLAY FLAG ON LONG PRESS OF A BLOCK
  void showFlag(int x, int y) {
    setState(() {
      if(uiState[y][x] == BlockState.FLAGGED) {
        uiState[y][x] = BlockState.COVERED;
      }else {
        uiState[y][x] = BlockState.FLAGGED;
      }
    });
  }


  void openSingleBlock(int x, int y) {
    if(uiState[y][x] == BlockState.FLAGGED)return;
    if(tiles[y][x]) {
        uiState[y][x] = BlockState.BLOWN;
    } else {
      openBlock(x,y);
    }
    setState(() {
    });
  }

  void openBlock(int x, int y) {
    // IF X,Y IS NOT ON BOARD RETURN
    if(!isInsideBoard(x,y)) return;
    // IF BLOCK IS ALREADY OPEN RETURN
    if(uiState[y][x] == BlockState.OPEN)return;
    // OPEN BLOCK NOW
    uiState[y][x] = BlockState.OPEN;
    
    // IF WE HIT SOME BLOCK WITH NO BOMBS IN NEIGHBOUR RETURN
    if(mineCount(x, y) > 0) return;
    // ELSE OPEN ALL ADJACENT BLOCKS
    // RECURSIVE BECAUSE MINESWEEPER DOES THAT
    openBlock(x -1, y);
    openBlock(x +1, y);
    openBlock(x, y-1);
    openBlock(x, y+1);
    openBlock(x-1, y-1);
    openBlock(x+1, y-1);
    openBlock(x-1, y+1);
    openBlock(x+1, y+1);
  }
}
