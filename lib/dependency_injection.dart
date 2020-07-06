import 'package:get_it/get_it.dart';
import 'package:minesweeper/providers/board_provider.dart';

GetIt locator = GetIt.instance;

void setupLocator() {
  locator.registerLazySingleton(() => BoardProvider());
}
