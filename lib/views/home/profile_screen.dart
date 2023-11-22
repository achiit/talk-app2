import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pillowtalk/components/drawer_widget.dart';
import 'package:pillowtalk/constants/colors.dart';
import 'package:pillowtalk/main.dart';
import 'package:pillowtalk/views/payment_screen.dart';
import 'package:velocity_x/velocity_x.dart';

import 'discover_screen.dart';
import 'home.dart';
import 'message_screen.dart';
import 'notification_screen.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Setting',
                style: TextStyle(
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500,
                    fontSize: mq.width * 0.05),
              ),
            ),
            SizedBox(
              height: mq.width * 0.05,
            ),
            GestureDetector(
              onTap: () {
                Get.to(() => const PaymentScreen());
              },
              child: Container(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Image.asset('assets/premiumCard.png'),
                ),
              ),
            ),
            // SizedBox(
            //   height: mq.width * 0.05,
            // ),
            Expanded(child: Container()),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Container(
                decoration: BoxDecoration(
                    color: backgroundColor,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: lightColor),
                    boxShadow: const [
                      BoxShadow(color: lightColor, blurRadius: 10.0)
                    ]),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: mq.width * 0.08, horizontal: mq.width * 0.12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/people.svg'),
                          16.widthBox,
                          Text(
                            "Profile setting",
                            style: TextStyle(
                                // color: secondaryColor,
                                fontFamily: 'Montserrat',
                                fontSize: mq.width * 0.045,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: mq.width * 0.04,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/feedback.svg'),
                          16.widthBox,
                          Text(
                            "Feedback",
                            style: TextStyle(
                                // color: secondaryColor,
                                fontFamily: 'Montserrat',
                                fontSize: mq.width * 0.045,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: mq.width * 0.04,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/account_box.svg'),
                          16.widthBox,
                          Text(
                            "Account setting",
                            style: TextStyle(
                                // color: secondaryColor,
                                fontFamily: 'Montserrat',
                                fontSize: mq.width * 0.045,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: mq.width * 0.04,
                      ),
                      Row(children: [
                        SvgPicture.asset("assets/icons/drawer/help.svg"),
                        16.widthBox,
                        Text(
                          "Help",
                          style: TextStyle(
                              // color: secondaryColor,
                              fontSize: mq.width * 0.045,
                              fontFamily: 'Montserrat',
                              fontWeight: FontWeight.w500),
                        ),
                      ]),
                      SizedBox(
                        height: mq.width * 0.04,
                      ),
                      Text(
                        'Privacy policy',
                        style: TextStyle(
                            fontSize: mq.width * 0.035,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline),
                      ),
                      SizedBox(
                        height: mq.width * 0.04,
                      ),
                      Text(
                        'Terms of use',
                        style: TextStyle(
                            fontSize: mq.width * 0.035,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w400,
                            decoration: TextDecoration.underline),
                      ),
                      SizedBox(
                        height: mq.width * 0.2,
                      ),
                      Row(
                        children: [
                          SvgPicture.asset('assets/icons/public.svg'),
                          16.widthBox,
                          Text(
                            "V.1.101",
                            style: TextStyle(
                                // color: secondaryColor,
                                fontFamily: 'Montserrat',
                                fontSize: mq.width * 0.045,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(child: Container())
          ],
        ),
      ),
    );
  }
}
