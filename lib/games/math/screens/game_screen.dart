import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:autisma/games/math/constants.dart';
import 'package:flutter/material.dart';
import 'package:outline_gradient_button/outline_gradient_button.dart';
import '../quiz_brain.dart';
import 'package:percent_indicator/percent_indicator.dart';

Quizbrain _quizBrain = Quizbrain();
int _score = 0;
int _highscore = 0;
double _value = 0;
int _falseCounter = 0;
int _numberofquizes = 0;

class GameScreen extends StatefulWidget {
  static final id = 'game_screen';

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late Timer _timer;
  int totalTime = 0;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startGame();
  }

  void startGame() async {
    _quizBrain.makeQuiz();
    starttimer();
    _value = 1;
    _score = 0;
    _falseCounter = 0;
    _numberofquizes = 1;
    SharedPreferences preferences = await SharedPreferences.getInstance();
    _highscore = preferences.getInt("highscore") ?? 0;
  }

  void starttimer() {
    const speed = Duration(milliseconds: 100);
    _timer = Timer.periodic(speed, (timer) {
      if (_value > 0) {
        setState(() {
          _value > 0.005 ? _value -= 0.005 : _value = 0;
          totalTime = (_value * 20 + 1).toInt();
        });
      } else {
        setState(() {
          totalTime = 0;
          ShowMydialog();
          _timer.cancel();
        });
      }
    });
  }

  Future<void> ShowMydialog() {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            backgroundColor: Color(0xff1542bf),
            title: FittedBox(
              child: Text(
                "Game Over",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 32,
                  color: Colors.orangeAccent,
                ),
              ),
            ),
            content: Text(
              "Score: $_score | $_numberofquizes",
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: 24,
                  color: Colors.black,
                  fontWeight: FontWeight.bold),
            ),
            actions: [
              TextButton(
                child: Text(
                  "Exit",
                  style: TextStyle(fontSize: 18, color: Colors.white60),
                ),
                onPressed: () {
                  int count = 0;
                  Navigator.of(context).popUntil((_) => count++ >= 2);
                },
              ),
              TextButton(
                child: Text(
                  "Play Again",
                  style: TextStyle(fontSize: 18, color: Colors.white60),
                ),
                onPressed: () {
                  startGame();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    setState(() {
      totalTime = 0;
      ShowMydialog();
      _timer.cancel();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
            colors: [Color(0xff1542bf), Color(0xff51a8ff)],
          )),
          child: Column(
            children: [
              ScoreIndicators(),
              QuizBody(),
              CircularPercentIndicator(
                center: Text(
                  '$totalTime',
                  style: kTotalTimeStyle,
                ),
                radius: 120,
                lineWidth: 10,
                percent: _value,
                progressColor: _value > 0.6
                    ? Colors.green
                    : _value > 0.3
                        ? Colors.yellow
                        : Colors.red,
                circularStrokeCap: CircularStrokeCap.round,
              ),
              Expanded(
                child: Row(
                  children: [
                    ReusableOutlineButton(
                      userChoice: 'true',
                      color: Colors.lightGreen,
                    ),
                    ReusableOutlineButton(
                      userChoice: 'false',
                      color: Colors.red,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableOutlineButton extends StatelessWidget {
  final userChoice;
  final color;
  void checkAnswer() async {
    if (userChoice == _quizBrain.answer) {
      _score++;
      _value >= 0.89 ? _value = 1 : _value += 0.1;
      if (_highscore < _score) {
        _highscore = _score;
        SharedPreferences preferences = await SharedPreferences.getInstance();
        preferences.setInt("highscore", _highscore);
      }
    } else
      _falseCounter++;
    _value < 0.02 * _falseCounter ? _value = 0 : _value -= 0.02 * _falseCounter;
  }

  ReusableOutlineButton({this.userChoice, this.color});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Padding(
      padding: EdgeInsets.all(20),
      child: OutlineGradientButton(
        padding: EdgeInsets.symmetric(horizontal: 20),
        child: Center(
          child: FittedBox(
            child: Text(
              userChoice,
              style: TextStyle(fontSize: 50, color: color),
            ),
          ),
        ),
        gradient: LinearGradient(
          colors: [Color(0xff1542bf), Color(0xff51a8ff)],
        ),
        strokeWidth: 12,
        elevation: 1,
        radius: Radius.circular(36),
        onTap: () {
          _numberofquizes++;
          checkAnswer();
          _quizBrain.makeQuiz();
        },
      ),
    ));
  }
}

class QuizBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FittedBox(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Text(
            _quizBrain.operation,
            style: kQuizTextStyle,
          ),
        ),
      ),
    );
  }
}

class ScoreIndicators extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 24, right: 24, left: 24),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          ScoreIndicator(
            label: 'HighScore',
            score: '$_highscore',
          ),
          SizedBox(
            width: 40,
          ),
          ScoreIndicator(
            label: 'Score ',
            score: '$_score',
          ),
        ],
      ),
    );
  }
}

class ScoreIndicator extends StatelessWidget {
  final label;
  final score;
  ScoreIndicator({this.label, this.score});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(label, style: kScorelabelTextStyle),
        SizedBox(
          height: 10,
        ),
        Text(score, style: kScoreNumberTextStyle),
      ],
    );
  }
}
