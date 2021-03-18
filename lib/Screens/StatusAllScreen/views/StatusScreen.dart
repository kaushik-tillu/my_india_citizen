import 'package:flutter/material.dart';
import 'package:my_india_citizen/Screens/StatusAllScreen/widgets/StatusList.dart';
import 'package:my_india_citizen/constants.dart';

class StatusScreen extends StatefulWidget {
  @override
  _StatusScreenState createState() => _StatusScreenState();
}

class _StatusScreenState extends State<StatusScreen> {
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
      body: StatusList(),
    );
  }
}
