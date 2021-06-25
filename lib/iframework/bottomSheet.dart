import 'package:flutter/material.dart';

Future showIBottomSheet(
  BuildContext context,
  Widget child,
) {
  return showModalBottomSheet(
      backgroundColor: Colors.white,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
      ),
      context: context,
      builder: (context) => StatefulBuilder(
            builder: (context, setState) => ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30),
                topRight: Radius.circular(30),
              ),
              child: child,
            ),
          ));
}
