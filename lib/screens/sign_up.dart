import 'package:Ecommerce/constatns.dart';
import 'package:Ecommerce/models/user.dart';
import 'package:Ecommerce/screens/toggle_screen.dart';
import 'package:Ecommerce/services/auth.dart';
import 'package:Ecommerce/services/database_methods.dart';
import 'package:Ecommerce/services/shared_pref.dart';
import 'package:Ecommerce/widgets/my_text_field.dart';
import 'package:Ecommerce/widgets/radio_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class SignUp extends StatefulWidget {
  static const routeName = '/sign-up-screen';
  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> with TickerProviderStateMixin {
  AnimationController controller;
  Animation<double> animation;

  AnimationController backController;
  Animation<double> backAnimation;

  AuthMethods authMethods = AuthMethods();
  TextEditingController emailCont = TextEditingController();
  TextEditingController passCont = TextEditingController();
  TextEditingController nameCont = TextEditingController();
  SharedPref sharedPref = SharedPref();
  var formkey = GlobalKey<FormState>();

  bool _switchValue = true;
  bool radioValue = false;

  bool isSigningUp = true;
  bool isLoading = false;
  @override
  void initState() {
    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    animation = Tween<double>(begin: 0.0, end: 1.0).animate(controller);
    controller.forward();

    backController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 700));
    backAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(backController);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    backController.dispose();
    super.dispose();
  }

  login() async {
    if (formkey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      String userId = await authMethods.logIn(emailCont.text, passCont.text);
      if (userId == null) {
        setState(() {
          isLoading = false;
        });
        await showErrorDialog();
      } else {
        await sharedPref.markTheUser(userId);
        Navigator.of(context).pushReplacementNamed(ToggleScreen.routeName,
            arguments: _switchValue);
      }
    }
  }

  signUp() async {
    if (formkey.currentState.validate()) {
      setState(() {
        isLoading = true;
      });
      String userId = await authMethods.signUp(emailCont.text, passCont.text);
      if (userId == null) {
        setState(() {
          isLoading = false;
        });
        await showErrorDialog();
      } else {
        await sharedPref.markTheUser(userId);
        await addUserToDataBase(userId);
        Navigator.of(context).pushReplacementNamed(ToggleScreen.routeName,
            arguments: _switchValue);
      }
    }
  }

  addUserToDataBase(String userId) async {
    User myUser = User(
      phone: null,
      imageUrl:
          "https://www.xovi.com/wp-content/plugins/all-in-one-seo-pack/images/default-user-image.png",
      userId: userId,
      userName: nameCont.text,
      address: null,
      card: null,
      years: null,
      isAdmin: false,
    );
    await DatabaseMethods().setUserInfo(myUser);
  }

  showErrorDialog() async {
    return await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text('An error occured'),
            content: Text('Something went wrong'),
            actions: [
              FlatButton(
                child: Text('ok'),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: isLoading
              ? Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      Center(
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 700),
                          height: isSigningUp ? 23.0.h : 30.0.h,
                          width: 100.0.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Spacer(),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: isSigningUp ? 20.0 : 0),
                                  child: Text(
                                    'WELCOME',
                                    style: myGoogleFont(
                                        darkColor, 30.5.sp, FontWeight.w600),
                                  ),
                                ),
                              ),
                              // isSigningUp
                              //     ? Container()
                              //     :
                              FadeTransition(
                                opacity: backAnimation,
                                child: Text(
                                  'BACK!',
                                  style: myGoogleFont(
                                      darkColor,
                                      isSigningUp ? 0 : 30.5.sp,
                                      FontWeight.w600),
                                ),
                              ),
                              Transform.translate(
                                offset: Offset(0, 10),
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black12,
                                        spreadRadius: 0,
                                        offset: Offset(0.5, .5), //(x,y)
                                        blurRadius: 20.0,
                                      ),
                                    ],
                                  ),
                                  child: GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        isSigningUp = !isSigningUp;
                                      });
                                      // isSigningUp
                                      //     ? controller.forward()
                                      //     : controller.reverse();
                                      if (isSigningUp) {
                                        controller.forward();
                                        backController.reverse();
                                      } else {
                                        controller.reverse();
                                        backController.forward();
                                      }
                                    },
                                    child: CircleAvatar(
                                      radius: 11.5.sp,
                                      backgroundColor: Colors.white,
                                      child: Icon(
                                        isSigningUp
                                            ? Icons.arrow_forward_ios_outlined
                                            : Icons.arrow_back_ios_outlined,
                                        color: yellowColor,
                                        size: 10.0.sp,
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            ],
                          ),
                          decoration: BoxDecoration(
                              color: yellowColor,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(400),
                                  bottomRight: Radius.circular(400))),
                        ),
                      ),
                      Form(
                        key: formkey,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: 8.0.w, vertical: 3.0.h),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              MyTextField('  Email', emailCont,
                                  'Please enter an email'),
                              MyTextField(
                                '  Password',
                                passCont,
                                'Please enter a password',
                                isPassword: true,
                              ),
                              FadeTransition(
                                opacity: animation,
                                child: MyTextField(
                                  '  Name',
                                  nameCont,
                                  'Please enter a username',
                                  login: isSigningUp ? false : true,
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 15.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Remember me',
                                      style: myGoogleFont(
                                          darkColor, 15.0.sp, FontWeight.w500),
                                    ),
                                    CupertinoSwitch(
                                      value: _switchValue,
                                      onChanged: (val) {
                                        setState(() {
                                          _switchValue = val;
                                        });
                                      },
                                      activeColor: yellowColor,
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 2.0.h),
                                child: FadeTransition(
                                  opacity: animation,
                                  child: Row(
                                    children: [
                                      GestureDetector(
                                        child: RadioButton(radioValue),
                                        onTap: () {
                                          setState(() {
                                            radioValue = !radioValue;
                                          });
                                        },
                                      ),
                                      SizedBox(width: 1.0.w),
                                      Text('I agree with the',
                                          style: TextStyle(
                                            fontSize: 11.5.sp,
                                            fontWeight: FontWeight.w300,
                                            color: darkColor,
                                          )),
                                      SizedBox(width: 1.0.w),
                                      Text(
                                        'User Agreement',
                                        style: TextStyle(
                                            fontSize: 11.5.sp,
                                            fontWeight: FontWeight.w300,
                                            color: Colors.blueAccent,
                                            decoration:
                                                TextDecoration.underline),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              SizedBox(height: 1.0.h),
                              SizedBox(
                                width: double.infinity,
                                height: 10.0.h,
                                child: FlatButton(
                                  disabledColor: Colors.grey[200],
                                  color: yellowColor,
                                  onPressed:
                                      (radioValue == false && isSigningUp)
                                          ? null
                                          : () {
                                              isSigningUp ? signUp() : login();
                                            },
                                  child: Text(
                                    isSigningUp ? 'Sign up' : 'Log in',
                                    style: myGoogleFont(
                                        radioValue ? darkColor : Colors.white,
                                        19.0.sp,
                                        FontWeight.w500),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )),
    );
  }
}
