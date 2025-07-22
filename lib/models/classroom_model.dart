class Classroom {
  final String id;
  final String name;
  final String building;
  final String floor;
  final double?
  latitude; // For general campus map (Google Maps or OpenStreetMap)
  final double?
  longitude; // For general campus map (Google Maps or OpenStreetMap)
  // Add properties for indoor map grid coordinates later (e.g., final int? gridX, final int? gridY;)

  Classroom({
    required this.id,
    required this.name,
    required this.building,
    required this.floor,
    this.latitude,
    this.longitude,
  });

  // Factory constructor for creating a Classroom from JSON (useful if fetching from Firestore)
  factory Classroom.fromJson(Map<String, dynamic> json) {
    return Classroom(
      id: json['id'] as String,
      name: json['name'] as String,
      building: json['building'] as String,
      floor: json['floor'] as String,
      latitude: (json['latitude'] as num?)
          ?.toDouble(), // Handle null or different number types
      longitude: (json['longitude'] as num?)?.toDouble(),
      // Add gridX, gridY parsing here when implemented
    );
  }

  // Method to convert a Classroom object to JSON (useful for storing to Firestore)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'building': building,
      'floor': floor,
      'latitude': latitude,
      'longitude': longitude,
      // Add gridX, gridY here when implemented
    };
  }
}
