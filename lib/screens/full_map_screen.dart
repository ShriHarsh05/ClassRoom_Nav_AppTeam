import 'package:flutter/material.dart';
import 'package:classroom_navigator/widgets/classroom_map_view.dart'; // Import the map view widget

class FullMapScreen extends StatelessWidget {
  final String? fromLocationName;
  final String? toLocationName;

  const FullMapScreen({Key? key, this.fromLocationName, this.toLocationName})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Full Map View')),
      body: ClassroomMapView(
        // Display the ClassroomMapView in full screen
        fromLocationName: fromLocationName,
        toLocationName: toLocationName,
      ),
    );
  }
}
