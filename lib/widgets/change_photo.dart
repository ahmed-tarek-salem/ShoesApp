import 'dart:io';

import 'package:Ecommerce/constatns.dart';
import 'package:Ecommerce/providers/user_provider.dart';
import 'package:Ecommerce/services/database_methods.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ChangePhoto extends StatefulWidget {
  const ChangePhoto({
    Key key,
  }) : super(key: key);

  @override
  _ChangePhotoState createState() => _ChangePhotoState();
}

class _ChangePhotoState extends State<ChangePhoto> {
  File file;
  bool isLoading = false;

  void setStateIfMounted(f) {
    if (mounted) setState(f);
  }

  selectImage(parentContext) {
    return showDialog(
        context: parentContext,
        builder: (dialogContext) {
          return SimpleDialog(
            title: Text('Upload a photo'),
            children: [
              SimpleDialogOption(
                child: Text(
                  'Choose an image From Gallery',
                ),
                onPressed: () async {
                  await imageFromGallery(parentContext);
                },
              ),
              SimpleDialogOption(
                child: Text(
                  'Open camera',
                ),
                onPressed: () {
                  imageFromCamera(parentContext);
                },
              ),
              SimpleDialogOption(
                child: Text(
                  'Cancel',
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  imageFromGallery(context) async {
    Navigator.pop(context);
    final pickedFile = await ImagePicker()
        .getImage(source: ImageSource.gallery, imageQuality: 85);
    if (pickedFile != null) {
      setStateIfMounted(() {
        file = File(pickedFile.path);
      });
      String url = await DatabaseMethods().updatePhoto(file);
      Provider.of<UserProvider>(context, listen: false).updatePhoto(url);
    }
  }

  imageFromCamera(context) async {
    Navigator.pop(context);
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    if (pickedFile != null) {
      setStateIfMounted(() {
        file = File(pickedFile.path);
      });
      String url = await DatabaseMethods().updatePhoto(file);
      Provider.of<UserProvider>(context, listen: false).updatePhoto(url);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 7.8.h,
      right: 5.0.w,
      child: GestureDetector(
        onTap: () {
          selectImage(context);
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            vertical: 2.0.w,
            horizontal: 2.0.w,
          ),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0.sp), color: yellowColor),
          child: Icon(
            Icons.camera_alt,
            size: 20.0.sp,
            color: Colors.white,
          ),
          // IconButton(
          //   onPressed: () {
          //     selectImage(context);
          //   },
          //   color: Colors.white,
          //   icon: Icon(
          //     Icons.camera_alt,
          //     size: 20.0.sp,
          //   ),
          // ),
        ),
      ),
    );
  }
}
