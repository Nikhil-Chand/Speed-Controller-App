import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speed_controller/admin/adminController.dart';
import 'package:speed_controller/admin/adminNavBar.dart';
import 'package:speed_controller/admin/screens/dashboard/addSpeedBottomSheet.dart';
import 'package:speed_controller/iframework/bottomSheet.dart';
import 'package:speed_controller/iframework/container.dart';

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  AdminController controller = Get.find<AdminController>();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    controller.getNearbySpeedLimits(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      drawer: AdminNavigationDrawer(),
      body: Stack(
        children: [
          Obx(
            () => GoogleMap(
              markers: controller.markers.value,
              myLocationButtonEnabled: true,
              myLocationEnabled: true,
              trafficEnabled: true,
              onTap: (latlng) => showIBottomSheet(
                  context,
                  AddSpeedBottomSheet(
                    latLng: latlng,
                  )),
              initialCameraPosition: CameraPosition(
                  target: LatLng(18.451751, 83.666226), zoom: 15),
            ),
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
