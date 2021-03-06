import 'package:flutter/material.dart';
import 'package:minesweeper/core/colors.dart';
import 'package:minesweeper/core/enums/block_state.dart';
import 'package:minesweeper/core/ui_utilities.dart';

class OpenMineTile extends StatelessWidget {
  final BlockState state;
  final int count;
  OpenMineTile({this.state, this.count});

  @override
  Widget build(BuildContext context) {
    Widget text;

    if (state == BlockState.OPEN) {
      if (count != 0) {
        text = RichText(
          text: TextSpan(
            text: '$count',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: textColors[count - 1],
            ),
          ),
          textAlign: TextAlign.center,
        );
      }
    } else {
      text = RichText(
        text: TextSpan(
          text: '\u2739',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.red,
          ),
        ),
        textAlign: TextAlign.center,
      );
    }
    return buildTile(buildInnerTile(Center(child: text)));
  }
}