import 'package:flutter/material.dart';

const kPrimaryColor = 0xFF1C58C9;
const kSecondaryColor = 0xFF263238;
const kLogoutColor = 0xFFd32f2f;

const kTextFieldDecoration = InputDecoration(
  contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
  border: OutlineInputBorder(
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  enabledBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(kPrimaryColor), width: 1.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
  focusedBorder: OutlineInputBorder(
    borderSide: BorderSide(color: Color(kPrimaryColor), width: 2.0),
    borderRadius: BorderRadius.all(Radius.circular(32.0)),
  ),
);
