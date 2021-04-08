import 'package:Ecommerce/constatns.dart';
import 'package:Ecommerce/providers/user_provider.dart';
import 'package:Ecommerce/screens/edit_profile.dart';
import 'package:Ecommerce/widgets/my_dynamic_header.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class ProfileScreen extends StatefulWidget {
  static const routeName = '/profile-screen';
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          body: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            pinned: true,
            delegate: MyDynamicHeader(),
          ),
          SliverToBoxAdapter(
            child: CreditCard(),
          )
        ],
      )
          //  Column(
          //   children: [
          //     Row(
          //       children: [
          //         GestureDetector(
          //           onTap: () {
          //             Navigator.pop(context);
          //             Provider.of<ToggleProvider>(context, listen: false)
          //                 .changeToValues();
          //           },
          //           child: CircleAvatar(
          //             backgroundColor: Colors.grey,
          //             radius: 20,
          //           ),
          //         ),
          //         SizedBox(width: 20),
          //         Text(
          //           'Profile',
          //         ),
          //         Spacer(),
          //         IconButton(icon: Icon(Icons.search), onPressed: () {}),
          //       ],
          //     )
          //   ],
          // ),
          ),
    );
  }
}

class CreditCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 9.5.h, horizontal: 6.0.w),
        child: Row(
          children: [
            Expanded(
              flex: 4,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0.sp),
                      color: Color(0xff06070D),
                    ),
                    height: 23.5.h,
                  ),
                  Positioned(
                    right: -17.0.w,
                    top: -11.0.h,
                    child: Container(
                      height: 23.0.h,
                      width: 23.0.h,
                      decoration: BoxDecoration(
                          color: Color(0xff1D1E25),
                          borderRadius: BorderRadius.circular(77.0.sp)),
                    ),
                  ),
                  Positioned(
                    left: -17.0.w,
                    bottom: -11.0.h,
                    child: Container(
                      height: 26.5.h,
                      width: 26.5.h,
                      decoration: BoxDecoration(
                          color: Color(0xff1D1E25),
                          borderRadius: BorderRadius.circular(100)),
                    ),
                  ),
                  Positioned(
                    top: 3.0.h,
                    left: 14.5.w,
                    child: CircleAvatar(
                      radius: 15.0.sp,
                      backgroundColor: Color(0xffEB031C),
                    ),
                  ),
                  Positioned(
                    top: 3.0.h,
                    left: 20.5.w,
                    child: CircleAvatar(
                      radius: 15.0.sp,
                      backgroundColor: yellowColor.withOpacity(.8),
                    ),
                  ),
                  Positioned(
                      top: 11.0.h,
                      left: 14.5.w,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Credit Card',
                            style: myUpuntoFont(
                                Colors.grey[400], 15.0.sp, FontWeight.w500),
                          ),
                          SizedBox(
                            height: 1.0.h,
                          ),
                          Consumer<UserProvider>(
                            builder: (context, provider, _) {
                              return Text(
                                provider.returnCardNumber() != null
                                    ? provider.returnCardNumber()
                                    : ' ',
                                style: GoogleFonts.raleway(
                                  textStyle: TextStyle(
                                      color: Colors.grey[400],
                                      fontSize: 11.5.sp,
                                      fontWeight: FontWeight.w800),
                                ),
                              );
                            },
                          )
                        ],
                      )),
                  Positioned(
                    right: 1.0.w,
                    top: 3.0.h,
                    child: Image.asset(
                      'images/card-.png',
                      height: 5.5.h,
                      fit: BoxFit.fill,
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              width: 5.0.w,
            ),
            Expanded(
                flex: 1,
                child: SizedBox(
                  height: 15.5.h,
                  child: FlatButton(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0.sp)),
                    onPressed: () {
                      Navigator.of(context).pushNamed(EditProfile.routeName);
                    },
                    color: Colors.grey[200],
                    child: Icon(
                      Icons.add,
                      size: 27.0.sp,
                      color: darkColor,
                    ),
                  ),
                )),
          ],
        ));
  }
}
