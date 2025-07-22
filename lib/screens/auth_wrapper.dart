import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Required for User type
import 'package:provider/provider.dart';
import 'package:classroom_navigator/screens/home_screen.dart';
import 'package:classroom_navigator/screens/login_screen.dart';

class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Listen to the Firebase User stream provided by the StreamProvider in main.dart
    final user = Provider.of<User?>(context);

    if (user == null) {
      // If there is no authenticated user, show the LoginScreen
      return LoginScreen();
    } else {
      // If a user is logged in, show the HomeScreen
      return HomeScreen();
    }
  }
}
