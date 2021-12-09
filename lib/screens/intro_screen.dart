import 'package:autisma/games/math/screens/game_screen.dart';
import 'package:autisma/games/memory_game/screens/memory.dart';
import 'package:autisma/widgets/RoundedButton.dart';
import 'package:flutter/material.dart';
class  IntroScreen extends StatelessWidget {
  const  IntroScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue,
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 25),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            SizedBox(),
            Text(
              'Welcome To autisma !',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 32,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.2),
            ),

            Hero(
              tag: 'logoAnimation',
              child: Image.asset(
                'images/logo.png',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SizedBox(
                height: 55,
                width: double.infinity,
                child: RoundedButton(color: Colors.white,title: 'detection',onpressed: (){
                  Navigator.of(context).pushNamed(GameScreen.id);
                },),
              ),

            ),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 20),
               child: SizedBox(
                  height: 55,
                  width: double.infinity,
                  child: RoundedButton(color: Colors.white,title: 'Proceed',onpressed: (){
                    Navigator.of(context).pushNamed('login');
                  },),
                ),
             ),
          ],
        ),
      ),
    );
  }
}


