import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';  // Importing shared_preferences for session management
import 'account.dart'; // Importing the ChangeProfilePage
import 'contact_us.dart'; // Importing the ContactUsPage
import 'password_update.dart';   // Importing the ChangePasswordPage
import 'splash_screen.dart';  // Importing the SplashScreen

class TrombolSettingsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);  // This will navigate back to the home screen
          },
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: ListView(
            children: [
              const SizedBox(height: 20),
              sectionHeader("Account"),
              const SizedBox(height: 12),
              settingsTile(Icons.person, "Account", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangeProfilePage()),
                );
              }),
              settingsTile(Icons.lock, "Password", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ChangePasswordPage()),
                );
              }),
              settingsTile(Icons.logout, "Logout", () {
                _logout(context);
              }),
              const SizedBox(height: 30),
              sectionHeader("Support"),
              const SizedBox(height: 12),
              settingsTile(Icons.contact_mail, "Contact Us", () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContactUsPage()),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  Widget sectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        const Text("",
            style: TextStyle(color: Colors.grey, fontWeight: FontWeight.w500)),
      ],
    );
  }

  Widget settingsTile(IconData icon, String title, VoidCallback onTap) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
              color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
        ],
      ),
      child: InkWell(
        onTap: onTap,
        child: Row(
          children: [
            Icon(icon, color: Colors.green),
            const SizedBox(width: 12),
            Text(title,
                style: const TextStyle(
                    fontSize: 14, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  // Logout functionality
  Future<void> _logout(BuildContext context) async {
    // Clear any stored session or user data using shared_preferences (if any)
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // This clears the stored preferences data (you can customize this as needed)

    // Navigate to the splash screen (this will also remove the current screen from the navigation stack)
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SplashScreen()),
    );
  }
}
