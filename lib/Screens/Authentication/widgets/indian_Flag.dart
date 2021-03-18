/// ************ Indian Flag ************///

import 'package:flutter/material.dart';
import '../../../constants.dart';
import '../../../size_Config.dart';
import 'logo_Name_On_Splash_Screen.dart';

class IndianFlag extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              LogoName(
                text: 'Made In India',
                color: Color(kSecondaryColor),
                fontSize: SizeConfig.blockSizeHorizontal*4,
                letterSpace: 2.1,
              ),
              SizedBox(
                width: SizeConfig.safeBlockHorizontal*6,
              ),
              Image.asset(
                'assets/Others/IndianFlag.jpeg',
                height: SizeConfig.blockSizeVertical*2.5,
                width: SizeConfig.blockSizeHorizontal*7,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
