import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  // Stream to listen to authentication state changes (User logged in/out)
  Stream<User?> get user => _auth.authStateChanges();

  // Method to sign in with Google
  Future<User?> signInWithGoogle() async {
    try {
      // Trigger the Google Sign-In flow
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      // If user cancels the sign-in, googleUser will be null
      if (googleUser == null) {
        return null;
      }

      // Obtain the authentication details from the Google user
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Create a Firebase credential using Google's ID token and access token
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      // Sign in to Firebase with the Google credential
      UserCredential userCredential = await _auth.signInWithCredential(
        credential,
      );
      return userCredential.user; // Return the Firebase User object
    } catch (e) {
      print('Error signing in with Google: $e');
      // In a production app, you would show a more user-friendly error message here (e.g., SnackBar)
      return null;
    }
  }

  // Method to sign out from both Google and Firebase
  Future<void> signOut() async {
    try {
      await _googleSignIn.signOut(); // Sign out from Google account
      await _auth.signOut(); // Sign out from Firebase
    } catch (e) {
      print('Error signing out: $e');
      // Handle sign-out errors gracefully
    }
  }
}
