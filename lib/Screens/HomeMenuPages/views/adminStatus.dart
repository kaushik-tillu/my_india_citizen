import 'package:flutter/material.dart';
import 'package:my_india_citizen/Screens/HomeMenuPages/views/adminStatusList.dart';
import 'package:my_india_citizen/constants.dart';

class AdminStatus extends StatefulWidget {
  @override
  _AdminStatusState createState() => _AdminStatusState();
}

class _AdminStatusState extends State<AdminStatus> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          color: Color(kPrimaryColor),
        ),
        title: Text(
          "All Submited Complaints",
          style: TextStyle(color: Color(kPrimaryColor), fontSize: 24),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: AdminStatusList(),
    );
  }
}
