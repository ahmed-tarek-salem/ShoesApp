import 'package:Ecommerce/constatns.dart';
import 'package:Ecommerce/providers/toggle_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

class EmptyOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: EdgeInsets.only(left: 2.0.w, top: 1.0.h, bottom: 5.0.h),
            child: backArrow(context)),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 3.5.w),
              child: Text(
                'OPPS! YOU HAVEN\'T SENT ANY ORDERS YET',
                textAlign: TextAlign.center,
                style: myUpuntoFont(darkColor, 19.0.sp, FontWeight.w600),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2.3.h),
              child: Image.asset(
                'images/fogg-87.png',
                height: 47.0.h,
              ),
            ),
            Text(
              'Fortunately, we have the solution',
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                    color: darkColor,
                    fontSize: 14.0.sp,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: GestureDetector(
                child: SizedBox(
                  height: 8.0.h,
                  width: 36.5.w,
                  child: FlatButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Provider.of<ToggleProvider>(context, listen: false)
                          .changeToZero();
                    },
                    child: Text('Go Shopping!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.raleway(
                          textStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 12.5.sp,
                              fontWeight: FontWeight.w600),
                        )),
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(7.0.sp)),
                  ),
                ),
              ),
            )
          ],
        ),
      ],
    );
  }
}
