/// ************ Logo Name: My India on Splash Screen ************///

import 'package:flutter/material.dart';

/// ************ Lora FontFamily ************///
class LogoName extends StatelessWidget {
  final String text;
  final Color color;
  final double fontSize;
  final double letterSpace;

  LogoName(
      {@required this.text, @required this.color, @required this.fontSize, this.letterSpace});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        color: color,
        fontWeight: FontWeight.bold,
        fontFamily: "Lora",
        fontSize: fontSize,
        letterSpacing: letterSpace,
      ),
    );
  }
}
