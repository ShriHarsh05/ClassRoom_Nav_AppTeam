import 'package:flutter/material.dart';
import 'package:classroom_navigator/widgets/custom_bottom_nav_bar.dart';
import 'package:classroom_navigator/screens/home_screen.dart';
import 'package:classroom_navigator/screens/settings_screen.dart';

class RecentScreen extends StatelessWidget {
  // Helper function to handle navigation from the bottom bar
  void _onItemTapped(BuildContext context, int index) {
    if (index == 0) {
      // Navigate to HomeScreen, replacing the current screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else if (index == 1) {
      // Already on RecentScreen, do nothing
    } else if (index == 2) {
      // Navigate to SettingsScreen, replacing the current screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SettingsScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recent Locations'),
        automaticallyImplyLeading: false, // Hides the back button
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.history,
              size: 80,
              color: Colors.grey[400],
            ), // Placeholder icon
            SizedBox(height: 16),
            Text(
              'No recent searches yet.',
              style: TextStyle(fontSize: 18, color: Colors.grey),
            ),
            Text(
              'Your past navigations will appear here.',
              style: TextStyle(fontSize: 14, color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 1, // Index 1 corresponds to "Recent"
        onItemTapped: (index) => _onItemTapped(context, index),
      ),
    );
  }
}
