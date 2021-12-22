import 'package:flutter/material.dart';

import '../screens/Add Child.dart';


class ImageSplashCard extends StatelessWidget {
  late String path;
  ImageSplashCard({required this.path});
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Ink.image(
            image: AssetImage(path),
            child: InkWell(
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (_)=>AddChild()));
              },
            ),
            height: 240,
            fit: BoxFit.cover,
          ),
          Text(
            'Add Child',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 24,
            ),
          ),
        ],
      ),
    );
  }
}

class ColoredCard extends StatelessWidget {
  String title;
  String? text;
  VoidCallback  ontap;
  Color? color;
  ColoredCard({required this.title,this.text,required this.ontap,this.color});
  @override
  Widget build(BuildContext context) {
    return Card(
      color: color,
      shadowColor: Colors.red,
      elevation: 8,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: InkWell(
        onTap: ontap,
        child: Container(

          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title.toString(),
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    decoration: TextDecoration.underline
                ),
              ),
              const SizedBox(height: 4),
              Text(
                text.toString(),
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}