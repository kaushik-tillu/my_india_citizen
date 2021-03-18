import 'package:flutter/material.dart';
import 'package:my_india_citizen/Screens/HomeMenuPages/views/ComplaintForm.dart';
import 'package:my_india_citizen/Screens/StatusAllScreen/views/StatusScreen.dart';
import 'package:my_india_citizen/constants.dart';

class Cards extends StatefulWidget {
  @override
  _CardsState createState() => _CardsState();
}

class _CardsState extends State<Cards> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ComplaintForm()),
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
                          text: "Report New Complaint",
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 17.0),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 5),
                    child: Image.asset('assets/HomePage/Report.png'),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 20),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StatusScreen()),
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
                    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    child: Image.asset('assets/HomePage/Status.png'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
//Navigator.of(context).pushReplacementNamed('/GuideScreen');
