import 'package:flutter/material.dart';

class KRadioGroup extends StatelessWidget {
  String labelText;
  List<String> list;
  int id;
  Function onChanged;
  KRadioGroup({this.labelText, this.id, this.list, this.onChanged});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          labelText,
          style: TextStyle(
              color: Colors.green, fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Container(
            height: 60,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (context, index) => Row(
                children: [
                  Transform.scale(
                    scale: 1.2,
                    child: Radio(
                      value: index,
                      groupValue: id,
                      splashRadius: 50,
                      visualDensity: VisualDensity.adaptivePlatformDensity,
                      fillColor: MaterialStateProperty.all(Colors.green),
                      onChanged: onChanged,
                    ),
                  ),
                  Text(list[index])
                ],
              ),
            )),
      ],
    );
  }
}
