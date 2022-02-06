import 'dart:collection';
import 'package:flutter/foundation.dart';

import 'game.dart';

class GameData extends ChangeNotifier {
  List<Game> _games = [
    Game(
      name: "MathMetical Game",
      route: "mathmetical",
      image: "images/math.png",
    ),
    Game(name: "Memory Game", route: "memory", image: "images/memory.png"),
  ];
  UnmodifiableListView<Game> get games {
    return UnmodifiableListView(_games);
  }

  int get gameCount {
    return _games.length;
  }
}
