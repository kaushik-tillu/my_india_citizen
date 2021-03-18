import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:my_india_citizen/Screens/Authentication/widgets/rounded_Button.dart';
import 'package:my_india_citizen/constants.dart';
import 'package:my_india_citizen/size_Config.dart';

class AdminAuth extends StatefulWidget {
  @override
  _AdminAuthState createState() => _AdminAuthState();
}

class _AdminAuthState extends State<AdminAuth> {
  String email, password;
  var _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(
              height: SizeConfig.blockSizeHorizontal * 30,
            ),
            Center(
              child: Text(
                'Admin Account',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w500,
                    color: Color(kPrimaryColor),
                    letterSpacing: 3.0),
              ),
            ),
            SizedBox(
              height: SizeConfig.blockSizeHorizontal * 21,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              decoration:
                  kTextFieldDecoration.copyWith(labelText: 'Admin Email'),
              onChanged: (value) {
                email = value;
              },
            ),
            SizedBox(
              height: SizeConfig.blockSizeHorizontal * 6,
            ),
            TextField(
              keyboardType: TextInputType.emailAddress,
              obscureText: true,
              decoration: kTextFieldDecoration.copyWith(
                labelText: 'Password',
              ),
              onChanged: (value) {
                password = value;
              },
            ),
            SizedBox(
              height: SizeConfig.blockSizeHorizontal * 6,
            ),
            RoundedButton(
                onPressed: () async {
                  try {
                    final user = await _auth.signInWithEmailAndPassword(
                        email: email, password: password);
                    if (user != null) {
                      Navigator.of(context).pushNamed('/adminHome');
                    }
                  } catch (e) {
                    print(e);
                  }
                },
                colour: Color(kSecondaryColor),
                title: 'Sign In',
                height: SizeConfig.blockSizeVertical * 6,
                width: SizeConfig.blockSizeHorizontal * 60)
          ],
        ),
      ),
    );
  }
}
