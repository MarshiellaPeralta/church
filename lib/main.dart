import 'package:flutter/material.dart';
import 'log_in.dart'; // Import the login screen
import 'map.dart'; // Import the map screen
import 'livestream.dart'; // Import the livestream screen
import 'schedule.dart'; // Import the schedule screen
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

void main() {
  if (defaultTargetPlatform == TargetPlatform.android) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Church Management App",
      theme: ThemeData(
        primarySwatch: Colors.grey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        appBarTheme: AppBarTheme(
          color: Colors.transparent,
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.grey[300]!),
          titleTextStyle: TextStyle(
            color: Colors.grey[300]!,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.grey[300]!,
          unselectedItemColor: Colors.grey[500]!,
          selectedIconTheme: IconThemeData(size: 30, color: Colors.grey[300]!),
          unselectedIconTheme: IconThemeData(size: 24, color: Colors.grey[500]!),
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 14, color: Colors.grey[300]!),
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 12, color: Colors.grey[500]!),
        ),
      ),
      home: LoginScreen(), // Start with the LoginScreen
      debugShowCheckedModeBanner: false,
    );
  }
}

class MapAndLivestreamScreen extends StatefulWidget {
  @override
  _MapAndLivestreamScreenState createState() => _MapAndLivestreamScreenState();
}

class _MapAndLivestreamScreenState extends State<MapAndLivestreamScreen> {
  int _selectedIndex = 0;

  // Pages to display based on the selected tab
  final List<Widget> _pages = [
    MapScreen(),
    LivestreamPage(),
    ScheduleScreen(),
  ];

  final List<String> _titles = [
    'Map Screen',
    'Livestream Screen',
    'Schedule Screen',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _logOut() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.grey[800]!, Colors.grey[900]!],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
        ),
        elevation: 0,
        title: Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'Sanc',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: Colors.grey[300]!,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black45,
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
              ),
              TextSpan(
                text: '✞',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: Colors.orangeAccent,
                ),
              ),
              TextSpan(
                text: 'iSync',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                  color: Colors.grey[300]!,
                  shadows: [
                    Shadow(
                      blurRadius: 10.0,
                      color: Colors.black45,
                      offset: Offset(3, 3),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: Colors.grey[300]),
            onPressed: _logOut, // Call the logout function
          ),
        ],
      ),
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/background456.jpg',
              fit: BoxFit.cover,
            ),
          ),
          // Page content
          Column(
            children: [
              Expanded(
                child: _pages[_selectedIndex],
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.grey[800]!, Colors.grey[900]!],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          selectedItemColor: Colors.orangeAccent,
          unselectedItemColor: Colors.grey[500],
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.map, color: Colors.orangeAccent),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.live_tv, color: Colors.orangeAccent),
              label: 'Livestream',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.schedule, color: Colors.orangeAccent),
              label: 'Schedule',
            ),
          ],
        ),
      ),
    );
  }
}
