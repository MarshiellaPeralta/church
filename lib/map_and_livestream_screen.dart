import 'package:flutter/material.dart';
import 'livestream.dart'; // Import LivestreamPage
import 'schedule.dart'; // Import ScheduleScreen
import 'map.dart'; // Import MapScreen

class MapAndLivestreamScreen extends StatefulWidget {
  @override
  _MapAndLivestreamScreenState createState() => _MapAndLivestreamScreenState();
}

class _MapAndLivestreamScreenState extends State<MapAndLivestreamScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    if (index == 1) {
      // Navigate to LivestreamPage
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LivestreamPage()),
      );
    } else if (index == 2) {
      // Navigate to ScheduleScreen
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ScheduleScreen()),
      );
    } else {
      setState(() {
        _selectedIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _selectedIndex == 0 ? 'Map Screen' : 'Livestream or Schedule',
        ),
        backgroundColor: Colors.blueGrey[800],
      ),
      body: _selectedIndex == 0
          ? MapScreen()
          : Container(), // Livestream and Schedule handled by navigation
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: Colors.orangeAccent,
        unselectedItemColor: Colors.grey,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.map),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.live_tv),
            label: 'Live',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.schedule),
            label: 'Schedule',
          ),
        ],
      ),
    );
  }
}
