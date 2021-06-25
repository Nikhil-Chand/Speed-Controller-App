import 'package:flutter/material.dart';

class IButton extends StatelessWidget {
  String type;
  Color color;
  Widget child;
  IButton({
    this.type,
    this.color,
    this.child,
  });
  @override
  Widget build(BuildContext context) {
    switch (type) {
      case "raised":
        return ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(),
          child: Text("Button"),
        );
    }
  }
}
