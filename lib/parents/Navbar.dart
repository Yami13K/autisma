import 'package:flutter/animation.dart';
import 'package:flutter/material.dart';

class NavDrawer extends StatelessWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Drawer(
        
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            Container(
              height: 230,
              child: DrawerHeader(
                curve: Curves.ease,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("images/autism_drawer.jpg")),
                ),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 10, 0),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.child_care),
              title: Text(
                'Add Child',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () => {Navigator.pushNamed(context, 'add_child')},
            ),
            ListTile(
              leading: Icon(Icons.videogame_asset),
              title: Text(
                'Add Games',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () => {Navigator.pushNamed(context, 'add_games')},
            ),
            ListTile(
              leading: Icon(Icons.score),
              title: Text(
                'Check Scores',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () => {Navigator.pushNamed(context, 'score')},
            ),
            ListTile(
              leading: Icon(Icons.quiz),
              title: Text(
                'Upload Image And Audio',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () => {Navigator.pushNamed(context, 'upload')},
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text(
                'Logout',
                style: TextStyle(fontSize: 20),
              ),
              onTap: () => {},
            ),
          ],
        ),
      ),
    );
  }
}
