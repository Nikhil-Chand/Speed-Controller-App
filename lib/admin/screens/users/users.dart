import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speed_controller/admin/adminNavBar.dart';
import 'package:speed_controller/admin/screens/users/registerUser.dart';
import 'package:speed_controller/iframework/text_widget.dart';
import 'package:speed_controller/widgets/loadingIndicator.dart';

class Users extends StatefulWidget {
  @override
  _UsersState createState() => _UsersState();
}

class _UsersState extends State<Users> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Users"),
        actions: [
          OutlinedButton(
              onPressed: () {
                Get.to(CreateUser());
              },
              child: IText(
                text: "Create New User",
                color: Colors.white,
              ))
        ],
      ),
      drawer: AdminNavigationDrawer(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return LoadingIndicator();
          print(snapshot.data.docs[0]);
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index) => ListTile(
              leading: Icon(
                Icons.account_circle_outlined,
                size: 50,
              ),
              title: Text(snapshot.data.docs[index]['personal']['name']),
              subtitle:
                  Text(snapshot.data.docs[index]['personal']['phoneNumber']),
            ),
          );
        },
      ),
    );
  }
}
