import 'package:flutter/material.dart';

class TextFieldApp extends StatefulWidget {
  final IconData icon;
  final Color iconColor;
  final Color cursorColor;
  final IconData prefixIcon;
  final String hintText;
  final Color hintTextColor;
  final double fontSize;
  final FontWeight fontWeight;
  final TextEditingController controller;

  const TextFieldApp(this.icon, this.hintText, this.controller, this.iconColor,
      this.cursorColor, this.hintTextColor,
      {this.fontSize, this.fontWeight, this.prefixIcon});

  @override
  _TextFieldAppState createState() => _TextFieldAppState();
}

class _TextFieldAppState extends State<TextFieldApp> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(20, 0, 20, 40),
      child: TextField(
        controller: widget.controller,
        decoration: InputDecoration(
          prefixIcon: Icon(
            widget.prefixIcon,
            color: widget.iconColor,
          ),
          hintText: widget.hintText,
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        cursorColor: widget.cursorColor,
        style: TextStyle(
          color: widget.hintTextColor,
          fontSize: widget.fontSize,
          fontWeight: widget.fontWeight,
        ),
        autocorrect: false,
      ),
    );
  }
}
