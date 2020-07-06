import 'package:flutter/material.dart';
import 'package:minesweeper/core/ui_utilities.dart';

class CoveredMineTile extends StatelessWidget {
  final bool flagged;
  final int posX;
  final int posY;

  CoveredMineTile({this.flagged, this.posX, this.posY});

  @override
  Widget build(BuildContext context) {
    Widget text;
    if (flagged) {
      text = buildInnerTile(RichText(
        text: TextSpan(
          text: "\u2691",
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        textAlign: TextAlign.center,
      ));
    }
    Widget innerTile = Card(
      elevation: 2,
      shadowColor: Colors.cyan,
      child: Container(
        padding: EdgeInsets.all(1.0),
        height: 20.0,
        width: 20.0,
        decoration: BoxDecoration(
            color: Colors.grey[350],
        ),
        child: text,
      ),
    );

    return buildTile(innerTile);
  }
}