import 'package:Ecommerce/providers/toggle_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:sizer/sizer.dart';

Color yellowColor = Color(0xffFFDB47);
Color darkColor = Color(0xff171717);
// Color darkColor = Color(0xff06070D);
TextStyle myGoogleFont(
    Color textColor, double myfontSize, FontWeight fontWeight,
    {double letterSpacing}) {
  return GoogleFonts.montserrat(
      textStyle: TextStyle(
          color: textColor,
          fontSize: myfontSize,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing == null ? 0.3 : letterSpacing));
}

TextStyle myUpuntoFont(
    Color textColor, double myfontSize, FontWeight fontWeight,
    {double letterSpacing}) {
  return GoogleFonts.ubuntu(
      textStyle: TextStyle(
          color: textColor,
          fontSize: myfontSize,
          fontWeight: fontWeight,
          letterSpacing: letterSpacing == null ? 0.3 : letterSpacing));
}

IconButton backArrow(BuildContext context, {Color color}) {
  return IconButton(
    icon: Icon(
      Icons.arrow_back_ios,
      size: 20.0.sp,
    ),
    color: color != null ? color : darkColor,
    onPressed: () {
      Navigator.pop(context);
      Provider.of<ToggleProvider>(context, listen: false).changeToZero();
    },
  );
}
