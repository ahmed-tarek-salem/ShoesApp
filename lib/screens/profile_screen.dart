import 'package:Ecommerce/constatns.dart';
import 'package:Ecommerce/providers/user_provider.dart';
import 'package:Ecommerce/screens/edit_profile.dart';
import 'package:Ecommerce/widgets/my_dynamic_header.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

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
            child: Container(
                margin: EdgeInsets.symmetric(vertical: 60, horizontal: 25),
                child: Row(
                  children: [
                    Expanded(
                      flex: 4,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Color(0xff06070D),
                            ),
                            height: 150,
                          ),
                          Positioned(
                            right: -70,
                            top: -70,
                            child: Container(
                              height: 150,
                              width: 150,
                              decoration: BoxDecoration(
                                  color: Color(0xff1D1E25),
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                          ),
                          Positioned(
                            left: -70,
                            bottom: -70,
                            child: Container(
                              height: 170,
                              width: 170,
                              decoration: BoxDecoration(
                                  color: Color(0xff1D1E25),
                                  borderRadius: BorderRadius.circular(100)),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            left: 60,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: Color(0xffEB031C),
                            ),
                          ),
                          Positioned(
                            top: 20,
                            left: 85,
                            child: CircleAvatar(
                              radius: 20,
                              backgroundColor: yellowColor.withOpacity(.8),
                            ),
                          ),
                          Positioned(
                              top: 70,
                              left: 60,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Credit Card',
                                    style: myUpuntoFont(
                                        Colors.grey[400], 20, FontWeight.w500),
                                  ),
                                  SizedBox(
                                    height: 5,
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
                                              fontSize: 15,
                                              fontWeight: FontWeight.w800),
                                        ),
                                      );
                                    },
                                  )
                                ],
                              )),
                          Positioned(
                            right: 12,
                            top: 20,
                            child: Image.asset('images/card.PNG'),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 20,
                    ),
                    Expanded(
                        flex: 1,
                        child: SizedBox(
                          height: 100,
                          child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            onPressed: () {
                              Navigator.of(context)
                                  .pushNamed(EditProfile.routeName);
                            },
                            color: Colors.grey[200],
                            child: Icon(
                              Icons.add,
                              size: 35,
                              color: darkColor,
                            ),
                          ),
                        )),
                  ],
                )),
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
