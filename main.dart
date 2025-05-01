import 'package:flutter/material.dart';
import 'splash_screen.dart'; // Import splash screen
import 'activity.dart';
import 'event.dart';
import 'setting.dart';     // Settings page
import 'contact_us.dart'; // Contact Us page
import 'dashboard.dart';  // New: Dashboard file

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(), // Set SplashScreen as the initial route
    );
  }
}
