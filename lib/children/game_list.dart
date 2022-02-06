import 'package:provider/provider.dart';
import 'package:autisma/games/Game_module/Game_data.dart';

import 'package:flutter/material.dart';

import 'game_tile.dart';

class Games extends StatefulWidget {
  const Games({Key? key}) : super(key: key);

  @override
  _GameState createState() => _GameState();
}

class _GameState extends State<Games> {
  late GameData gamedata;
  @override
  Widget build(BuildContext context) {
    return Consumer<GameData>(builder: (context, gamedata, index) {
      return ListView.builder(
        itemBuilder: (context, index) {
          final game = gamedata.games[index];
          return ChildGame(
            gameTitle: game.name.toString(),
            image: game.image.toString(),
            onTap: () {
              Navigator.pushNamed(context, game.route.toString());
            },
          );
        },
        itemCount: gamedata.gameCount,
      );
    });
  }
}
