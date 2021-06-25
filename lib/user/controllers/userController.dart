import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoder/geocoder.dart' as geocoder;
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserController extends GetX {
  RxInt currentSpeed = 0.obs;
  RxSet<Marker> markers = <Marker>{}.obs;
  final geo = Geoflutterfire();
  Rx<DocumentSnapshot> nearestDoc;
  RxInt maxSpeed = 0.obs;
  final _firestore = FirebaseFirestore.instance;
  Rx<Position> currentLocation = Position(latitude: 18, longitude: 82).obs;
  Completer<GoogleMapController> gMapController = Completer();

  getNearbySpeedLimits(Position currentLocation) async {
    // Create a geoFirePoint
    GeoFirePoint center = geo.point(
      latitude: currentLocation.latitude,
      longitude: currentLocation.longitude,
    );

    var collectionReference = _firestore.collection('locations');

    geo
        .collection(collectionRef: collectionReference)
        .within(
            center: center, radius: 0.5, field: "position", strictMode: true)
        .listen((event) {
      markers.clear();
      nearestDoc = null;
      double prevDistance;
      event.forEach((doc) {
        GeoPoint geoPoint = doc.data()['position']['geopoint'];

        GeoFirePoint geoFirePoint = geo.point(
            latitude: geoPoint.latitude, longitude: geoPoint.longitude);

        double distance = geoFirePoint.haversineDistance(
            lat: currentLocation.latitude, lng: currentLocation.longitude);
        if (prevDistance == null || prevDistance > distance) {
          nearestDoc = doc.obs;
          maxSpeed.value = doc.data()['speed'];
        }

        markers.add(
          Marker(
            markerId: MarkerId(doc.id),
            position: LatLng(geoPoint.latitude, geoPoint.longitude),
            infoWindow: InfoWindow(
                title: doc.data()['address'],
                snippet: doc.data()['speed'].toString() + " kmph"),
          ),
        );
      });
    });
  }

  getCurrentLocation() {
    Position prevCoordinates;
    Geolocator.getPositionStream(
      desiredAccuracy: LocationAccuracy.best,
      intervalDuration: Duration(seconds: 2),
    ).listen((event) async {
      currentLocation.value = event;
      final GoogleMapController controller = await gMapController.future;
      controller.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
          bearing: 0.0,
          target: LatLng(event.latitude, event.longitude),
          tilt: 0.0,
          zoom: 15)));
      if (prevCoordinates != null) {
        double distance = Geolocator.distanceBetween(
              prevCoordinates.latitude,
              prevCoordinates.longitude,
              event.latitude,
              event.longitude,
            ) *
            0.001;
        currentSpeed.value = (distance * (3600 / 2)).round();
      }

      prevCoordinates = event;
      print("Max speed: " +
          maxSpeed.value.toString() +
          " current: " +
          currentSpeed.value.toString());
      if (maxSpeed.value != 0 && maxSpeed.value < currentSpeed.value) {
        markFine();
      }
      getNearbySpeedLimits(event);
    });
  }

  markFine() async {
    print("Hello");
    await FirebaseFirestore.instance.collection("fines").doc().set({
      "paid": false,
      "geopoint": GeoPoint(
          currentLocation.value.latitude, currentLocation.value.longitude),
      "timestamp": FieldValue.serverTimestamp(),
      "uid": "1",
      "amount": 500,
      "speed": currentSpeed.value,
      "address": (await geocoder.Geocoder.local
              .findAddressesFromCoordinates(geocoder.Coordinates(
        currentLocation.value.latitude,
        currentLocation.value.longitude,
      )))[0]
          .locality
    });
  }
}
