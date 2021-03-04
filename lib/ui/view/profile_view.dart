import 'dart:io';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:todo/ui/shared/style/theme.dart';
import 'package:todo/ui/shared/widget/custom_clipper_widget.dart';
import 'package:geocoder/geocoder.dart';
import 'package:todo/ui/shared/widget/profile_avatar_widget.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  File _image;
  bool isLoading = false;
  var locationText = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Stack(
          clipBehavior: Clip.none,
          children: <Widget>[
            Positioned(
              child: ClipPath(
                clipper: CustomClipperWidget(),
                child: Container(
                  color: myTheme.primaryColor,
                  width: double.infinity,
                  height: 300.0,
                ),
              ),
            ),
            Positioned(
              top: 200,
              left: (MediaQuery.of(context).size.width / 2) - 60,
              height: 120,
              width: 120,
              child: GestureDetector(
                onTap: () => showDialog(
                  context: context,
                  builder: (BuildContext bc) {
                    return alertDialog();
                  },
                ),
                child: ProfileAvatarWidget(image: _image),
              ),
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 80,
                  ),
                  textButton(),
                  Icon(
                    Icons.location_on,
                    color: myTheme.iconTheme.color,
                  ),
                  Text(locationText),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getCurrentLocation() async {
    setState(() {
      isLoading = true;
    });
    var position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
    var lastPosition = await Geolocator.getLastKnownPosition();
    print(lastPosition);
    var lon = position.longitude;
    var lat = position.latitude;

    final coordinates = Coordinates(lat, lon);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print("${first.featureName} : ${first.addressLine}");

    setState(() {
      locationText = "${first.featureName} : ${first.addressLine}";
      isLoading = false;
    });
  }

  getFromGallery() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
    );
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  getFromCamera() async {
    PickedFile pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
    );
    setState(() {
      _image = File(pickedFile.path);
    });
  }

  Widget alertDialog() {
    return AlertDialog(
      content: SingleChildScrollView(
        child: Container(
          child: new Wrap(
            children: <Widget>[
              new ListTile(
                  leading: new Icon(
                    Icons.photo_library,
                    color: myTheme.iconTheme.color,
                  ),
                  title: new Text('Galeri'),
                  onTap: () {
                    getFromGallery();
                    Navigator.of(context).pop();
                  }),
              new ListTile(
                leading: new Icon(
                  Icons.photo_camera,
                  color: myTheme.iconTheme.color,
                ),
                title: new Text('Kamera'),
                onTap: () {
                  getFromCamera();
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget textButton() {
    return TextButton(
      onPressed: () {
        isLoading
            ? CircularProgressIndicator(
                strokeWidth: 2.0,
                valueColor: AlwaysStoppedAnimation(Colors.black),
              )
            : getCurrentLocation();
      },
      child: Text(
        "Konumu Al",
        style: myTheme.textTheme.headline2,
      ),
      style: TextButton.styleFrom(
        backgroundColor: myTheme.buttonColor,
      ),
    );
  }
}
