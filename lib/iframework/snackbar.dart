import 'package:flutter/material.dart';
import 'package:get/get.dart';

showLoginErrorSnackBar(
    {BuildContext ctx,
    String title = '',
    String message = '',
    bool center = false}) {
  if (!Get.isSnackbarOpen) {
    Get.snackbar('', '',
        margin: EdgeInsets.only(bottom: 10, left: 15, right: 15),
        snackStyle: SnackStyle.FLOATING,
        icon: Container(
          padding: EdgeInsets.all(0),
          decoration:
              BoxDecoration(color: Colors.white, shape: BoxShape.circle),
          height: 30,
          width: 30,
          child: Icon(Icons.error),
        ),
        backgroundColor: Colors.red,
        borderRadius: 10,
        messageText: Text(
          message,
          style: center
              ? TextStyle(
                  fontSize: 0,
                  height: 0,
                )
              : TextStyle(color: Colors.white),
        ),
        titleText: Padding(
          padding: center
              ? const EdgeInsets.only(top: 5.0)
              : const EdgeInsets.only(top: 0.0),
          child: Text(
            title,
            style: TextStyle(color: Colors.white),
          ),
        ),
        snackPosition: SnackPosition.BOTTOM);
  }
}
