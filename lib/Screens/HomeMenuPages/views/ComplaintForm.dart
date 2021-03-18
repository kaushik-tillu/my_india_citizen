import 'dart:io';
import 'package:my_india_citizen/constants.dart';
import 'package:path/path.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import '../services/toast.dart';
import '../services/focuschanger.dart';
import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:date_format/date_format.dart';

final _fireStore = FirebaseFirestore.instance;

class ComplaintForm extends StatefulWidget {
  @override
  _ComplaintFormState createState() => _ComplaintFormState();
}

class _ComplaintFormState extends State<ComplaintForm> {
  var dateTime = formatDate(DateTime.now(), [dd, ' ', MM, ' ', yyyy]);

  final _formKey = GlobalKey<FormState>();
  // final _firestore = Firestore.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Geoflutterfire geo = Geoflutterfire();
  Location location = new Location();

  String username, email, complain, department, address, landmark, comment;
  int phonenum;
  bool work = false;
  String imageurl;
  File image;
  String filename;
  final picker = ImagePicker();

  Future _getImage() async {
    var selectedImage =
        await ImagePicker.pickImage(source: ImageSource.gallery);
    setState(() {
      image = selectedImage;
      filename = basename(image.path);
    });
    uploadImage();
  }

  Future<String> uploadImage() async {
    firebase_storage.Reference ref =
        firebase_storage.FirebaseStorage.instance.ref().child(filename);
    firebase_storage.UploadTask uploadTask = ref.putFile(image);

    //await uploadTask.onComplete

    var downUrl = await (await uploadTask).ref.getDownloadURL();

    // var downUrl = await firebase_storage.FirebaseStorage.instance
    //   .ref()
    //   .getDownloadURL();
    var url = downUrl.toString();
    setState(() {
      imageurl = url;
    });
    return ('url is $imageurl');
  }

  void uploadform() async {
    var pos = await location.getLocation();
    GeoFirePoint point =
        geo.point(latitude: pos.latitude, longitude: pos.longitude);
    _fireStore.collection('Reports').add({
      'username': username,
      'position': point.data,
      'email': email,
      'complaintype': complain,
      'department': department,
      'address': address,
      'landmark': landmark,
      'comment': comment,
      'phonenum': phonenum,
      'work': work,
      'imageurl': imageurl,
      'dateTime': dateTime,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: BackButton(
          color: Color(kPrimaryColor),
        ),
        backgroundColor: Colors.white,
        title: Text(
          "Complaint Form",
          style: TextStyle(color: Color(kPrimaryColor), fontSize: 24),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
            key: _formKey,
            child: Column(
              children: [
                SizedBox(height: 20.0),
                RaisedButton.icon(
                    color: Color(kPrimaryColor),
                    onPressed: _getImage,
                    icon: Icon(
                      Icons.add_a_photo,
                      color: Colors.white,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    label: Text(
                      'Add Image',
                      style: TextStyle(color: Colors.white),
                    )),
                SizedBox(height: 20.0),
                Center(
                  child: Builder(
                    builder: (context) {
                      if (image == null) {
                        return Text(
                          'Please choose an image',
                          style: TextStyle(
                              fontSize: 15.0, color: Colors.redAccent),
                        );
                      } else {
                        return Text(
                          'Image has been selected',
                          style: TextStyle(fontSize: 15.0, color: Colors.green),
                        );
                      }
                    },
                  ),
                ),
                SizedBox(height: 20.0),
                TextFormField(
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Complaint",
                    hintText: "e.g pothole, street light, garbage, water etc",
                    focusColor: Color(kPrimaryColor),
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(8.0),
                      ),
                      borderSide: new BorderSide(
                        color: Color(kPrimaryColor),
                        width: 1.0,
                      ),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  onChanged: (value) => complain = value,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Department",
                    hintText: "e.g Nagarpalika",
                    focusColor: Color(kPrimaryColor),
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(8.0),
                      ),
                      borderSide: new BorderSide(
                        color: Color(kPrimaryColor),
                        width: 1.0,
                      ),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (department) {
                    if (department.isEmpty) {
                      return 'Department is Required';
                    }
                    return null;
                  },
                  onChanged: (value) => department = value,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Address",
                    hintText: "Address of complaint",
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(8.0),
                      ),
                      borderSide: new BorderSide(
                        color: Color(kPrimaryColor),
                        width: 1.0,
                      ),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (address) {
                    if (address.isEmpty) {
                      return 'Address is Required';
                    }
                    return null;
                  },
                  onChanged: (value) => address = value,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Landmark",
                    hintText: "Nearby Landmark",
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(8.0),
                      ),
                      borderSide: new BorderSide(
                        color: Color(kPrimaryColor),
                        width: 1.0,
                      ),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (name) {
                    if (name.isEmpty) {
                      return 'Landmark is Required';
                    }
                    return null;
                  },
                  onChanged: (value) => landmark = value,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    labelText: "Comment",
                    hintText: "Comment about complaint",
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(8.0),
                      ),
                      borderSide: new BorderSide(
                        color: Color(kPrimaryColor),
                        width: 1.0,
                      ),
                    ),
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (comment) {
                    if (comment.isEmpty) {
                      return 'Comment is Required';
                    }
                    return null;
                  },
                  onChanged: (value) => comment = value,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  autofocus: true,
                  textCapitalization: TextCapitalization.words,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(8.0),
                      ),
                      borderSide: new BorderSide(
                        color: Color(kPrimaryColor),
                        width: 1.0,
                      ),
                    ),
                    labelText: "Username",
                    hintText: "e.g Kaushik",
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (name) {
                    Pattern pattern = r'^[A-Za-z0-9]+(?:[ _-][A-Za-z0-9]+)*$';
                    RegExp regex = new RegExp(pattern);
                    if (!regex.hasMatch(name))
                      return 'Invalid username';
                    else
                      return null;
                  },
                  onChanged: (value) => username = value,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(8.0),
                      ),
                      borderSide: new BorderSide(
                        color: Color(kPrimaryColor),
                        width: 1.0,
                      ),
                    ),
                    labelText: "Email",
                    hintText: "e.g abc@example.com",
                  ),
                  textInputAction: TextInputAction.next,
                  validator: (email) => EmailValidator.validate(email)
                      ? null
                      : "Invalid email address",
                  onChanged: (value) => email = value,
                ),
                SizedBox(
                  height: 20.0,
                ),
                TextFormField(
                  decoration: new InputDecoration(
                    labelText: "Enter your number",
                    border: new OutlineInputBorder(
                      borderRadius: const BorderRadius.all(
                        const Radius.circular(8.0),
                      ),
                      borderSide: new BorderSide(
                        color: Color(kPrimaryColor),
                        width: 1.0,
                      ),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  onChanged: (value) {
                    phonenum = int.parse(value);
                  },
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ], // Only numbers can be entered
                ),
                SizedBox(
                  height: 50.0,
                ),
                Container(
                  height: 50,
                  width: 200,
                  child: RaisedButton(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(100.0),
                    ),
                    color: Color(kPrimaryColor),
                    onPressed: () async {
                      if (image == null) {
                        toastMessage('Please Select an Image');
                      } else {
                        if (_formKey.currentState.validate()) {
                          _formKey.currentState.save();
                          toastMessage(
                              "Thank You Your Response has been submitted");
                          uploadform();
                          await new Future.delayed(const Duration(seconds: 3));
                          Navigator.pop(context);
                        }
                      }
                    },
                    child: Text(
                      "Submit",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ),
              ],
            )),
      ),
    );
  }
}
