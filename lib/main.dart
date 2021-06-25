import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speed_controller/admin/adminController.dart';
import 'package:speed_controller/admin/appController.dart';
import 'package:speed_controller/auth/login.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Get.lazyPut(() => AppController());
  Get.lazyPut(() => AdminController());
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Lato", primaryColor: Colors.blue[900]),
      home: Login(),
      // home: CreateUser(),
    );
  }
}
