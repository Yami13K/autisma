import 'package:flutter/material.dart';

class ChildGame extends StatelessWidget {
  final String gameTitle;
  final VoidCallback onTap;
  final String image;
  ChildGame({
    required this.gameTitle,
    required this.onTap,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue,
      shadowColor: Colors.red,
      elevation: 8,
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              gameTitle,
              style: TextStyle(
                fontSize: 25,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 4),
            Ink.image(
              image: AssetImage(image),
              height: 240,
              fit: BoxFit.cover,
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200.0,
                  height: 50.0,
                  child: ElevatedButton.icon(
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all(Colors.lightBlueAccent),
                    ),
                    icon: Icon(
                      Icons.gamepad,
                      size: 24.0,
                      color: Colors.black,
                    ),
                    label: Text('Play'),
                    onPressed: onTap,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
