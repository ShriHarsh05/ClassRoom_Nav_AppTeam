import 'package:classroom_navigator/models/classroom_model.dart';

class DataService {
  // Dummy data for classrooms. In a real app, this would come from Firestore,
  // a local database, or an API.
  // Coordinates are rough estimates for the Vellore area for demonstration on an outdoor map.
  final List<Classroom> _classrooms = [
    Classroom(
      id: '1',
      name: 'G.D. Naidu Block - G07 Survey Lab',
      building: 'G.D. Naidu Block',
      floor: 'Ground Floor',
      latitude: 12.971936,
      longitude: 79.159450,
    ),
    Classroom(
      id: '2',
      name: 'G.D. Naidu Block - G08A Classroom',
      building: 'G.D. Naidu Block',
      floor: 'Ground Floor',
      latitude: 12.972050,
      longitude: 79.159600,
    ),
    Classroom(
      id: '3',
      name: 'G.D. Naidu Block - G16 Machine Shop',
      building: 'G.D. Naidu Block',
      floor: 'Ground Floor',
      latitude: 12.971700,
      longitude: 79.160100,
    ),
    Classroom(
      id: '4',
      name: 'Main Gate',
      building: 'Campus',
      floor: 'Ground',
      latitude: 12.970100,
      longitude: 79.158500,
    ),
    Classroom(
      id: '5',
      name: 'Library Building - Ground Floor',
      building: 'Library',
      floor: 'Ground Floor',
      latitude: 12.973000,
      longitude: 79.159000,
    ),
    Classroom(
      id: '6',
      name: 'Library Building - First Floor',
      building: 'Library',
      floor: 'First Floor',
      latitude: 12.973050,
      longitude: 79.159050,
    ),
    Classroom(
      id: '7',
      name: 'Block A - Room 101',
      building: 'Block A',
      floor: 'First Floor',
      latitude: 12.972500,
      longitude: 79.160500,
    ),
    Classroom(
      id: '8',
      name: 'Block A - Room 205',
      building: 'Block A',
      floor: 'Second Floor',
      latitude: 12.972550,
      longitude: 79.160550,
    ),
    Classroom(
      id: '9',
      name: 'Auditorium - Main Hall',
      building: 'Auditorium',
      floor: 'Ground Floor',
      latitude: 12.971500,
      longitude: 79.158800,
    ),
    Classroom(
      id: '10',
      name: 'Canteen Complex',
      building: 'Canteen',
      floor: 'Ground',
      latitude: 12.970800,
      longitude: 79.159800,
    ),
    // You would add more specific classroom data from your maps here
  ];

  List<Classroom> getClassrooms() {
    return _classrooms;
  }

  // Method to get a Classroom object by its name
  Classroom? getClassroomByName(String name) {
    try {
      return _classrooms.firstWhere((classroom) => classroom.name == name);
    } catch (e) {
      print('Classroom with name $name not found: $e');
      return null;
    }
  }

  // Future method for indoor pathfinding (conceptual)
  // This would involve converting string names to a map-specific ID/coordinates
  // and then running a pathfinding algorithm.
  // Future<List<MapPathPoint>> getIndoorPath(String fromId, String toId, String floor) async {
  //   // Placeholder for pathfinding logic
  //   // This is where you'd use your grid map data and algorithms
  //   await Future.delayed(Duration(seconds: 1)); // Simulate network delay
  //   return [];
  // }
}
