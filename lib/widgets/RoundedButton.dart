import 'package:flutter/material.dart';
class RoundedButton extends StatelessWidget {
  final Color color;
  final String title;
  final VoidCallback onpressed;

  RoundedButton({required this.color,required this.title,required this.onpressed});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onpressed,

        child: Text(
          title,
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(color),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                )
            )
        )
    );
  }
}