import 'dart:io';

import 'package:Ecommerce/constatns.dart';
import 'package:Ecommerce/providers/products_provider.dart';
import 'package:Ecommerce/providers/toggle_provider.dart';
import 'package:Ecommerce/services/database_methods.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import 'package:sizer/sizer.dart';

class AddProduct extends StatefulWidget {
  static const routeName = '/add-product';
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  TextEditingController titleCont = TextEditingController();
  TextEditingController descCont = TextEditingController();
  TextEditingController priceCont = TextEditingController();
  var formkey = GlobalKey<FormState>();
  File file;
  bool isLoading = false;
  var productId = Uuid().v4();
  String imageUrl;

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
                  String url = await DatabaseMethods()
                      .uploadImageToStorge(file, uuid: productId.toString());
                  setStateIfMounted(() {
                    imageUrl = url;
                  });
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
    setStateIfMounted(() {
      file = File(pickedFile.path);
    });
  }

  imageFromCamera(context) async {
    Navigator.pop(context);
    final pickedFile = await ImagePicker().getImage(source: ImageSource.camera);
    setStateIfMounted(() {
      file = File(pickedFile.path);
    });
  }

  @override
  void dispose() {
    titleCont.dispose();
    descCont.dispose();
    priceCont.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 2.5.h, horizontal: 5.0.w),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(Icons.cancel_outlined),
                      iconSize: 23.0.sp,
                      color: darkColor,
                      onPressed: () {
                        Navigator.pop(context);
                        Provider.of<ToggleProvider>(context, listen: false)
                            .changeToZero();
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.check_circle_outline_rounded),
                      iconSize: 23.0.sp,
                      color: darkColor,
                      onPressed: () async {
                        if (formkey.currentState.validate()) {
                          await Provider.of<ProductsProvider>(context,
                                  listen: false)
                              .addProduct(
                                  titleCont.text,
                                  descCont.text,
                                  double.parse(priceCont.text),
                                  imageUrl,
                                  productId);
                          Navigator.pop(context);
                          Provider.of<ToggleProvider>(context, listen: false)
                              .changeToZero();
                        }
                      },
                    ),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      'Add product',
                      style: myGoogleFont(darkColor, 24.0.sp, FontWeight.w500),
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    await selectImage(context);
                  },
                  child: Container(
                    height: 15.0.h,
                    width: 15.0.h,
                    margin: EdgeInsets.symmetric(vertical: 2.5.h),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15.0.h),
                        border: Border.all(color: darkColor, width: 1.0.sp)),
                    child: file != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.file(
                              file,
                              height: 15.5.h,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Center(
                            child: Text(
                              'Add photo',
                              textAlign: TextAlign.center,
                              style: myGoogleFont(
                                  darkColor, 15.0.sp, FontWeight.w200),
                            ),
                          ),
                  ),
                ),
                Form(
                  key: formkey,
                  child: Column(
                    children: [
                      ProductTextField(
                        label: 'Product title',
                        controller: titleCont,
                      ),
                      ProductTextField(
                        label: 'Product description',
                        controller: descCont,
                      ),
                      ProductTextField(
                        label: 'Product price',
                        controller: priceCont,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ProductTextField extends StatelessWidget {
  final String label;
  final controller;
  ProductTextField({this.label, this.controller});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 2.5.h),
      child: TextFormField(
        style: TextStyle(fontSize: 15.0.sp),
        controller: controller,
        validator: (val) {
          if (val.length == 0) return 'This Can not be empty';
        },
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0.sp),
            borderSide: BorderSide(color: darkColor, width: 1.0.sp),
          ),
        ),
      ),
    );
  }
}
