import 'package:flutter/material.dart';
import 'package:my_eagles/pages/home/calendar.dart';
import 'package:my_eagles/pages/home/schedule.dart';
import 'package:my_eagles/pages/home/activities.dart';
import 'package:my_eagles/pages/home/contact.dart';
import 'package:my_eagles/pages/home/home.dart';

import '../../services/auth.dart';

class Navigation extends StatefulWidget {
  @override
  _NavigationState createState() => _NavigationState();
}

class _NavigationState extends State<Navigation> {
  int _selectedIndex = 0;
  static const List<Widget> _widgetOptions = <Widget>[
    Home(),
    Calendar(),
    Schedule(),
    Activities(),
    Contact(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final AuthService _auth = AuthService();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: const Text(
          'Centennial HS',
          style: TextStyle(
            color: Colors.white,
            letterSpacing: 1.5,
          ),
        ),
        centerTitle: false,
        elevation: 0.0,
        leading: const Image(
          image: AssetImage('assets/centennial-logo.png'),
        ),
        automaticallyImplyLeading: false,
        actions: <Widget>[
          FlatButton.icon(
            icon: const Icon(
              Icons.person,
              color: Colors.white,
            ),
            label: const Text('Logout',
                style: TextStyle(
                  color: Colors.white,
                )),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: const Icon(Icons.home),
            label: 'Home',
            backgroundColor: Colors.red[900],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.calendar_today),
            label: 'Calendar',
            backgroundColor: Colors.red[900],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.schedule),
            label: 'Schedule',
            backgroundColor: Colors.red[900],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.directions_run),
            label: 'Activities',
            backgroundColor: Colors.red[900],
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.contact_page),
            label: 'Contact',
            backgroundColor: Colors.red[900],
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue[300],
        onTap: _onItemTapped,
      ),
    );
  }
}
