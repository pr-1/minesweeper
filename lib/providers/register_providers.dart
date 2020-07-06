import 'package:minesweeper/dependency_injection.dart';
import 'package:minesweeper/providers/board_provider.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> supplyProviders() {
  // NOTE ALWAYS USE LOCATOR TO AVOID CREATING MORE THAN ONE INSTANCE
  return [
    ChangeNotifierProvider(
      create: (_) => locator<BoardProvider>(),
    ),
  ];
}