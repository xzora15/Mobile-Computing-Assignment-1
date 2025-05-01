import 'package:flutter/material.dart';
import 'welcome_page.dart'; // Import HomePage.dart file

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  double _opacity = 0.0; // Controls the opacity of the image.

  @override
  void initState() {
    super.initState();

    // Start the fade-in effect and navigate to HomePage after it finishes.
    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        _opacity = 1.0; // Make image fully visible after fade-in.
      });

      // Navigate to HomePage after the fade-in effect finishes
      Future.delayed(Duration(seconds: 2), () {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            transitionDuration: Duration(milliseconds: 800), // Transition speed
            pageBuilder: (context, animation, secondaryAnimation) => HomePage(),
            transitionsBuilder: (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0); // Start from the right
              const end = Offset.zero; // End at normal position
              var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: Curves.easeInOut));

              return SlideTransition(
                position: animation.drive(tween), // Apply slide transition
                child: child,
              );
            },
          ),
        );
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF6FBF4), // Splash screen background color
      body: Center(
        child: AnimatedOpacity(
          opacity: _opacity, // Current opacity value
          duration: Duration(seconds: 2), // Duration for the fade-in effect
          child: Image.asset(
            'assets/image/logo.png', // Path to your logo image
            width: 350.89,
            height: 310,
          ),
        ),
      ),
    );
  }
}
