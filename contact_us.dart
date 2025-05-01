import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dashboard.dart'; // Import MainPage from main.dart

class ContactUsPage extends StatelessWidget {
  final Uri _locationUrl = Uri.parse('https://maps.app.goo.gl/nLLL3VcpxyWMDTKN6');
  final Uri _emailLaunchUri = Uri(
    scheme: 'mailto',
    path: 'paradisebeachtrombol@gmail.com',
  );

  Future<void> _launchMap() async {
    if (!await launchUrl(_locationUrl, mode: LaunchMode.externalApplication)) {
      throw 'Could not launch $_locationUrl';
    }
  }

  Future<void> _launchEmail() async {
    if (!await launchUrl(_emailLaunchUri)) {
      throw 'Could not launch $_emailLaunchUri';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF0F7EC),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Contact Us",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate back to TrombolHomePage when back button is tapped
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (context) => TrombolHomePage()),
                      );
                    },
                    child: const Text(
                      "<Back",
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 6,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                      child: GestureDetector(
                        onTap: _launchMap,
                        child: Image.asset(
                          'assets/image/map.jpg', // your custom image
                          fit: BoxFit.cover,
                          height: 180,
                          width: double.infinity,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Icon(Icons.location_on, color: Colors.green, size: 30),
                    const SizedBox(height: 8),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        "Paradise Beach Trombol,\n"
                            "Jalan Kpg Trombol,\n"
                            "Jalan Telaga Air,\n"
                            "Jalan Matang, Kuching, Malaysia, 93050",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Icon(Icons.email, color: Colors.green, size: 30),
                    const SizedBox(height: 8),
                    GestureDetector(
                      onTap: _launchEmail,
                      child: const Padding(
                        padding: EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          "paradisebeachtrombol@gmail.com",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.black87,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: 2,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.green,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.message), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
        ],
        onTap: (index) {
          if (index == 0) {
            // Navigate back to TrombolHomePage
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => TrombolHomePage()),
            );
          }
        },
      ),
    );
  }
}
