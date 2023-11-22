import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pillowtalk/constants/colors.dart';
import 'package:pillowtalk/main.dart';
import 'package:pillowtalk/views/home/home.dart';
import 'package:velocity_x/velocity_x.dart';

import '../components/buttons/outline_button.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              //Get.back(result: () => const Home());
            },
            icon: SvgPicture.asset(
              "assets/icons/cross.svg",
            )),
        backgroundColor: backgroundColor,
        elevation: 0,
      ),
      body: Column(
        children: [
          Center(
              child: Image.asset(
            "assets/illustration3.png",
            width: mq.width * 0.45,
          )),
          Text(
            'Passion is high',
            style: TextStyle(
                fontSize: mq.width * 0.045,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: mq.width * 0.015,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              "Continue the conversation and ignite the sparks with premium intimacy card packs.",
              style: TextStyle(
                  fontSize: mq.width * 0.032,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: mq.width * 0.04,
          ),
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
                color: backgroundColor,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: yellowColor),
                boxShadow: const [
                  BoxShadow(color: lightColor, blurRadius: 10.0)
                ]),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: mq.width * 0.03, horizontal: mq.width * 0.05),
              child: Column(
                children: [
                  Text(
                    "Subscription perks",
                    style: TextStyle(
                        color: secondaryColor,
                        fontSize: mq.width * 0.04,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: mq.width * 0.02,
                  ),
                  Text(
                    "All Present and future Levels",
                    style: TextStyle(
                        fontFamily: 'Montserrat',
                        fontSize: mq.width * 0.032,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: mq.width * 0.02,
                  ),
                  Text(
                    "New levels everymonth",
                    style: TextStyle(
                        fontSize: mq.width * 0.032,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: mq.width * 0.02,
                  ),
                  Text(
                    "Complete Ad-free experience",
                    style: TextStyle(
                        fontSize: mq.width * 0.032,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: mq.width * 0.03,
                  ),
                  Text(
                    "Purchases apply to both users",
                    style: TextStyle(
                        fontSize: mq.width * 0.032,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: mq.width * 0.02,
                  ),
                  const Text(
                    "Access to all premimium features in the future",
                    style: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: mq.width * 0.02,
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                        horizontal: mq.width * 0.02, vertical: mq.width * 0.02),
                    decoration: BoxDecoration(
                        color: Colors.lightBlue[100],
                        borderRadius: BorderRadius.circular(2)),
                    child: const Text(
                      "Share to partner",
                      style: TextStyle(
                          fontFamily: 'Roboto', fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: mq.width * 0.02,
                  ),
                  customOutlineButton(
                    context: context,
                    title: "\$ BILLED YEARLY (BEST VALUE)",
                    assetName: "assets/icons/arrow.svg",
                    widthbox: 8,
                    onPress: () {},
                  ),
                  SizedBox(
                    height: mq.width * 0.02,
                  ),
                  customOutlineButton(
                    context: context,
                    title: "\$Y BILLED MONTHLY",
                    assetName: "assets/icons/arrow.svg",
                    widthbox: 8,
                    onPress: () {},
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(
          //   height: MediaQuery.of(context).size.height * 0.1,
          // ),
        ],
      ),
    );
  }
}
