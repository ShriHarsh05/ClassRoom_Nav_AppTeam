import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Required for date/time formatting

class GreetingBox extends StatelessWidget {
  final String userName;
  final String? userPhotoUrl; // Nullable as photo might not be available

  const GreetingBox({Key? key, required this.userName, this.userPhotoUrl})
    : super(key: key);

  // Helper method to determine the appropriate greeting based on current time
  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'Good Morning';
    } else if (hour < 17) {
      return 'Good Afternoon';
    } else {
      return 'Good Evening';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      decoration: BoxDecoration(
        color: Colors.blue.withOpacity(
          0.1,
        ), // Light blue background for the box
        borderRadius: BorderRadius.circular(12.0), // Rounded corners
      ),
      child: Row(
        children: [
          Expanded(
            // Takes up available space for text
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align text to the start
              children: [
                Text(
                  _getGreeting(), // Displays "Good Morning/Afternoon/Evening"
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.blue[800], // Darker blue for contrast
                  ),
                ),
                SizedBox(height: 4), // Small space between greeting and name
                Text(
                  userName, // Displays the user's name
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[900], // Even darker blue for emphasis
                  ),
                  overflow: TextOverflow
                      .ellipsis, // Prevents text from overflowing if name is too long
                ),
              ],
            ),
          ),
          SizedBox(width: 16), // Space between text and photo
          // User Photo (Circular Avatar)
          if (userPhotoUrl != null && userPhotoUrl!.isNotEmpty)
            CircleAvatar(
              radius: 30, // Size of the avatar
              backgroundImage: NetworkImage(
                userPhotoUrl!,
              ), // Load image from URL
              backgroundColor: Colors
                  .grey[200], // Fallback background if image fails to load
              onBackgroundImageError: (exception, stackTrace) {
                print(
                  'Error loading user photo: $exception',
                ); // Log error if photo fails
                // In a real app, you might update state to show a default icon
              },
            )
          else
            CircleAvatar(
              radius: 30,
              child: Icon(
                Icons.person,
                size: 30,
                color: Colors.white,
              ), // Default person icon
              backgroundColor: Colors.blue, // Default icon background
            ),
        ],
      ),
    );
  }
}
