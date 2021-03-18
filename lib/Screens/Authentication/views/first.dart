import 'package:flutter/material.dart';
import 'package:my_india_citizen/Screens/Authentication/widgets/indian_Flag.dart';
import 'package:my_india_citizen/Screens/Authentication/widgets/logo_Name_On_Splash_Screen.dart';
import 'package:my_india_citizen/Screens/Authentication/widgets/rounded_Button.dart';
import 'package:my_india_citizen/constants.dart';
import '../../../size_Config.dart';
import '../widgets/customDialog.dart';

class First extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            children: <Widget>[
              Flexible(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    LogoName(
                      text: 'My',
                      color: Color(kPrimaryColor),
                      fontSize: SizeConfig.blockSizeHorizontal * 13,
                    ),
                    LogoName(
                      text: 'India',
                      color: Color(kPrimaryColor),
                      fontSize: SizeConfig.blockSizeHorizontal * 13,
                    ),
                    Divider(
                      color: Color(kPrimaryColor),
                      indent: 100,
                      endIndent: 100,
                      thickness: 0.5,
                    ),
                    LogoName(
                      text: 'Smart India',
                      color: Color(kSecondaryColor),
                      fontSize: SizeConfig.blockSizeHorizontal * 5,
                      letterSpace: 6.0,
                    ),
                  ],
                ),
              ),
              Flexible(
                child: Column(
                  children: <Widget>[
                    RoundedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) => CustomDialog(
                            title: "Would you like to create a free account?",
                            description:
                                "With an account, your scouting will be rewarded and allow you to access from multiple devices.",
                            primaryButtonText: "Create My Account",
                            primaryButtonRoute: "/citizenSignup",
                            secondaryButtonText: "Maybe Later",
                            secondaryButtonRoute: "/anonymousSignIn",
                          ),
                        );
                      },
                      height: SizeConfig.blockSizeVertical * 6,
                      width: SizeConfig.blockSizeHorizontal * 80,
                      colour: Color(kPrimaryColor),
                      title: "Citizens Authentication",
                    ),

                    SizedBox(height: SizeConfig.blockSizeVertical * 1),
                    SizedBox(height: SizeConfig.blockSizeVertical * 0),
                    RoundedButton(
                      height: SizeConfig.blockSizeVertical * 6,
                      width: SizeConfig.blockSizeHorizontal * 80,
                      colour: Color(kSecondaryColor),
                      title: "Municipal Authentication",
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed('/adminAuth');
                      },
                    ),

                    /// ********** Indian Flag ************///
                    IndianFlag(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
