import 'dart:async';

import 'package:Ecommerce/constatns.dart';
import 'package:Ecommerce/screens/sign_up.dart';
import 'package:Ecommerce/screens/toggle_screen.dart';
import 'package:Ecommerce/services/shared_pref.dart';
import 'package:Ecommerce/widgets/custom_painter.dart';
import 'package:Ecommerce/widgets/splash_content.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  int currentPage = 0;
  bool isInit = true;
  AnimationController progressController;
  Animation<double> animation;

  @override
  void initState() {
    super.initState();

    progressController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1000));
    animation = Tween<double>(begin: 0, end: 100).animate(progressController)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void didChangeDependencies() async {
    if (isInit) {
      final userId = await SharedPref().checkIfLoggedIn();
      if (userId != null)
        Navigator.of(context).pushNamed(ToggleScreen.routeName);
      isInit = false;
    }
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    timer.cancel();
    progressController.dispose();
    super.dispose();
  }

  Timer timer;
  int start = 1;
  void startTimer() {
    const oneSec = const Duration(milliseconds: 500);
    timer = new Timer.periodic(
      oneSec,
      (Timer timer) {
        if (start == 0) {
          setState(() {
            timer.cancel();
            Navigator.of(context).pushReplacementNamed(SignUp.routeName);
          });
        } else {
          setState(() {
            start--;
          });
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Expanded(
                flex: 3,
                child: PageView.builder(
                    onPageChanged: (val) {
                      setState(() {
                        currentPage = val;
                      });
                    },
                    itemCount: splashData.length,
                    itemBuilder: (context, index) {
                      return SplashContent(
                          splashData[index]['title'],
                          splashData[index]['image'],
                          splashData[index]['text'],
                          currentPage);
                    }),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomPaint(
                        foregroundPainter: DrawCircle(animation.value),
                        child: SizedBox(
                          width: 70,
                          height: 70,
                          child: GestureDetector(
                            onTapUp: (_) {
                              progressController.reverse();
                              setState(() {
                                start = 1;
                                timer.cancel();
                              });
                            },
                            onTapDown: (_) {
                              if (animation.value == 100) {
                                Navigator.pop(context);
                              } else {
                                startTimer();
                                progressController.forward();
                              }
                            },
                            child: Container(
                                decoration: BoxDecoration(
                                    color: darkColor,
                                    borderRadius: BorderRadius.circular(50)),
                                child: Center(
                                  child: Icon(
                                    Icons.arrow_forward_ios_outlined,
                                    color: Colors.white,
                                    size: 30,
                                  ),
                                )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}

class BuildDot extends StatelessWidget {
  final int index;
  final int currentPage;
  BuildDot(this.index, this.currentPage);
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 400),
      margin: EdgeInsets.only(right: 6, bottom: 0),
      height: 6,
      width: currentPage == index ? 15 : 6,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(3),
          color: currentPage == index ? darkColor : Colors.grey[300]),
    );
  }
}
