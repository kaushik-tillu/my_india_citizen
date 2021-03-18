import 'package:flutter/material.dart';

import '../../../size_Config.dart';

class RoundedButton extends StatelessWidget {
  final Color colour;
  final String title;
  final Function onPressed;
  final double height;
  final double width;

  RoundedButton({
    @required this.onPressed,
    @required this.colour,
    @required this.title,
    @required this.height,
    @required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: MaterialButton(
          onPressed: onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30.0),
          ),
          elevation: 3.0,
          color: colour,
          minWidth: width,
          height: height,
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontSize: SizeConfig.blockSizeHorizontal*4.5,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w500,
              letterSpacing: 1.2
            ),
          ),
        ),
    );
  }
}
