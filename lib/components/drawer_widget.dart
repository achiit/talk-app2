import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:velocity_x/velocity_x.dart';

import '../constants/colors.dart';

Widget customDrawer() {
  return Drawer(
      shadowColor: backgroundColor,
      backgroundColor: backgroundColor,
      child: ListView(
        children: [
          DrawerHeader(
            child: Column(
              children: [
                30.heightBox,
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/drawer/follow.svg",
                      width: 24,
                      height: 24,
                    ),
                    8.widthBox,
                    const Text("Follow us on socials",
                        style: TextStyle(
                            color: secondaryColor,
                            fontSize: 16,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500)),
                  ],
                ),
                20.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SvgPicture.asset(
                      "assets/icons/drawer/Facebook.svg",
                      width: 32,
                    ),
                    20.widthBox,
                    Image.asset(
                      "assets/Instagram.png",
                      width: 32,
                    ),
                    20.widthBox,
                    SvgPicture.asset(
                      "assets/icons/drawer/Twitter.svg",
                      width: 32,
                    ),
                    20.widthBox,
                    SvgPicture.asset(
                      "assets/icons/drawer/Snapchat.svg",
                      width: 32,
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                Row(children: [
                  SvgPicture.asset("assets/icons/drawer/textsms.svg"),
                  12.widthBox,
                  const Text(
                    "Feedback",
                    style: TextStyle(
                        color: secondaryColor,
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500),
                  ),
                ]),
                20.heightBox,
                Row(children: [
                  SvgPicture.asset("assets/icons/drawer/help.svg"),
                  12.widthBox,
                  const Text(
                    "Help",
                    style: TextStyle(
                        color: secondaryColor,
                        fontSize: 16,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500),
                  ),
                ]),
              ],
            ),
          ),
        ],
      ));
}
