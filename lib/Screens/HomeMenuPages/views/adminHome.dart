import 'package:flutter/material.dart';
import 'package:my_india_citizen/Screens/Authentication/services/auth_service.dart';
import 'package:my_india_citizen/Screens/Authentication/widgets/providerWidget.dart';
import 'package:my_india_citizen/Screens/Authentication/widgets/rounded_Button.dart';
import 'package:my_india_citizen/Screens/HomeMenuPages/views/adminStatus.dart';
import 'package:my_india_citizen/Screens/HomeMenuPages/views/adminStatusList.dart';
import 'package:my_india_citizen/constants.dart';
import 'package:my_india_citizen/size_Config.dart';

class AdminHome extends StatefulWidget {
  @override
  _AdminHomeState createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Color(kPrimaryColor),
        automaticallyImplyLeading: false,
        title: Center(
          child: Text(
            'My India Admin',
            style: TextStyle(fontSize: 21),
          ),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.blockSizeHorizontal * 12,
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AdminStatus()),
                );
              },
              child: Container(
                height: 120,
                child: Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Container(
                      padding: EdgeInsets.only(left: 160),
                      height: 120,
                      width: 350,
                      decoration: BoxDecoration(
                        color: Color(kSecondaryColor),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: RichText(
                          text: TextSpan(
                            text: "Status of all reports",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Image.asset('assets/HomePage/Status.png'),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 500.0),
              child: RoundedButton(
                  onPressed: () async {
                    try {
                      AuthService auth = Provider.of(context).auth;
                      await auth.signOut();
                    } catch (e) {
                      print(e);
                    }
                    Navigator.pop(context);
                  },
                  colour: Color(kLogoutColor),
                  title: 'Logout',
                  height: SizeConfig.blockSizeVertical * 6,
                  width: SizeConfig.blockSizeHorizontal * 80),
            )
          ],
        ),
      ),
    );
  }
}
