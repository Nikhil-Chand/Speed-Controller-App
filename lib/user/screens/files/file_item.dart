import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speed_controller/iframework/container.dart';
import 'package:speed_controller/iframework/text_widget.dart';
import 'package:speed_controller/user/screens/dashboard/top_card_tile.dart';
import 'package:speed_controller/widgets/alert_dialog.dart';

class FileItem extends StatefulWidget {
  final String address, fineDate, amount, speed, btnText, id;
  FileItem(
      {this.address,
      this.amount,
      this.btnText,
      this.fineDate,
      this.speed,
      this.id});

  @override
  _FileItemState createState() => _FileItemState();
}

class _FileItemState extends State<FileItem> {
  payDue() async {
    if (widget.btnText == "Paid") return;
    showDialog(
      context: context,
      builder: (context) => KMAlertDialog(
        failureText: "Cancel",
        successText: "Pay Now",
        onFailureTap: () => Get.back(),
        onSuccessTap: () async {
          Get.back();
          await FirebaseFirestore.instance
              .collection("fines")
              .doc(widget.id)
              .update({"paid": true});
        },
        title:
            "Do you want to pay Due of ₹${widget.amount} filed on ${widget.fineDate}",
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IContainer(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      color: Colors.red[50],
      elevation: 2,
      radius: BorderRadius.circular(10),
      onTap: () => payDue(),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TopCardTile(icon: Icons.location_on, title: widget.address),
                TopCardTile(
                    icon: Icons.date_range_rounded, title: "28th June 2020"),
                TopCardTile(icon: Icons.payments, title: "${widget.amount}"),
              ],
            ),
          ),
          Container(
            height: 100,
            child: VerticalDivider(
              thickness: 2,
            ),
          ),
          Expanded(
              flex: 2,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IText(
                    text: widget.speed,
                    fontSize: 50,
                    color: Colors.red[900],
                  ),
                  IText(
                    text: "kmph",
                    fontSize: 14,
                    color: Colors.red[900],
                  ),
                  SizedBox(height: 10),
                  IContainer(
                    radius: BorderRadius.circular(20),
                    padding: EdgeInsets.symmetric(
                      horizontal: 5,
                      vertical: 5,
                    ),
                    margin: EdgeInsets.symmetric(horizontal: 10),
                    alignment: Alignment.center,
                    color: widget.btnText == "Pay"
                        ? Colors.yellow[900]
                        : Colors.green[900],
                    child: IText(
                      text: widget.btnText,
                      color: Colors.white,
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
