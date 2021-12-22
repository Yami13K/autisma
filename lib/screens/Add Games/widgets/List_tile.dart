import 'package:flutter/material.dart';

class GameTile extends StatelessWidget {
  final String gameTitle;
  final VoidCallback onTap;
  GameTile({required this.gameTitle, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(gameTitle),
      trailing: IconButton(
        icon: const Icon(
          Icons.calendar_today_rounded,
          color: Colors.lightBlueAccent,
        ),
        onPressed: onTap,
      ),
    );
  }
}
