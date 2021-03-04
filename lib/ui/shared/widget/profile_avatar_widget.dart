import 'dart:io';

import 'package:flutter/material.dart';
import 'package:todo/ui/shared/style/theme.dart';

class ProfileAvatarWidget extends StatelessWidget {
  const ProfileAvatarWidget({
    Key key,
    @required File image,
  })  : _image = image,
        super(key: key);

  final File _image;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      child: _image != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.file(
                _image,
                width: 120,
                height: 120,
                fit: BoxFit.fitHeight,
              ),
            )
          : Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                border: Border.all(color: myTheme.primaryColor),
              ),
              width: 120,
              height: 120,
              child: Icon(Icons.camera_alt, color: myTheme.iconTheme.color),
            ),
    );
  }
}
