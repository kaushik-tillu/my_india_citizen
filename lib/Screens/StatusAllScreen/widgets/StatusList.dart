import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:my_india_citizen/Screens/StatusAllScreen/services/DatabaseStatus.dart';
import 'package:my_india_citizen/constants.dart';

class StatusList extends StatefulWidget {
  @override
  _StatusListState createState() => _StatusListState();
}

class _StatusListState extends State<StatusList> {
  CollectionReference work = FirebaseFirestore.instance.collection('Reports');

  @override
  void initState() {
    getStatusList().then((res) {
      setState(() {
        querySnapshot = res;
      });
    });
    super.initState();
  }

  QuerySnapshot querySnapshot;
  @override
  Widget build(BuildContext context) {
    if (querySnapshot != null) {
      return ListView.builder(
        primary: false,
        itemCount: querySnapshot.docs.length,
        padding: EdgeInsets.all(12),
        itemBuilder: (context, i) {
          String lat = querySnapshot.docs[i]
              .data()['position']['geopoint']
              .latitude
              .toString();
          String lon = querySnapshot.docs[i]
              .data()['position']['geopoint']
              .longitude
              .toString();
          String downloadurl = querySnapshot.docs[i].data()['imageurl'];
          return Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0),
            child: Column(
              children: <Widget>[
                SingleChildScrollView(
                  child: ExpansionTileCard(
                    baseColor: Colors.white,
                    leading: Builder(builder: (context) {
                      if (querySnapshot.docs[i].data()['work'] == false) {
                        return CircleAvatar(
                            backgroundColor: Colors.red, radius: 20);
                      } else {
                        return CircleAvatar(
                            backgroundColor: Colors.greenAccent, radius: 20);
                      }
                    }),
                    title: Text(
                        "Type: ${querySnapshot.docs[i].data()['complaintype']}"),
                    subtitle: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Text("${querySnapshot.docs[i].data()['department']}"),
                      ],
                    ),
                    children: <Widget>[
                      Divider(
                        thickness: 1.0,
                        height: 1.0,
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 8.0,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "Username: ${querySnapshot.docs[i].data()['username']}"),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                    "Comment: ${querySnapshot.docs[i].data()['comment']}"),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                    "Address: ${querySnapshot.docs[i].data()['address']}"),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                    "Landmark: ${querySnapshot.docs[i].data()['landmark']}"),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                    "Email ID: ${querySnapshot.docs[i].data()['email']}"),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                    "Date: ${querySnapshot.docs[i].data()['dateTime']}"),
                                SizedBox(
                                  height: 5.0,
                                ),
                              ],
                            )),
                      ),
                      ButtonBar(
                        alignment: MainAxisAlignment.spaceAround,
                        buttonHeight: 52.0,
                        buttonMinWidth: 90.0,
                        children: <Widget>[
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0)),
                            onPressed: () {
                              navigateme(lat, lon);
                            },
                            child: Column(
                              children: <Widget>[
                                Icon(Icons.navigate_before),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Text('Navigate me'),
                              ],
                            ),
                          ),
                          FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(4.0)),
                            onPressed: () {
                              seepothole(downloadurl);
                            },
                            child: Column(
                              children: <Widget>[
                                Icon(
                                  Icons.image_rounded,
                                  color: Colors.red[500],
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2.0),
                                ),
                                Text(
                                  'See Pothole',
                                  style: TextStyle(color: Colors.red[500]),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      );
    } else {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitCubeGrid(
              color: Color(kPrimaryColor),
              size: 80.0,
            ),
            SizedBox(height: 20.0),
            Text(
              'Loading...',
              style: TextStyle(color: Color(kPrimaryColor)),
            ),
          ],
        ),
      );
    }
  }
}
