// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../models/locations.dart';

class MapDetailsScreen extends StatelessWidget {
  final Locations location;

  MapDetailsScreen(this.location);





  late final startPos = LatLng(location.startLat!.toDouble(), location.startLng!.toDouble());
  late final checkPoint1Pos = LatLng(location.checkpoint1Lat!.toDouble(), location.checkpoint1Lng!.toDouble());
  late final checkPoint2Pos = LatLng(location.checkpoint2Lat!.toDouble(), location.checkpoint2Lng!.toDouble());
  late final checkPoint3Pos = LatLng(location.checkpoint3Lat!.toDouble(), location.checkpoint3Lng!.toDouble());
  late final finishPos = LatLng(location.finishLat!.toDouble(), location.finishLng!.toDouble());

  late final Marker _startPos = Marker(
    markerId: const MarkerId('_startPos'),
    infoWindow: const InfoWindow(title: "Start"),
    icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
    position: startPos
  );

  late final Marker _finishPos = Marker(
      markerId: const MarkerId('_finishPos'),
      infoWindow: const InfoWindow(title: "Finish"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
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
        title: Text(location.title.toString()),
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
        myLocationEnabled: true
      ),
    );
  }
}

class LitterMapDetailsScreen extends StatelessWidget {
  final Locations location;

  LitterMapDetailsScreen(this.location);





  late final startPos = LatLng(location.startLat!.toDouble(), location.startLng!.toDouble());
  late final checkPoint1Pos = LatLng(location.checkpoint1Lat!.toDouble(), location.checkpoint1Lng!.toDouble());
  late final checkPoint2Pos = LatLng(location.checkpoint2Lat!.toDouble(), location.checkpoint2Lng!.toDouble());
  late final checkPoint3Pos = LatLng(location.checkpoint3Lat!.toDouble(), location.checkpoint3Lng!.toDouble());
  late final finishPos = LatLng(location.finishLat!.toDouble(), location.finishLng!.toDouble());

  late final Marker _startPos = Marker(
      markerId: const MarkerId('_startPos'),
      infoWindow: const InfoWindow(title: "Start"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
      position: startPos
  );

  late final Marker _finishPos = Marker(
      markerId: const MarkerId('_finishPos'),
      infoWindow: const InfoWindow(title: "Finish"),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
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
        title: Text(location.title.toString()),
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
          myLocationEnabled: true
      ),
    );
  }
}
