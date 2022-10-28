import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../bootstrap.dart';
import '../../shared/variables.dart' as globals;

class Carte extends StatefulWidget {
  @override
  State<Carte> createState() => CarteState();
}

class CarteState extends State<Carte> {
  final Completer<GoogleMapController> _controller = Completer();

  static const CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  static const CameraPosition _kLake = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(37.43296265331129, -122.08832357078792),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        Align(
          alignment: const Alignment(-.9, .9),
          child: FloatingActionButton.extended(
            onPressed: _goToTheLake,
            label: const Text('Recalibrate'),
            icon: const Icon(IconData(0xe418, fontFamily: 'MaterialIcons')),
          ),
        ),
        Align(
          alignment: const Alignment(-.95, -.95),
          child: IconButton(
            icon: const Icon(
              IconData(0xe354, fontFamily: 'MaterialIcons'),
              size: 35,
            ),
            color: Colors.black,
            onPressed: goBack,
          ),
        ),
      ],
    );
  }

  Future<void> _goToTheLake() async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newCameraPosition(_kLake));
  }

  void goBack() {
    globals.Variables.selectedIndex = 1;
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => Bootstrap()));
  }
}
