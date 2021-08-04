import 'dart:ui';

import 'package:Ecommerce/constatns.dart';
import 'package:Ecommerce/models/user.dart';
import 'package:Ecommerce/providers/user_provider.dart';
import 'package:Ecommerce/widgets/my_text_field.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class EditProfile extends StatefulWidget {
  static const routeName = '/edit-profile';
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final profileFormKey = GlobalKey<FormState>();

  TextEditingController nameController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController cardController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    initialValues();
    super.initState();
  }

  initialValues() {
    final dataProvider = Provider.of<UserProvider>(context, listen: false);
    nameController.text = dataProvider.myUser.userName;
    dataProvider.myUser.address != null
        ? addressController.text = dataProvider.myUser.address
        : addressController.text = '';
    dataProvider.myUser.years != null
        ? ageController.text = dataProvider.myUser.years.toString()
        : ageController.text = '';
    cardController.text = dataProvider.myUser.card != null
        ? dataProvider.myUser.card.toString()
        : '';
    phoneController.text = dataProvider.myUser.phone != null
        ? dataProvider.myUser.phone.toString()
        : '';
  }

  updateInfo() async {
    if (profileFormKey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      await Provider.of<UserProvider>(context, listen: false).updateUserInfo(
          nameController.text,
          addressController.text,
          int.parse(phoneController.text),
          int.parse(ageController.text),
          int.parse(cardController.text));
      setState(() {
        isLoading = false;
      });
      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    addressController.dispose();
    phoneController.dispose();
    ageController.dispose();
    cardController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    User userProvider = Provider.of<UserProvider>(context).myUser;
    return SafeArea(
      child: Scaffold(
        body: isLoading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Form(
                  key: profileFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          ImageFiltered(
                            imageFilter:
                                ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                            child: Image.network(
                              userProvider.imageUrl,
                              height: 47.0.h,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            left: 20,
                            top: 20,
                            right: 20,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    'Cancel',
                                    style: myUpuntoFont(Colors.grey[300],
                                        17.0.sp, FontWeight.w300),
                                  ),
                                ),
                                Column(
                                  children: [
                                    Text(
                                      'Edit Profile',
                                      style: myUpuntoFont(yellowColor, 19.0.sp,
                                          FontWeight.w400),
                                    ),
                                  ],
                                ),
                                GestureDetector(
                                  onTap: () async {
                                    await updateInfo();
                                  },
                                  child: Text(
                                    'Save',
                                    style: myUpuntoFont(Colors.grey[300],
                                        17.0.sp, FontWeight.w300),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Positioned(
                            bottom: 14.0.h,
                            left: 36.5.w,
                            child: CircleAvatar(
                              radius: 46.0.sp,
                              backgroundImage:
                                  NetworkImage(userProvider.imageUrl),
                            ),
                          ),
                          Positioned(
                            bottom: -5,
                            left: 20,
                            right: 20,
                            child: MyTextField(
                              'User name',
                              nameController,
                              'Can not be empty',
                              isNameEdit: true,
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        height: 4.0.h,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 5.0.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextAndTextField(
                              controller: addressController,
                              text: 'Address',
                            ),
                            Row(
                              children: [
                                Expanded(
                                    flex: 4,
                                    child: TextAndTextField(
                                      controller: phoneController,
                                      text: 'Phone number',
                                    )),
                                Expanded(
                                  flex: 1,
                                  child: Container(),
                                ),
                                Expanded(
                                    flex: 3,
                                    child: TextAndTextField(
                                      controller: ageController,
                                      text: 'Age',
                                    )),
                              ],
                            ),
                            TextAndTextField(
                              controller: cardController,
                              text: 'Card number',
                              isCardNumber: true,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
      ),
    );
  }
}

class TextAndTextField extends StatelessWidget {
  TextAndTextField({@required this.controller, this.text, this.isCardNumber});

  final TextEditingController controller;
  final String text;
  final bool isCardNumber;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 1.5.h),
          child: Text(
            text,
            style: myUpuntoFont(Colors.grey[300], 12.0.sp, FontWeight.w500),
          ),
        ),
        MyTextField(
          text,
          controller,
          'Cannot be empty',
          isCardNumber: isCardNumber,
        ),
      ],
    );
  }
}
