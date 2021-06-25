import 'package:flutter/material.dart';
import 'package:speed_controller/iframework/container.dart';
import 'package:speed_controller/iframework/text_widget.dart';

class RecordsCard extends StatefulWidget {
  @override
  _RecordsCardState createState() => _RecordsCardState();
}

class _RecordsCardState extends State<RecordsCard> {
  String selected = "Pending";
  @override
  Widget build(BuildContext context) {
    return IContainer(
        margin: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        padding: EdgeInsets.all(10),
        radius: BorderRadius.circular(20),
        elevation: 5,
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: ['Pending', 'Paid']
                  .map((e) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Column(
                          children: [
                            IContainer(
                              onTap: () {
                                setState(() => selected = e);
                              },
                              padding: EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 10),
                              radius: BorderRadius.circular(30),
                              color: e == selected
                                  ? Colors.blue[900]
                                  : Colors.white,
                              child: IText(
                                text: e,
                                fontSize: 16,
                                color: e == selected
                                    ? Colors.white
                                    : Colors.blue[900],
                              ),
                            ),
                          ],
                        ),
                      ))
                  .toList(),
            ),
            SizedBox(height: 15),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.blue[900],
                  ),
                  borderRadius: BorderRadius.circular(15)),
              child: ListView.separated(
                itemCount: 3,
                shrinkWrap: true,
                separatorBuilder: (context, index) => Divider(
                  thickness: 1,
                ),
                itemBuilder: (context, index) => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IText(
                      text: "28th Jun",
                      fontSize: 16,
                    ),
                    SizedBox(width: 20),
                    IText(
                      text: "Maddilapalem",
                      fontSize: 16,
                    ),
                    SizedBox(width: 20),
                    IText(
                      text: "80 kmph",
                      fontSize: 16,
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.chevron_right_rounded,
                          color: Colors.grey[500],
                        ))
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
