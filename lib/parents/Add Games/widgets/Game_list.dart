import 'package:autisma/games/Game_module/Game_data.dart';

import 'package:flutter/material.dart';

import 'List_tile.dart';


class GameList extends StatefulWidget {
  const GameList({Key? key}) : super(key: key);

  @override
  _GameListState createState() => _GameListState();
}

class _GameListState extends State<GameList> {
  GameData? gameData;
  DateTime? dateTime;

  @override
  Widget build(BuildContext context) {
    Future pickdate(BuildContext context) async {
      final initialDate = DateTime.now();
      final newDate = await showDatePicker(
        context: context,
        initialDate: dateTime ?? initialDate,
        firstDate: DateTime(initialDate.year - 5),
        lastDate: DateTime(initialDate.year + 5),
      );
      if (newDate == null) return null;

      return newDate;
    }

    Future<TimeOfDay?> pickTime(BuildContext context) async {
      final initialTime = TimeOfDay(hour: 9, minute: 0);
      final newTime = await showTimePicker(
          context: context,
          initialTime: dateTime != null
              ? TimeOfDay(hour: dateTime!.hour, minute: dateTime!.minute)
              : initialTime);
      if (newTime == null) return null;

      return newTime;
    }

    Future pickDateTime(BuildContext context) async {
      final date = await pickdate(context);
      if (date == null) return null;
      final time = await pickTime(context);
      if (time == null) return null;
      setState(() {
        dateTime =
            DateTime(date.year, date.month, date.day, time.hour, time.minute);
        /*Edit DateTime in Database to equal this datetime
          where the name(In DB) equals  the parameter name
        */
        print(dateTime);
      });
    }
    // String gethours() {
    //   final hours = dateTime!.hour.toString().padLeft(2, '0');
    //   return '$hours';
    // }
    //
    // String getminutes() {
    //   final minutes = dateTime!.minute.toString().padLeft(2, '0');
    //   return '$minutes';
    // }
    //
    // return Consumer<GameData>(builder: (context, gamedata, child) {
    //   return ListView.builder(
    //     itemCount: gamedata.gameCount,
    //     itemBuilder: (context, index) {
    //       final game = gamedata.games[index];
    //       return GameTile(
    //           gameTitle: game.name.toString(),
    //           onTap: () {
    //             pickDateTime(context, game.name.toString());
    //             print(game.name);
    //             print(game.Route);
    //           });
    //     },
    //   );
    // });
    return ListView(
      children: [
        GameTile(gameTitle: "Mathematical Game",onTap: (){pickDateTime(context);},
          image:"images/math.png",submit: (){
          //upload time into database
          },
        ),
        GameTile(gameTitle: "Memory Game",onTap: (){pickDateTime(context);},
          image:"images/memory.png",submit: (){
            //upload time into database
          },
        ),
      ],
    );
  }
}