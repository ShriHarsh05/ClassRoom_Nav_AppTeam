import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:classroom_navigator/providers/user_provider.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Access the UserProvider to call signIn method.
    // listen: false because we only need to call a method, not rebuild on changes.
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome to Classroom Navigator'),
        centerTitle: true,
        elevation: 0, // No shadow for a cleaner look
      ),
      body: Center(
        child: SingleChildScrollView(
          // Allows content to scroll on smaller screens
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.school, // A school icon for visual appeal
                size: 100,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(height: 20),
              Text(
                'Find Your Way Around Campus!',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Never get lost in your large college campus again. Sign in to find the fastest routes to any classroom.',
                style: Theme.of(context).textTheme.bodyMedium,
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              ElevatedButton.icon(
                onPressed: () async {
                  // Show a temporary SnackBar to indicate sign-in is in progress
                  ScaffoldMessenger.of(
                    context,
                  ).showSnackBar(SnackBar(content: Text('Signing in...')));
                  await userProvider.signIn();
                  // The SnackBar will automatically disappear when AuthWrapper rebuilds and navigates
                },
                icon: Image.asset(
                  'assets/google_logo.png', // Ensure this asset exists and is declared in pubspec.yaml
                  height: 24.0,
                ),
                label: Text(
                  'Sign in with Google',
                  style: TextStyle(fontSize: 18),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(
                    255,
                    0,
                    0,
                    0,
                  ), // Darker shade of blue
                  foregroundColor: Colors.white, // White text
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      10,
                    ), // Rounded corners for the button
                  ),
                  minimumSize: Size(
                    double.infinity,
                    50,
                  ), // Make button take full width
                ),
              ),
              SizedBox(height: 20),
              Text(
                'Please sign in to access classroom navigation features.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
