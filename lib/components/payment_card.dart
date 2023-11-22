import 'package:flutter/material.dart';
import 'package:pillowtalk/constants/colors.dart';
import 'package:velocity_x/velocity_x.dart';
import 'buttons/outline_button.dart';

Widget paymentCard(
  BuildContext context
) {
  return Container(
    // padding: const EdgeInsets.all(8),
    decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: lightColor),
        boxShadow: const [BoxShadow(color: lightColor, blurRadius: 10.0)]),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
      child: Column(
        children: [
          const Text(
            "POPULAR",
            style: TextStyle(
                color: secondaryColor,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500),
          ),
          16.heightBox,
          const Text("5 Packs",
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w500)),
          16.heightBox,
          const Text(
            "\$1e/a",
            style: TextStyle(
                fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
          ),
          16.heightBox,
          Image.asset("assets/payment.png"),
          16.heightBox,
          Container(
            padding: const EdgeInsets.all(4),
            decoration: BoxDecoration(
                color: Colors.lightBlue[100],
                borderRadius: BorderRadius.circular(2)),
            child: const Text(
              "Saved 30%",
              style: TextStyle(
                fontFamily: 'Roboto',
                fontWeight: FontWeight.w500
              ),
            ),
          ),
          16.heightBox,
          customOutlineButton(
            context: context,
            title: "GET 5 FOR \$5",
            assetName: "assets/icons/arrow.svg",
            widthbox: 8,
            onPress: () {},
          )
        ],
      ),
    ),
  );
}
