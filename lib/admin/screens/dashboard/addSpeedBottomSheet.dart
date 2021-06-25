import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:speed_controller/admin/adminController.dart';
import 'package:speed_controller/iframework/container.dart';
import 'package:speed_controller/iframework/text_widget.dart';

class AddSpeedBottomSheet extends StatefulWidget {
  final LatLng latLng;
  double speed;
  String id;
  AddSpeedBottomSheet({this.latLng, this.speed = 0.0, this.id});
  @override
  _AddSpeedBottomSheetState createState() => _AddSpeedBottomSheetState();
}

class _AddSpeedBottomSheetState extends State<AddSpeedBottomSheet> {
  @override
  Widget build(BuildContext context) {
    return IContainer(
      height: 440,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TopCard(
                    title: "Lat",
                    subTitle: widget.latLng.latitude.toStringAsFixed(2),
                    iconColor: Colors.green,
                  ),
                ),
                Expanded(
                  child: TopCard(
                    title: "Long",
                    subTitle: widget.latLng.longitude.toStringAsFixed(2),
                    iconColor: Colors.redAccent,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 50,
            ),
            IText(
              text: widget.speed.toStringAsFixed(0),
              fontSize: 40,
              bold: true,
              color: Colors.blue[900],
            ),
            IText(
              text: "kmph",
              fontSize: 14,
              color: Colors.grey[500],
            ),
            Slider(
              value: widget.speed,
              divisions: 20,
              min: 0,
              max: 100,
              activeColor: Colors.blue[900],
              inactiveColor: Colors.blueGrey[100],
              onChanged: (value) {
                setState(() => widget.speed = value);
              },
            ),
            Container(
                width: Get.width,
                margin: EdgeInsets.all(20),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                          icon: Icon(
                            Icons.close,
                            color: Colors.red[900],
                          ),
                          onPressed: () {
                            Get.back();
                          },
                          label: IText(
                            text: "Close",
                            fontSize: 16,
                            color: Colors.red[900],
                          )),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      child: OutlinedButton.icon(
                          icon: Icon(
                            Icons.location_on_outlined,
                            color: Colors.blue[900],
                          ),
                          onPressed: () async {
                            await Get.find<AdminController>().addMarkerToMap(
                                widget.latLng,
                                widget.speed.toDouble().toInt(),
                                widget.id);
                            Get.back();
                          },
                          label: IText(
                            text: "ADD",
                            fontSize: 16,
                            color: Colors.blue[900],
                          )),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

class TopCard extends StatelessWidget {
  final String title, subTitle;
  final Color iconColor;
  TopCard({this.title, this.subTitle, this.iconColor});
  @override
  Widget build(BuildContext context) {
    return IContainer(
      height: Get.width * 0.4,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      radius: BorderRadius.circular(20),
      elevation: 5,
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.location_on,
            size: 30,
            color: iconColor,
          ),
          IText(
            text: title,
            fontSize: 15,
          ),
          IText(
            text: subTitle,
            fontSize: 20,
            bold: true,
          )
        ],
      ),
    );
  }
}
