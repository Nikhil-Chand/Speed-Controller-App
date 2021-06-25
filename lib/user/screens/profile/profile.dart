import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:speed_controller/iframework/container.dart';
import 'package:speed_controller/iframework/text_widget.dart';
import 'package:speed_controller/user/screens/navigation_drawer.dart';
import 'package:speed_controller/widgets/loadingIndicator.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawer(),
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: IText(
          text: "Profile",
          color: Colors.black,
        ),
        iconTheme: IconThemeData(color: Colors.black),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: FutureBuilder(
            future: FirebaseFirestore.instance
                .collection("Users")
                .doc("user1")
                .get(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return LoadingIndicator();
              print(snapshot.data);
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20),
                  ProfileCard(
                    cardTitle: "Personal Information",
                    items: [
                      VehicleInfoTile(
                        title: "Name",
                        subTitle: snapshot.data['personal']['name'],
                      ),
                      VehicleInfoTile(
                        title: "Phone Number",
                        subTitle: snapshot.data['personal']['phoneNumber'],
                      ),
                      VehicleInfoTile(
                        title: "Registered on",
                        subTitle: DateFormat("dd-MM-yyyy").format(
                          snapshot.data['personal']['registeredOn'].toDate(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  ProfileCard(
                    cardTitle: "Vehicle Information",
                    items: [
                      VehicleInfoTile(
                        title: "Vehicle Number",
                        subTitle: snapshot.data['vehicle']['number'],
                      ),
                      VehicleInfoTile(
                        title: "Owner Name",
                        subTitle: snapshot.data['vehicle']['ownerName'],
                      ),
                      VehicleInfoTile(
                        title: "Registered on",
                        subTitle: DateFormat("dd-MM-yyyy").format(
                          snapshot.data['vehicle']['registeredOn'].toDate(),
                        ),
                      ),
                    ],
                  ),
                ],
              );
            }),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  final doc;
  final String cardTitle;
  final List<Widget> items;

  ProfileCard({Key key, this.doc, this.cardTitle, this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IText(
          text: cardTitle,
          fontSize: 20,
          bold: true,
        ),
        SizedBox(height: 20),
        IContainer(
          width: Get.width,
          radius: BorderRadius.circular(15),
          padding: EdgeInsets.all(10),
          color: Colors.white,
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: items,
          ),
        ),
      ],
    );
  }
}

class VehicleInfoTile extends StatelessWidget {
  final String title, subTitle;
  VehicleInfoTile({this.title, this.subTitle});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IText(
            text: title + " :",
            fontSize: 18,
            bold: true,
          ),
          IText(
            text: subTitle,
            fontSize: 18,
          ),
        ],
      ),
    );
  }
}
