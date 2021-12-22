import 'package:autisma/games/Game_module/Game_data.dart';
import 'package:autisma/screens/Add%20Games/widgets/Game_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Games extends StatefulWidget {
  const Games({Key? key}) : super(key: key);

  @override
  _GamesState createState() => _GamesState();
}

class _GamesState extends State<Games> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Schedule Games"),
        backgroundColor: Colors.lightBlueAccent,
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: ChangeNotifierProvider(
                  create: (_) => GameData(), child: GameList()),
            ),
          ),
        ],
      ),
    );
  }
}
