import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onItemTapped;

  const CustomBottomNavBar({
    Key? key,
    required this.selectedIndex,
    required this.onItemTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(
          icon: Icon(Icons.history), // Using history icon for Recent
          label: 'Recent',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
      ],
      currentIndex: selectedIndex, // The index of the currently selected tab
      selectedItemColor: Colors.blueAccent, // Color for the selected icon/label
      unselectedItemColor: Colors.grey, // Color for unselected icons/labels
      onTap: onItemTapped, // Callback function when a tab is tapped
      type: BottomNavigationBarType
          .fixed, // Ensures all labels are always visible
      // Use colorScheme.surface for the background, which is part of Material 3 theming
      backgroundColor: Theme.of(context).colorScheme.surface,
    );
  }
}
