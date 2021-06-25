import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speed_controller/iframework/text_form_field.dart';
import 'package:speed_controller/iframework/text_widget.dart';

class CreateUser extends StatefulWidget {
  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var phoneController = TextEditingController();
  var vehicleNumberController = TextEditingController();
  var vehicleOwnerController = TextEditingController();
  var vehicleRegisteredController = TextEditingController();
  var formKey = GlobalKey<FormState>();
  DateTime registeredOn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Register New User"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                ITextField(
                  labelText: "Name",
                  controller: nameController,
                ),
                ITextField(
                  labelText: "Email",
                  controller: emailController,
                ),
                ITextField(
                  labelText: "Phone Number",
                  controller: phoneController,
                ),
                ITextField(
                  labelText: "Vehicle Number",
                  controller: vehicleNumberController,
                ),
                ITextField(
                  labelText: "Vehicle Owner Name",
                  controller: vehicleOwnerController,
                ),
                GestureDetector(
                  onTap: () {
                    showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime.now())
                        .then((value) {
                      vehicleRegisteredController.text = value.day.toString() +
                          "/" +
                          value.month.toString() +
                          "/" +
                          value.year.toString();
                      registeredOn = value;
                    });
                  },
                  child: ITextField(
                    labelText: "Vehicle Registered On",
                    controller: vehicleRegisteredController,
                    enabled: false,
                    suffixIcon: Icon(Icons.calendar_today),
                  ),
                ),
                ElevatedButton(
                    onPressed: () async {
                      if (formKey.currentState.validate()) {
                        await FirebaseFirestore.instance
                            .collection("Users")
                            .doc(phoneController.text)
                            .set({
                          "personal": {
                            "email": emailController.text,
                            "name": nameController.text,
                            "phoneNumber": phoneController.text,
                            "registeredOn": FieldValue.serverTimestamp(),
                          },
                          "vehicle": {
                            "number": vehicleNumberController.text,
                            "ownerName": vehicleOwnerController.text,
                            "registeredOn": registeredOn
                          }
                        });
                        Get.back();
                      } else
                        return;
                    },
                    child: IText(
                      text: "Register User",
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
