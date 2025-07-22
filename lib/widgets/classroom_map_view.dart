import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:geolocator/geolocator.dart';
import 'package:classroom_navigator/services/data_service.dart';
import 'package:classroom_navigator/models/classroom_model.dart';

class ClassroomMapView extends StatefulWidget {
  final String? fromLocationName;
  final String? toLocationName;

  const ClassroomMapView({Key? key, this.fromLocationName, this.toLocationName})
    : super(key: key);

  @override
  _ClassroomMapViewState createState() => _ClassroomMapViewState();
}

class _ClassroomMapViewState extends State<ClassroomMapView> {
  final MapController _mapController = MapController();
  LatLng? _currentLocation;
  final DataService _dataService = DataService();
  bool _isMapReady = false;

  @override
  void initState() {
    super.initState();
    _initLocationAndMap(); // Call a new method to handle async init
  }

  // New method to handle asynchronous initialization and error handling
  Future<void> _initLocationAndMap() async {
    try {
      await _getCurrentLocation(); // Attempt to get current location
    } catch (e) {
      // Show a user-friendly message if location services are disabled or permissions denied
      if (mounted) {
        // Check if the widget is still in the widget tree
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Location error: $e. Please enable location services and grant permissions.',
            ),
            duration: const Duration(seconds: 5),
          ),
        );
      }
      print('Caught error in _initLocationAndMap: $e');
    }
  }

  @override
  void didUpdateWidget(covariant ClassroomMapView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (_isMapReady &&
        (oldWidget.fromLocationName != widget.fromLocationName ||
            oldWidget.toLocationName != widget.toLocationName)) {
      _updateMapAndMarkers();
    }
  }

  Future<void> _getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw 'Location services are disabled.'; // Throw string for simplicity
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw 'Location permissions are denied.';
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw 'Location permissions are permanently denied.';
    }

    Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
    setState(() {
      _currentLocation = LatLng(position.latitude, position.longitude);
    });
    // Update map if it's already ready
    if (_isMapReady) {
      _updateMapAndMarkers();
    }
  }

  void _updateMapAndMarkers() {
    List<LatLng> pointsToFit = [];

    if (_currentLocation != null) {
      pointsToFit.add(_currentLocation!);
    }

    Classroom? fromClassroom;
    if (widget.fromLocationName != null) {
      fromClassroom = _dataService.getClassroomByName(widget.fromLocationName!);
      if (fromClassroom != null &&
          fromClassroom.latitude != null &&
          fromClassroom.longitude != null) {
        pointsToFit.add(
          LatLng(fromClassroom.latitude!, fromClassroom.longitude!),
        );
      }
    }

    Classroom? toClassroom;
    if (widget.toLocationName != null) {
      toClassroom = _dataService.getClassroomByName(widget.toLocationName!);
      if (toClassroom != null &&
          toClassroom.latitude != null &&
          toClassroom.longitude != null) {
        pointsToFit.add(LatLng(toClassroom.latitude!, toClassroom.longitude!));
      }
    }

    if (_isMapReady) {
      if (pointsToFit.isNotEmpty) {
        _mapController.fitCamera(
          CameraFit.bounds(
            bounds: LatLngBounds.fromPoints(pointsToFit),
            padding: const EdgeInsets.all(50.0),
          ),
        );
      } else {
        _mapController.move(const LatLng(12.971936, 79.159450), 15.0);
      }
    }
  }

  Marker? _buildLocationMarker(
    String locationName,
    Color color,
    IconData icon,
  ) {
    final classroom = _dataService.getClassroomByName(locationName);
    if (classroom != null &&
        classroom.latitude != null &&
        classroom.longitude != null) {
      return Marker(
        point: LatLng(classroom.latitude!, classroom.longitude!),
        width: 80,
        height: 80,
        child: Icon(icon, color: color, size: 40),
      );
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      mapController: _mapController,
      options: MapOptions(
        initialCenter: _currentLocation ?? const LatLng(12.971936, 79.159450),
        initialZoom: 15.0,
        interactionOptions: const InteractionOptions(
          flags: ~InteractiveFlag.rotate,
        ),
        onMapReady: () {
          setState(() {
            _isMapReady = true;
          });
          _updateMapAndMarkers();
        },
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.example.classroom_navigator',
        ),
        MarkerLayer(
          markers: [
            if (_currentLocation != null)
              Marker(
                point: _currentLocation!,
                width: 80,
                height: 80,
                child: const Icon(
                  Icons.location_on,
                  color: Colors.blue,
                  size: 40,
                ),
              ),
            if (widget.fromLocationName != null)
              _buildLocationMarker(
                widget.fromLocationName!,
                Colors.green,
                Icons.pin_drop,
              ),
            if (widget.toLocationName != null)
              _buildLocationMarker(
                widget.toLocationName!,
                Colors.red,
                Icons.flag,
              ),
          ].whereType<Marker>().toList(),
        ),
      ],
    );
  }
}
