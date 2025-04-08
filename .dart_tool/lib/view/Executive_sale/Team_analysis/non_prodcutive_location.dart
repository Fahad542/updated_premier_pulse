import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mvvm/res/color.dart';

class nonpro_location extends StatefulWidget {
  final String name;
  final double lat;
  final double long;

  nonpro_location({required this.lat, required this.long, required this.name});

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<nonpro_location> {
  late GoogleMapController mapController;
  late CameraPosition _initialPosition;
  late LatLng _center;

  @override
  void initState() {
    super.initState();
    _center = LatLng(widget.lat, widget.long); // Correctly access lat and long from widget
    _initialPosition = CameraPosition(
      target: _center,
      zoom: 10.0,
    );
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: AppColors.greencolor,
          title: Text(widget.name)),
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: _initialPosition,
        markers: {
          Marker(
            markerId: MarkerId('marker_1'),
            position: _center,
            infoWindow: InfoWindow(
              title: 'Location',
              snippet: 'Latitude: ${_center.latitude}, Longitude: ${_center.longitude}',
            ),
          ),
        },
      ),
    );
  }
}

