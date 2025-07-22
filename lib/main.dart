import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import 'package:classroom_navigator/services/auth_service.dart';
import 'package:classroom_navigator/providers/user_provider.dart';
import 'package:classroom_navigator/screens/auth_wrapper.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(
    MultiProvider(
      providers: [
        // Provides the Firebase User stream to widgets down the tree
        StreamProvider<User?>(
          create: (_) => AuthService().user,
          initialData: null,
          catchError: (context, error) {
            print('Error in Auth Stream: $error');
            return null; // Return null on error for unauthenticated state
          },
        ),
        // Provides our custom UserProvider for managing sign-in/out
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Classroom Navigator',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: AuthWrapper(), // Manages authentication state and screen display
    );
  }
}
