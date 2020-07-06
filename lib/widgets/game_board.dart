import 'dart:async';
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

  List<List<BlockState>> uiState;
  List<List<bool>> tiles;


  bool hasWon = false;
  bool alive = false;
  int bombCount = 0;
  Stopwatch _stopwatch = Stopwatch();
  Timer _timer;

  void resetBoard() {
    hasWon = false;
    alive = true;
    bombCount = 0;
    _stopwatch.reset();
    _stopwatch.stop();
    _timer?.cancel();
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
      });
    });
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
  void dispose() {
    // TODO: implement dispose
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    bool hasCoveredCell = false;
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
            if(!alive) {
              if(state != BlockState.BLOWN) {
                state = tiles[i][j] ? BlockState.REVEALED: state;
              }
            }
            if(!hasCoveredCell) {
              if(bombCount == numOfMines){
                hasWon = true;
                _stopwatch.stop();
              }
            }
            if (state == BlockState.COVERED || state == BlockState.FLAGGED) {
              if(state == BlockState.COVERED) {
                hasCoveredCell = true;
              }
              return GestureDetector(
                onLongPress: () => showFlag(j, i),
                onTap: () => state == BlockState.COVERED?openSingleBlock(j, i): null,
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
    if(!alive) return;
    setState(() {
      if(uiState[y][x] == BlockState.FLAGGED) {
        uiState[y][x] = BlockState.COVERED;
        --bombCount;
      }else {
        uiState[y][x] = BlockState.FLAGGED;
        ++bombCount;
      }
    });
  }


  void openSingleBlock(int x, int y) {
    if(!alive) return;
    BlockState state = uiState[y][x];
    if(uiState[y][x] == BlockState.FLAGGED)return;
    if(tiles[y][x]) {
        uiState[y][x] = BlockState.BLOWN;
        alive = false;
        _timer.cancel();
    } else {
      openBlock(x,y);
      if(!_stopwatch.isRunning) _stopwatch.start();
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
