import 'package:flutter/material.dart';

class IContainer extends StatelessWidget {
  double height, width;
  Color color;
  double elevation;
  Alignment alignment;
  BorderRadiusGeometry radius;
  BoxShadow boxShadow;
  Widget child;
  EdgeInsets padding;
  EdgeInsets margin;
  Gradient gradient;
  BoxShape shape;
  Function onTap;

  IContainer(
      {this.color,
      this.alignment,
      this.child,
      this.onTap,
      this.elevation,
      this.shape,
      this.height,
      this.radius,
      this.margin,
      this.padding,
      this.gradient,
      this.boxShadow,
      this.width})
      : assert(margin == null || margin.isNonNegative),
        assert(padding == null || padding.isNonNegative),
        assert(boxShadow == null || elevation == null,
            "You cant use both elevation and boxShadow at the same time");
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: height,
        width: width,
        margin: margin,
        padding: padding,
        alignment: alignment,
        decoration: BoxDecoration(
            color: color,
            borderRadius: radius,
            boxShadow: [
              elevation == null
                  ? boxShadow ?? BoxShadow(color: Colors.white)
                  : BoxShadow(
                      color: Colors.grey[300],
                      blurRadius: elevation,
                      spreadRadius: 0,
                      offset: Offset(3, 3)),
            ],
            gradient: gradient,
            shape: shape ?? BoxShape.rectangle),
        child: child,
      ),
    );
  }
}
