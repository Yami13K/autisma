import 'package:autisma/children/game_list.dart';
import 'package:autisma/games/Game_module/Game_data.dart';
import 'package:autisma/games/Game_module/game.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class play extends StatefulWidget {
  const play({Key? key}) : super(key: key);

  @override
  _playState createState() => _playState();
}

class _playState extends State<play> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Play Games"),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: ChangeNotifierProvider(
                  create: (_) => GameData(), child: Games()),
            ),
          ),
        ],
      ),
    );
  }
}
