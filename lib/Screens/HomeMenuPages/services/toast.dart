import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:my_india_citizen/constants.dart';

void toastMessage(String message) {
  Fluttertoast.showToast(
    msg: message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.TOP,
    fontSize: 16.0,
    textColor: Colors.white,
    backgroundColor: Color(kPrimaryColor),
  );
}
