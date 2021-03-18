import 'package:flutter/material.dart';
import 'package:my_india_citizen/Screens/Authentication/Auth.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(new Authentication());
}
