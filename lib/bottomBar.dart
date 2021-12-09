import 'package:autisma/parents/Dashboard.dart';
import 'package:autisma/parents/profile.dart';
import 'package:flutter/material.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    Profile(),
    schedule()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.grey[500],
            ),
            title: Text('HOME'),
            activeIcon: Icon(Icons.home,
              color: Colors.deepPurple[300],
            ),
          ),

          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              color: Colors.grey[500],
              size: 36,
            ),
            title: Text('PROFILE'),
            activeIcon: Icon(
              Icons.account_circle,
              color: Colors.deepPurple[300],
              size: 36,
            ),
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
    );
  }
}
