import 'package:flutter/material.dart';

class IText extends StatelessWidget {
  Color color;
  FontWeight fontWeight;
  String fontFamily;
  double fontSize;
  String text;
  bool bold;
  Function onTap;
  TextAlign textAlign;
  int maxLines;
  IText({
    this.color,
    this.fontFamily,
    this.fontSize,
    this.fontWeight,
    this.maxLines,
    this.textAlign,
    this.text,
    this.bold,
    this.onTap,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        maxLines: maxLines,
        textAlign: textAlign,
        style: TextStyle(
            color: color,
            fontWeight: bold != null ? FontWeight.bold : FontWeight.normal,
            fontSize: fontSize,
            fontFamily: fontFamily),
      ),
    );
  }
}
