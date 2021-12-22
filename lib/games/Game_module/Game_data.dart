import 'dart:collection';
import 'package:flutter/foundation.dart';

import 'game.dart';

class GameData extends ChangeNotifier {
  List<Game> _games = [
    Game(name: "sss", timeStamp: DateTime.now()),
    Game(name: "sss", timeStamp: DateTime.now()),
    Game(name: "sss", timeStamp: DateTime.now()),
  ];
  UnmodifiableListView<Game> get games {
    return UnmodifiableListView(_games);
  }

  int get gameCount {
    return _games.length;
  }
}
