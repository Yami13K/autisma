import 'package:flutter/material.dart';

import 'Navbar.dart';

class Score extends StatefulWidget {
  const Score({Key? key}) : super(key: key);

  @override
  _ScoreState createState() => _ScoreState();
}

class _ScoreState extends State<Score> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavDrawer(),
      appBar: AppBar(
        title: Text('Scores'),
        centerTitle: true,
      ),
      body: scoreBody(),
    );
  }
}

class scoreBody extends StatefulWidget {
  const scoreBody({Key? key}) : super(key: key);

  @override
  _scoreBodyState createState() => _scoreBodyState();
}

class _scoreBodyState extends State<scoreBody> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
            child: Column(children: <Widget>[
      Container(
        margin: EdgeInsets.all(20),
        child: Table(
          defaultColumnWidth: FixedColumnWidth(120.0),
          border: TableBorder.all(
              color: Colors.black, style: BorderStyle.solid, width: 2),
          children: [
            TableRow(children: [
              Column(
                  children: [Text('Game', style: TextStyle(fontSize: 20.0))]),
              Column(
                  children: [Text('Score', style: TextStyle(fontSize: 20.0))]),
            ]),
            TableRow(children: [
              Column(children: [Text('Memory Game')]),
              Column(children: [Text('100')]),
            ]),
            TableRow(children: [
              Column(children: [Text('Mathmetical Game')]),
              Column(children: [Text('20')]),
            ]),
          ],
        ),
      ),
    ])));
  }
}
