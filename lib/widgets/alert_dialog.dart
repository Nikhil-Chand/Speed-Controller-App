import 'package:flutter/material.dart';
import 'package:get/get.dart';

class KMAlertDialog extends StatefulWidget {
  final String title, successText, failureText;
  Function onSuccessTap, onFailureTap;
  KMAlertDialog({
    this.title,
    this.successText,
    this.failureText,
    this.onSuccessTap,
    this.onFailureTap,
  });
  @override
  _KMAlertDialogState createState() => _KMAlertDialogState();
}

class _KMAlertDialogState extends State<KMAlertDialog> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(10)),
        padding: EdgeInsets.all(20),
        height: 120,
        width: Get.width * 0.8,
        child: Column(
          children: [
            Text(widget.title),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                GestureDetector(
                  onTap: widget.onFailureTap,
                  child: Text(widget.failureText,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.red[900])),
                ),
                SizedBox(
                  width: 50,
                ),
                GestureDetector(
                  onTap: widget.onSuccessTap,
                  child: Text(widget.successText,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green[900])),
                ),
                SizedBox(
                  width: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
