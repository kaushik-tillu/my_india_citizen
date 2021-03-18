import 'package:flutter/material.dart';
import 'package:my_india_citizen/constants.dart';
import '../../BottomNavBarPages/views/ComplaintPage.dart';
import '../../BottomNavBarPages/views/MapPage.dart';
import '../../BottomNavBarPages/views/AccountPage.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;

  final List<Widget> _children = [ComplaintPage(), MapPage(), AccountPage()];

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _children[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Color(kPrimaryColor),
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            activeIcon: new Tab(
              icon: new Image.asset(
                "assets/Navbar/Home.png",
                height: 32,
              ),
            ),
            icon: new Tab(
              icon: new Image.asset(
                "assets/Navbar/Home.png",
                height: 22,
              ),
            ),
            title: Text(
              'Home',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          ),
          BottomNavigationBarItem(
              activeIcon: new Tab(
                icon: new Image.asset(
                  "assets/Navbar/Maps.png",
                  height: 32,
                ),
              ),
              icon: new Tab(
                icon: new Image.asset(
                  "assets/Navbar/Maps.png",
                  height: 22,
                ),
              ),
              title: new Text(
                'Map',
                style: TextStyle(
                  color: Colors.white,
                ),
              )),
          BottomNavigationBarItem(
            activeIcon: new Tab(
              icon: new Image.asset(
                "assets/Navbar/Account.png",
                height: 32,
              ),
            ),
            icon: new Tab(
              icon: new Image.asset(
                "assets/Navbar/Account.png",
                height: 22,
              ),
            ),
            title: new Text(
              'Account',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
