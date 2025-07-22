import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart'; // To get user data from Firebase
import 'package:classroom_navigator/widgets/greeting_box.dart';
import 'package:classroom_navigator/widgets/location_search_dropdown.dart';
import 'package:classroom_navigator/widgets/classroom_map_view.dart';
import 'package:classroom_navigator/widgets/custom_bottom_nav_bar.dart';
import 'package:classroom_navigator/screens/recent_screen.dart';
import 'package:classroom_navigator/screens/settings_screen.dart';
import 'package:classroom_navigator/screens/full_map_screen.dart'; // NEW: Import the new full map screen
import 'package:classroom_navigator/services/data_service.dart'; // To get classroom data

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex =
      0; // Controls which item is selected in the BottomNavigationBar
  String? fromLocation; // Stores the selected 'FROM' location
  String? toLocation; // Stores the selected 'TO' location
  List<String> allClassrooms =
      []; // Will store names of all available classrooms

  @override
  void initState() {
    super.initState();
    _loadClassroomNames(); // Load classroom names when the screen initializes
  }

  // Asynchronously loads classroom names from the DataService
  Future<void> _loadClassroomNames() async {
    final dataService =
        DataService(); // Create an instance of your data service
    final classrooms = dataService
        .getClassrooms(); // Get the list of all classrooms
    setState(() {
      allClassrooms = classrooms
          .map((c) => c.name)
          .toList(); // Extract names for dropdown
      // Optional: Pre-select default values for FROM/TO if data is available
      if (allClassrooms.isNotEmpty) {
        fromLocation = allClassrooms.first;
        if (allClassrooms.length > 1) {
          toLocation = allClassrooms[1]; // Select second item if available
        } else {
          toLocation = allClassrooms.first; // Or just the first if only one
        }
      }
    });
  }

  // Callback function for when a BottomNavigationBar item is tapped
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });

    // Handle navigation to different screens based on the tapped index
    if (index == 0) {
      // Already on Home, do nothing or scroll to top
    } else if (index == 1) {
      // Navigate to RecentScreen, replacing the current screen in the navigation stack
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => RecentScreen()),
      );
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
    // Access the authenticated user from the Provider stream.
    final user = Provider.of<User?>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Classroom Navigator'),
        automaticallyImplyLeading:
            false, // Hides the back button on this root screen
      ),
      body: SingleChildScrollView(
        // Allows the content to scroll if it overflows
        padding: const EdgeInsets.all(
          16.0,
        ), // Padding around the entire content
        child: Column(
          crossAxisAlignment:
              CrossAxisAlignment.start, // Aligns children to the start (left)
          children: [
            // 1. The Greeting Box component
            GreetingBox(
              userName:
                  user?.displayName ??
                  'User', // Pass user's display name, default to 'User'
              userPhotoUrl: user?.photoURL, // Pass user's photo URL
            ),
            SizedBox(height: 20), // Space after the greeting box
            // 2. "FROM" Location Search/Dropdown
            LocationSearchDropdown(
              label: 'FROM Location',
              onLocationSelected: (location) {
                setState(() {
                  fromLocation = location; // Update the selected FROM location
                });
              },
              suggestions:
                  allClassrooms, // Provide all classroom names as suggestions
              initialValue:
                  fromLocation, // Pre-fill with current FROM selection
            ),
            SizedBox(height: 15), // Space between dropdowns
            // 3. "TO" Location Search/Dropdown
            LocationSearchDropdown(
              label: 'TO Location',
              onLocationSelected: (location) {
                setState(() {
                  toLocation = location; // Update the selected TO location
                });
              },
              suggestions:
                  allClassrooms, // Provide all classroom names as suggestions
              initialValue: toLocation, // Pre-fill with current TO selection
            ),
            SizedBox(height: 20), // Space before the map section
            // 4. Map Section Title
            Text(
              'Route Overview',
              style: Theme.of(
                context,
              ).textTheme.titleLarge, // Larger title for section
            ),
            SizedBox(height: 10), // Space between title and map
            // 5. The Map View component (in a fixed-height container)
            Container(
              height: 300, // Fixed height for the map container
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey), // Border around the map
                borderRadius: BorderRadius.circular(8.0), // Rounded corners
              ),
              child: ClassroomMapView(
                fromLocationName:
                    fromLocation, // Pass selected FROM location to map
                toLocationName: toLocation, // Pass selected TO location to map
              ),
            ),
            SizedBox(height: 16), // Space between map and button
            // NEW: Full Map View Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () {
                  // Navigate to the FullMapScreen
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => FullMapScreen(
                        fromLocationName: fromLocation,
                        toLocationName: toLocation,
                      ),
                    ),
                  );
                },
                icon: Icon(Icons.fullscreen),
                label: Text('Full Map View'),
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(
        selectedIndex: _selectedIndex, // Pass the current selected index
        onItemTapped: _onItemTapped, // Pass the callback for item taps
      ),
    );
  }
}
