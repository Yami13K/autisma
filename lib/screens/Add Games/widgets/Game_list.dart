import 'package:autisma/games/Game_module/Game_data.dart';

import 'package:autisma/screens/Add%20Games/widgets/List_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class GameList extends StatefulWidget {
  const GameList({Key? key}) : super(key: key);

  @override
  _GameListState createState() => _GameListState();
}

class _GameListState extends State<GameList> {
  DateTime? date;
  @override
  Widget build(BuildContext context) {
    Future pickdate() async {
      final initialDate = DateTime.now();
      final newDate = await showDatePicker(
        context: context,
        initialDate: date ?? initialDate,
        firstDate: DateTime(initialDate.year - 5),
        lastDate: DateTime(initialDate.year + 5),
      );
      if (newDate == null) return;
      setState(() {
        date = newDate;
      });
    }

    Future pickTime(BuildContext context) async {
      final initialTime = TimeOfDay(hour: 9, minute: 0);
      final newTime =
          await showTimePicker(context: context, initialTime: initialTime);
    }

    return Consumer<GameData>(builder: (context, gamedata, child) {
      return ListView.builder(
        itemCount: gamedata.gameCount,
        itemBuilder: (context, index) {
          final game = gamedata.games[index];
          return GameTile(gameTitle: game.name.toString(), onTap: () {});
        },
      );
    });
  }
}
