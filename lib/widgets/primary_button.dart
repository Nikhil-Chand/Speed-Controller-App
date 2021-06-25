import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class PrimaryButton extends StatelessWidget {
  final Function onTap;
  final String label;
  final Widget child;
  final bool isOutline;
  final int buttonHeight;

  const PrimaryButton(
      {Key key,
      this.onTap,
      this.label,
      this.isOutline = false,
      this.buttonHeight = 60,
      this.child})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    print("ONtap" + onTap.toString());

    void executeOnTap() {
      if (onTap != null) {
        try {
          HapticFeedback.mediumImpact();
          return onTap();
        } catch (e) {
          print(e);
        }
      }
    }

    return isOutline
        ? Container(
            width: double.infinity,
            height: buttonHeight.toDouble(),
            child: OutlineButton(
              highlightedBorderColor: Colors.blue[900],
              // hoverColor: COLOR_BRAND_LIGHT_GREEN,
              // splashColor: COLOR_BRAND_LIGHT_GREEN,
              borderSide: BorderSide(
                  color: Colors.blue[900],
                  style: BorderStyle.solid,
                  width: 1.5),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              onPressed: () => executeOnTap(),
              child: child ??
                  Text(
                    label,
                    style: TextStyle(
                        fontSize: 18.667,
                        color: Colors.blue[900],
                        fontWeight: FontWeight.w900),
                  ),
            ),
          )
        : Container(
            width: double.infinity,
            height: buttonHeight.toDouble(),
            child: FlatButton(
              disabledColor: Colors.grey.withOpacity(0.5),
              // hoverColor: COLOR_BRAND_LIGHT_GREEN,
              // splashColor: COLOR_BRAND_LIGHT_GREEN,
              color: Colors.blue[900],

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),

              onPressed: onTap != null ? () => executeOnTap() : null,
              child: Center(
                child: FittedBox(
                  child: child ??
                      Text(
                        label,
                        style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.w700),
                      ),
                ),
              ),
            ),
          );
  }
}
