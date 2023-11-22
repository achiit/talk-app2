import 'package:flutter/material.dart';
import 'package:pillowtalk/constants/colors.dart';
import 'package:velocity_x/velocity_x.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Row(
        children: [
          const CircleAvatar(
            radius: 20,
            backgroundImage: AssetImage('assets/man.png'),
          ),
          20.widthBox,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RichText(
                  text: const TextSpan(children: [
                TextSpan(
                  text: 'My bunny 🐇 ',
                  style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Montserrat',
                      color: darkColor,
                      fontWeight: FontWeight.w600),
                ),
                TextSpan(
                  text: 'just send you a message',
                  style: TextStyle(
                      fontSize: 14,
                      color: darkColor,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500),
                )
              ])),
              4.heightBox,
              const Text(
                '15 minutes ago',
              )
            ],
          )
        ],
      ),
    );
  }
}
