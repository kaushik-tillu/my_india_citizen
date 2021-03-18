import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:my_india_citizen/Screens/Authentication/widgets/rounded_Button.dart';
import 'package:my_india_citizen/constants.dart';

import '../services/auth_service.dart';
import '../widgets/providerWidget.dart';

enum AuthFormType { signin, signup, reset }

class Signup extends StatefulWidget {
  final AuthFormType authFormType;

  Signup({Key key, @required this.authFormType}) : super(key: key);

  @override
  _SignupState createState() => _SignupState(authFormType: this.authFormType);
}

class _SignupState extends State<Signup> {
  AuthFormType authFormType;
  _SignupState({this.authFormType});
  final formKey = GlobalKey<FormState>();
  String _email;
  String _password;
  String _name;
  String _error;

  void switchFormState(String state) {
    formKey.currentState.reset();
    if (state == "signup") {
      setState(() {
        authFormType = AuthFormType.signup;
      });
    } else {
      setState(() {
        authFormType = AuthFormType.signin;
      });
    }
  }

  bool validate() {
    final form = formKey.currentState;
    form.save();
    if (form.validate()) {
      form.save();
      return true;
    } else {
      return false;
    }
  }

  void submit() async {
    if (validate()) {
      try {
        final auth = Provider.of(context).auth;
        if (authFormType == AuthFormType.signin) {
          String uid = await auth.signInWithEmailAndPassword(_email, _password);
          print("Signed in with ID $uid");
        } else if (authFormType == AuthFormType.reset) {
          await auth.sendPasswordResetEmail(_email);
          setState(() {
            authFormType = AuthFormType.signin;
          });
        } else {
          String uid = await auth.createUserWithEmailAndPassword(
              _email, _password, _name);
          print("Signed up with new ID $uid"); // Admin
        }
        Navigator.of(context).pushReplacementNamed("/home");
      } catch (e) {
        setState(() {
          _error = e.message;
        });
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final _width = MediaQuery.of(context).size.width;
    final _height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        color: Color(kPrimaryColor),
        height: _height,
        width: _width,
        child: SafeArea(
          child: Column(
            children: <Widget>[
              SizedBox(
                height: _height * .025,
              ),
              showAlert(),
              SizedBox(
                height: _height * .025,
              ),
              buildHeaderText(),
              SizedBox(
                height: _height * .05,
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    children: buildInputs() + buildButtons(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget showAlert() {
    if (_error != null) {
      return Container(
        color: Colors.amberAccent,
        width: double.infinity,
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: Icon(Icons.error_outline),
            ),
            Expanded(
              child: AutoSizeText(
                _error,
                maxLines: 3,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: IconButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    _error = null;
                  });
                },
              ),
            ),
          ],
        ),
      );
    }
    return SizedBox(height: 0);
  }

  AutoSizeText buildHeaderText() {
    String _headerText;
    if (authFormType == AuthFormType.signup) {
      _headerText = "Create New Account";
    } else if (authFormType == AuthFormType.reset) {
      _headerText = "Reset Password";
    } else {
      _headerText = "Sign In";
    }

    return AutoSizeText(
      _headerText,
      maxLines: 1,
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: 35,
        color: Color(0xFF1C58C9),
      ),
    );
  }

  InputDecoration buildSignUpInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: Colors.white,
      focusColor: Colors.white,
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
  }

  List<Widget> buildInputs() {
    List<Widget> textFields = [];

    if (authFormType == AuthFormType.reset) {
      textFields.add(
        TextFormField(
          validator: EmailValidator.validate,
          style: TextStyle(fontSize: 18),
          decoration: buildSignUpInputDecoration("Email"),
          onSaved: (value) {
            _email = value;
          },
        ),
      );

      textFields.add(SizedBox(height: 20));
      return textFields;
    }

    if (authFormType == AuthFormType.signup) {
      textFields.add(
        TextFormField(
          validator: NameValidator.validate,
          style: TextStyle(fontSize: 18),
          decoration: buildSignUpInputDecoration("Name"),
          onSaved: (value) {
            _name = value;
          },
        ),
      );

      textFields.add(SizedBox(height: 20));
    }
    textFields.add(
      TextFormField(
        validator: EmailValidator.validate,
        style: TextStyle(fontSize: 18),
        decoration: buildSignUpInputDecoration("Email"),
        onSaved: (value) {
          _email = value;
        },
      ),
    );

    textFields.add(SizedBox(height: 20));

    textFields.add(
      TextFormField(
        validator: PasswordValidator.validate,
        style: TextStyle(fontSize: 18),
        decoration: buildSignUpInputDecoration("Password"),
        obscureText: true,
        onSaved: (value) {
          _password = value;
        },
      ),
    );

    textFields.add(SizedBox(height: MediaQuery.of(context).size.height * 0.3));

    return textFields;
  }

  List<Widget> buildButtons() {
    String _switchButtonText;
    String _newFormState;
    String _submitButtonText;
    bool _showForgotPassword = false;

    if (authFormType == AuthFormType.signin) {
      _switchButtonText = "Create Account";
      _newFormState = "signup";
      _submitButtonText = "Sign In";
      _showForgotPassword = true;
    } else if (authFormType == AuthFormType.reset) {
      _switchButtonText = "Return to Sign In";
      _newFormState = "signin";
      _submitButtonText = "Submit";
    } else {
      _switchButtonText = "Have an Account? Sign In";
      _newFormState = "signin";
      _submitButtonText = "Sign Up";
    }

    return [
      Container(
        width: MediaQuery.of(context).size.width * 0.70,
        child: RoundedButton(
          colour: Color(kPrimaryColor),
          title: _submitButtonText,
          height: 60,
          width: 100,
          onPressed: submit,
        ),
      ),
      showForgotPassword(_showForgotPassword),
      FlatButton(
        child: Text(
          _switchButtonText,
          style: TextStyle(
            color: Color(kSecondaryColor),
            fontSize: 16,
          ),
          textAlign: TextAlign.center,
        ),
        onPressed: () {
          switchFormState(_newFormState);
        },
      )
    ];
  }

  Widget showForgotPassword(bool visible) {
    return Visibility(
      child: FlatButton(
        child: Text(
          "Forgot Password??",
          style: TextStyle(color: Color(kPrimaryColor), fontSize: 16),
          textAlign: TextAlign.center,
        ),
        onPressed: () {
          setState(() {
            authFormType = AuthFormType.reset;
          });
        },
      ),
      visible: visible,
    );
  }
}
