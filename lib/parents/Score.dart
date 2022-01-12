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
      backgroundColor: Colors.red,
      appBar: AppBar(
        title: Text('dice project'),
        centerTitle: true,
        backgroundColor: Colors.red,
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
    return Container();
  }
}

