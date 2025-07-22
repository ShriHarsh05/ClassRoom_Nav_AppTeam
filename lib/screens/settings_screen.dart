import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:classroom_navigator/widgets/custom_bottom_nav_bar.dart';
import 'package:classroom_navigator/providers/user_provider.dart';
import 'package:classroom_navigator/screens/home_screen.dart';
import 'package:classroom_navigator/screens/recent_screen.dart';

class SettingsScreen extends StatelessWidget {
  // Helper function to handle navigation from the bottom bar
  void _onItemTapped(BuildContext context, int index) {
    if (index == 0) {
      // Navigate to HomeScreen, replacing the current screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen()),
      );
    } else if (index == 1) {
      // Navigate to RecentScreen, replacing the current screen
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RecentScreen()),
      );
    } else if (index == 2) {
      // Already on SettingsScreen, do nothing
    }
  }

  @override
  Widget build(BuildContext context) {
    // Access the UserProvider to call the signOut method
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        automaticallyImplyLeading: false, // Hides the back button
      ),
      body: ListView(
        // Use ListView to make the content scrollable if needed
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Account',
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(color: Colors.grey[700]),
            ),
          ),
          ListTile(
            title: const Text('Sign Out'),
            leading: const Icon(Icons.logout),
            onTap: () async {
              // Perform sign out
              await userProvider.signOut();

              // Show the sign-out confirmation pop-up
              showDialog(
                context: context,
                barrierDismissible: false, // User must tap a button to dismiss
                builder: (BuildContext dialogContext) {
                  return AlertDialog(
                    title: const Text('Signed Out'),
                    content: const Text(
                      'You have been successfully signed out.\n\nPlease sign in again to continue using the app.',
                    ),
                    actions: <Widget>[
                      // Removed the 'OK' button, only 'Sign In Again' remains
                      TextButton(
                        child: const Text('Sign In Again'),
                        onPressed: () async {
                          Navigator.of(
                            dialogContext,
                          ).pop(); // Dismiss the dialog
                          // Attempt to sign in again
                          await userProvider.signIn();
                          // AuthWrapper will handle navigation to HomeScreen if sign-in is successful
                          // Otherwise, it will remain on LoginScreen if sign-in fails
                          Navigator.of(
                            context,
                          ).popUntil((route) => route.isFirst);
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
          const Divider(), // Visual separator
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'App Info',
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(color: Colors.grey[700]),
            ),
          ),
          ListTile(
            title: const Text('About App'),
            leading: const Icon(Icons.info_outline),
            onTap: () {
              // Show a standard About dialog
              showAboutDialog(
                context: context,
                applicationName: 'Classroom Navigator',
                applicationVersion: '1.0.0',
                applicationLegalese:
                    '© 2025 Your College Name. All rights reserved.',
                children: [
                  const Padding(
                    padding: EdgeInsets.only(top: 10.0),
                    child: Text(
                      'This app helps you navigate to classrooms within your college campus.',
                    ),
                  ),
                ],
              );
            },
          ),
          ListTile(
            title: const Text('Privacy Policy'),
            leading: const Icon(Icons.privacy_tip_outlined),
            onTap: () {
              // Placeholder for future Privacy Policy page/dialog
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Privacy Policy coming soon!')),
              );
            },
          ),
          ListTile(
            title: const Text('Terms of Service'),
            leading: const Icon(Icons.description),
            onTap: () {
              // Placeholder for future Terms of Service page/dialog
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Terms of Service coming soon!')),
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: 2, // Index 2 corresponds to "Settings"
        onItemTapped: (index) => _onItemTapped(context, index),
      ),
    );
  }
}
