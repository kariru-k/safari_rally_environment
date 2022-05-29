import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/locations.dart';

class MapDetailsScreen extends StatelessWidget {
  final Locations location;

  MapDetailsScreen(this.location);

  late final startPos = LatLng(location.startLat, location.startLng);
  late final checkPoint1Pos = LatLng(location.checkpoint1Lat, location.checkpoint1Lng);
  late final checkPoint2Pos = LatLng(location.checkpoint2Lat, location.checkpoint2Lng);
  late final checkPoint3Pos = LatLng(location.checkpoint3Lat, location.checkpoint3Lng);
  late final finishPos = LatLng(location.finishLat, location.finishLng);

  late final Marker _startPos = Marker(
    markerId: MarkerId('_startPos'),
    infoWindow: InfoWindow(title: "Start"),
    icon: BitmapDescriptor.defaultMarker,
    position: startPos
  );

  late final Marker _finishPos = Marker(
      markerId: MarkerId('_finishPos'),
      infoWindow: InfoWindow(title: "Finish"),
      icon: BitmapDescriptor.defaultMarker,
      position: finishPos
  );

  late final Marker _checkPoint1 = Marker(
      markerId: const MarkerId('_CheckPoint1'),
      infoWindow: const InfoWindow(title: "Checkpoint 1"),
      icon: BitmapDescriptor.defaultMarker,
      position: checkPoint1Pos
  );

  late final Marker _checkPoint2 = Marker(
      markerId: const MarkerId('_CheckPoint2'),
      infoWindow: const InfoWindow(title: "Checkpoint 2"),
      icon: BitmapDescriptor.defaultMarker,
      position: checkPoint2Pos
  );

  late final Marker _checkPoint3 = Marker(
      markerId:const  MarkerId('_CheckPoint3'),
      infoWindow: const InfoWindow(title: "Checkpoint 3"),
      icon: BitmapDescriptor.defaultMarker,
      position: checkPoint3Pos
  );

  late final _initialCameraPosition = CameraPosition(
    target: startPos,
    zoom: 11.5
  );


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(location.title),
      ),
      body: GoogleMap(
        mapType: MapType.hybrid,
        markers: {
          _startPos,
          _finishPos,
          _checkPoint1,
          _checkPoint2,
          _checkPoint3
        },
        initialCameraPosition: _initialCameraPosition,
      ),
    );
  }
}
