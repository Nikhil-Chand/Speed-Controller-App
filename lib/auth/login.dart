import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speed_controller/admin/screens/dashboard/adminDashboard.dart';
import 'package:speed_controller/iframework/container.dart';
import 'package:speed_controller/iframework/text_form_field.dart';
import 'package:speed_controller/iframework/text_widget.dart';
import 'package:speed_controller/user/screens/home/home.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      User user = FirebaseAuth.instance.currentUser;
      if (FirebaseAuth.instance.currentUser != null) {
        if (user.email == "admin@gmail.com")
          return Get.offAll(AdminDashboard());
        else
          return Get.offAll(Home());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IContainer(
          height: Get.height * 0.8,
          width: Get.width * 0.8,
          radius: BorderRadius.circular(10),
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Icon(
                Icons.lock_outline_rounded,
                size: 120,
                color: Colors.blue,
              ),
              Column(
                children: [
                  ITextField(
                    labelText: "Email",
                    controller: emailController,
                  ),
                  ITextField(
                    labelText: "Password",
                    controller: passwordController,
                    obscureText: !showPassword,
                    suffixIcon: IconButton(
                      icon: Icon(Icons.remove_red_eye),
                      onPressed: () {
                        setState(() => showPassword = !showPassword);
                      },
                    ),
                  ),
                  Container(
                    width: Get.width * 0.8,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (emailController.text == "admin@gmail.com") {
                          await FirebaseAuth.instance
                              .signInWithEmailAndPassword(
                                  email: emailController.text,
                                  password: passwordController.text);
                          return Get.offAll(AdminDashboard());
                        }
                        var users = (await FirebaseFirestore.instance
                                .collection("Users")
                                .where("personal.email",
                                    isEqualTo: emailController.text)
                                .get())
                            .docs;
                        if (users.length == 0)
                          return print("No User Exist");
                        else
                          print("Users exist");
                        await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text);
                        Get.offAll(Home());
                      },
                      child: IText(
                        text: "Login",
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
