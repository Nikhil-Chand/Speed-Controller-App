import 'package:flutter/material.dart';
import 'package:speed_controller/iframework/text_widget.dart';

class TopCardTile extends StatelessWidget {
  final icon, title;
  TopCardTile({this.icon, this.title});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            icon,
            size: 25,
          ),
          SizedBox(
            width: 10,
          ),
          Flexible(
            child: IText(
              text: title,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }
}
