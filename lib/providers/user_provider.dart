import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Required for User type
import 'package:classroom_navigator/services/auth_service.dart';

class UserProvider with ChangeNotifier {
  User? _user; // Holds the current authenticated user
  final AuthService _authService =
      AuthService(); // Instance of our authentication service

  User? get user => _user; // Getter to access the user object

  UserProvider() {
    // Listen to the authentication state changes from AuthService
    // This will automatically update _user and notify all widgets listening to this provider
    _authService.user.listen((user) {
      _user = user;
      notifyListeners(); // Notify all widgets that depend on this provider
    });
  }

  // Method to trigger Google Sign-In via AuthService
  Future<void> signIn() async {
    await _authService.signInWithGoogle();
  }

  // Method to trigger Sign-Out via AuthService
  Future<void> signOut() async {
    await _authService.signOut();
  }
}
