import 'package:flutter/material.dart';
import 'package:my_india_citizen/constants.dart';
import '../widgets/cards.dart';

class ComplaintPage extends StatefulWidget {
  @override
  _ComplaintPageState createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text(
            "Register Complaint",
            style: TextStyle(color: Color(kPrimaryColor), fontSize: 24),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Container(
                height: 300,
                child: Image.asset('assets/HomePage/Home.png'),
              ),
            ),
            Expanded(
              child: Cards(),
            )
          ],
        ),
        // body: Cards(),
      ),
    );
  }
}
