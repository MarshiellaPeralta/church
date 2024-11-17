import 'package:flutter/material.dart';
import 'map_and_livestream_screen.dart'; // Import the next screen

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() async {
    await Future.delayed(Duration(seconds: 3)); // Simulate loading
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MapAndLivestreamScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/backgroundscreen.jpg',
              fit: BoxFit.cover,
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TweenAnimationBuilder<double>(
                  tween: Tween<double>(begin: 0, end: 1),
                  duration: Duration(seconds: 3),
                  builder: (context, value, child) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        SizedBox(
                          width: 300,
                          height: 8,
                          child: LinearProgressIndicator(
                            value: value,
                            backgroundColor: Colors.orangeAccent.withOpacity(0.3),
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.orangeAccent,
                            ),
                          ),
                        ),
                        Positioned(
                          child: Text(
                            '${(value * 100).toStringAsFixed(0)}%',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
                SizedBox(height: 10),
                Text(
                  'Loading...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
