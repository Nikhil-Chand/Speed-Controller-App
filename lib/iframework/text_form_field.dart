import 'package:flutter/material.dart';

class ITextField extends StatelessWidget {
  TextEditingController controller;
  String hintText, labelText;
  bool enabled;
  String errorText;
  TextInputType type;
  bool autofocus;
  Widget suffixIcon;
  int maxlines;
  bool obscureText;
  FocusNode focusNode;
  ITextField(
      {this.labelText,
      this.hintText = "",
      this.suffixIcon,
      this.obscureText = false,
      this.errorText = "This field is mandatory",
      this.type = TextInputType.text,
      @required this.controller,
      this.focusNode,
      this.maxlines = 1,
      this.autofocus = false,
      this.enabled = true});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        labelText == null
            ? Container()
            : Text(
                labelText,
                style: TextStyle(
                    color: Colors.blue[900],
                    fontSize: 16,
                    fontWeight: FontWeight.bold),
              ),
        Container(
          child: TextFormField(
            controller: controller,
            focusNode: focusNode,
            maxLines: maxlines,
            cursorColor: Colors.blue[900],
            enabled: enabled,
            autofocus: autofocus,
            validator: (value) {
              if (value.isEmpty)
                return errorText;
              else
                return null;
            },
            obscureText: obscureText,
            style: TextStyle(color: Colors.blue[900]),
            keyboardType: type,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: TextStyle(color: Colors.blue[900]),
              suffixIcon: suffixIcon,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue[900]),
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.blue[900]),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 30,
        ),
      ],
    );
  }
}
