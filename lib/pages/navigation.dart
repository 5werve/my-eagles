import 'package:flutter/material.dart';
import 'package:my_eagles/pages/schedule.dart';
import 'package:my_eagles/pages/activities.dart';
import 'package:my_eagles/pages/contact.dart';
import 'package:my_eagles/pages/calendar.dart';
import 'package:my_eagles/pages/home.dart';

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
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red[900],
        title: const Text(
          'Centennial High School',
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
