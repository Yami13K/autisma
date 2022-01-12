import 'package:flutter/material.dart';

class GameTile extends StatelessWidget {
  final String gameTitle;
  final VoidCallback onTap;
  final VoidCallback submit;
  final String image;
  GameTile({required this.gameTitle, required this.onTap,required this.image, required this.submit});

  @override
  Widget build(BuildContext context) {
    // return ListTile(
    //   title: Text(gameTitle),
    //   trailing: IconButton(
    //     icon: const Icon(
    //       Icons.calendar_today_rounded,
    //       color: Colors.lightBlueAccent,
    //     ),
    //     onPressed: onTap,
    //   ),
    //   leading: Image.asset(image),
    // );
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
                  fontWeight: FontWeight.bold,),
            ),
            const SizedBox(height: 4),
            Ink.image(
              image: AssetImage(image),
              height: 240,
              fit: BoxFit.cover,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent),
                      ),
                  icon: Icon(
                    Icons.calendar_today,
                    size: 24.0,
                    color: Colors.black,
                  ),

                  label: Text('Choose Date'), onPressed:onTap,
                ),
                ElevatedButton.icon(
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent),
                        ),
                  icon: Icon(
                    Icons.assignment_turned_in,
                    color: Colors.black,
                    size: 24.0,
                  ),
                  label: Text('Submit Time'),
                  onPressed: submit
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
