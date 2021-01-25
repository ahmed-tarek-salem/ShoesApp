import 'package:Ecommerce/constatns.dart';
import 'package:Ecommerce/providers/toggle_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class EmptyOrders extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
            padding: const EdgeInsets.only(left: 8.0, top: 5, bottom: 30),
            child: backArrow(context)),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15.0),
              child: Text(
                'OPPS! YOU HAVEN\'T SENT ANY ORDERS YET',
                textAlign: TextAlign.center,
                style: myUpuntoFont(darkColor, 25, FontWeight.w600),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: Image.asset(
                'images/fogg-87.png',
                height: 300,
              ),
            ),
            Text(
              'Fortunately, we have the solution',
              style: GoogleFonts.raleway(
                textStyle: TextStyle(
                    color: darkColor,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: GestureDetector(
                child: SizedBox(
                  height: 50,
                  width: 150,
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
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        )),
                    color: Colors.black,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
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
