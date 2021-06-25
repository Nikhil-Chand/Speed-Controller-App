import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:speed_controller/iframework/container.dart';
import 'package:speed_controller/iframework/text_widget.dart';
import 'package:speed_controller/user/controllers/userController.dart';
import 'package:speed_controller/user/screens/dashboard/top_card_tile.dart';
import 'package:speed_controller/widgets/loadingIndicator.dart';

class TopCard extends StatelessWidget {
  final UserController controller = Get.find<UserController>();
  @override
  Widget build(BuildContext context) {
    return IContainer(
      margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
      padding: EdgeInsets.all(10),
      radius: BorderRadius.circular(20),
      elevation: 5,
      color: Colors.white,
      child: Row(
        children: [
          Obx(
            () => Expanded(
              child: Column(
                children: [
                  IText(
                    text: controller.currentSpeed.toString(),
                    fontSize: 75,
                    color: Colors.green[900],
                  ),
                  IText(
                    text: "kmph",
                    fontSize: 16,
                    color: Colors.green[900],
                  )
                ],
              ),
            ),
          ),
          Container(
            height: 100,
            child: VerticalDivider(
              color: Colors.grey[200],
              thickness: 1,
              width: 10,
            ),
          ),
          Obx(
            () => Expanded(
              child: Column(
                children: [
                  FutureBuilder(
                      future: Geocoder.local.findAddressesFromCoordinates(
                          Coordinates(controller.currentLocation.value.latitude,
                              controller.currentLocation.value.longitude)),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting)
                          return TopCardTile(
                              icon: Icons.location_on, title: "--");

                        return TopCardTile(
                            icon: Icons.location_on,
                            title: snapshot.data[0].locality);
                      }),
                  TopCardTile(
                      icon: Icons.speed,
                      title: controller.maxSpeed.value.toString() + " kmph"),
                  TopCardTile(
                      icon: Icons.traffic,
                      title: controller.nearestDoc == null
                          ? "--"
                          : controller.nearestDoc.value.data()['traffic']),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
