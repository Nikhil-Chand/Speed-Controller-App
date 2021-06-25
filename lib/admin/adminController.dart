import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geocoder/geocoder.dart' as geocoder;
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speed_controller/iframework/bottomSheet.dart';

import 'screens/dashboard/addSpeedBottomSheet.dart';

class AdminController extends GetxController {
  RxSet<Marker> markers = <Marker>{}.obs;
  final geo = Geoflutterfire();
  final _firestore = FirebaseFirestore.instance;

  getNearbySpeedLimits(context) async {
    var currentLocation = await Geolocator.getCurrentPosition();
    // Create a geoFirePoint
    GeoFirePoint center = geo.point(
        latitude: currentLocation.latitude,
        longitude: currentLocation.longitude);

    var collectionReference = _firestore.collection('locations');

    geo
        .collection(collectionRef: collectionReference)
        .within(center: center, radius: 10, field: "position")
        .listen((event) {
      event.forEach((doc) {
        GeoPoint geopoint = doc.data()['position']['geopoint'];
        markers.add(
          Marker(
              markerId: MarkerId(doc.id),
              position: LatLng(geopoint.latitude, geopoint.longitude),
              infoWindow: InfoWindow(
                  title: doc.data()['place'],
                  snippet: doc.data()['speed'].toString() + " kmph"),
              onTap: () {
                print("Hello");
                showIBottomSheet(
                  context,
                  AddSpeedBottomSheet(
                    latLng: LatLng(geopoint.latitude, geopoint.longitude),
                    speed: doc.data()['speed'].toDouble(),
                    id: doc.id,
                  ),
                );
              }),
        );
      });
    });
  }

  addMarkerToMap(LatLng latlng, int speed, String id) async {
    GeoFirePoint myLocation =
        geo.point(latitude: latlng.latitude, longitude: latlng.longitude);
    List<geocoder.Address> placeName = await geocoder.Geocoder.local
        .findAddressesFromCoordinates(
            geocoder.Coordinates(latlng.latitude, latlng.longitude));

    print(placeName[0].locality);
    if (id != null) {
      _firestore.collection('locations').doc(id).set({
        "place": placeName[0].locality,
        "speed": speed,
        'position': myLocation.data
      });
      return;
    } else {
      _firestore.collection('locations').doc().set({
        "place": placeName[0].locality,
        "speed": speed,
        'position': myLocation.data
      });
    }

    markers.add(
      Marker(
        markerId: MarkerId((markers.length + 1).toString()),
        position: LatLng(latlng.latitude, latlng.longitude),
        infoWindow: InfoWindow(
          title: placeName[0].locality,
          snippet: speed.toString() + " kmph",
        ),
      ),
    );
  }
}
