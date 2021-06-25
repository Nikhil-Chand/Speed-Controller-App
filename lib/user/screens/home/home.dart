import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speed_controller/iframework/container.dart';
import 'package:speed_controller/user/controllers/userController.dart';
import 'package:speed_controller/user/screens/dashboard/top_card.dart';
import 'package:speed_controller/user/screens/navigation_drawer.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  UserController controller = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    controller.getCurrentLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: NavigationDrawer(),
      body: Stack(
        children: [
          Obx(
            () => GoogleMap(
              markers: controller.markers.value,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              trafficEnabled: true,
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController googleMapController) {
                controller.gMapController.complete(googleMapController);
              },
              initialCameraPosition: CameraPosition(
                  target: LatLng(18.451751, 83.666226), zoom: 15),
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              SizedBox(height: 60),
              Opacity(opacity: 0.8, child: TopCard()),
              SizedBox(height: 20),
            ],
          ),
          Positioned(
            top: 60,
            left: 20,
            child: IContainer(
              shape: BoxShape.circle,
              color: Colors.white,
              child: IconButton(
                  onPressed: () {
                    _scaffoldKey.currentState.openDrawer();
                  },
                  icon: Icon(Icons.menu)),
            ),
          ),
        ],
      ),
    );
  }
}
