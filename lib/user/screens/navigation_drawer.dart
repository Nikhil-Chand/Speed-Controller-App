import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speed_controller/iframework/text_widget.dart';
import 'package:speed_controller/user/screens/files/files.dart';
import 'package:speed_controller/user/screens/home/home.dart';
import 'package:speed_controller/user/screens/profile/profile.dart';

List drawerList = [
  {"name": "Home", "icon": Icons.home_rounded, "page": Home()},
  {
    "name": "Profile",
    "icon": Icons.supervised_user_circle_outlined,
    "page": Profile()
  },
  {"name": "Fines", "icon": Icons.file_copy_sharp, "page": Files()},
  {"name": "Log Out", "icon": Icons.power_settings_new}
];

class NavigationDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            SizedBox(height: 60),
            Row(
              children: [
                ClipRRect(
                  child: Icon(
                    Icons.account_circle_outlined,
                    size: 50,
                  ),
                ),
                SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IText(
                      text: FirebaseAuth.instance.currentUser.phoneNumber,
                      fontSize: 18,
                      bold: true,
                    ),
                    IText(
                      text: "AP21Z 2514",
                      fontSize: 16,
                    )
                  ],
                ),
              ],
            ),
            SizedBox(height: 10),
            Divider(),
            ListView.separated(
              itemCount: drawerList.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) => Divider(
                height: 40,
              ),
              itemBuilder: (context, index) => GestureDetector(
                onTap: () {
                  Get.offAll(drawerList[index]['page']);
                },
                child: Row(
                  children: [
                    Icon(
                      drawerList[index]['icon'],
                      size: 30,
                    ),
                    SizedBox(width: 20),
                    IText(
                      text: drawerList[index]['name'],
                      fontSize: 18,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
