import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pillowtalk/components/notification_card.dart';
import 'package:pillowtalk/constants/colors.dart';
import 'package:velocity_x/velocity_x.dart';

import 'home.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: AppBar(
              leading: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.arrow_back, color: darkColor, size: 28,)
                  ),
              backgroundColor: backgroundColor,
              elevation: 0,
            ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Today',
                style: TextStyle(
              fontSize: 20,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500
            ),
              ),
            ),
            16.heightBox,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  NotificationCard(),
                  Divider(color: secondaryColor,thickness: 1,indent: 5, endIndent: 5,),
                  NotificationCard(),
                  Divider(color: secondaryColor,thickness: 1,indent: 5, endIndent: 5,),
                  NotificationCard(),
                  Divider(color: secondaryColor,thickness: 1,indent: 5, endIndent: 5,),
                  NotificationCard(),
                ],
              ),
            ),
            const Divider(color: secondaryColor,thickness: 1),
            12.heightBox,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'Yesterday',
                style: TextStyle(
              fontSize: 20,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500
            ),
              ),
            ),
            16.heightBox,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  NotificationCard(),
                  Divider(color: secondaryColor,thickness: 1,indent: 5, endIndent: 5,),
                  NotificationCard(),
                  Divider(color: secondaryColor,thickness: 1,indent: 5, endIndent: 5,),
                  NotificationCard(),
                  Divider(color: secondaryColor,thickness: 1,indent: 5, endIndent: 5,),
                  NotificationCard(),
                ],
              ),
            ),
            const Divider(color: secondaryColor,thickness: 1),
            12.heightBox,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                'August 15',
                style: TextStyle(
              fontSize: 20,
              fontFamily: 'Montserrat',
              fontWeight: FontWeight.w500
            ),
              ),
            ),
            16.heightBox,
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 12),
              child: Column(
                children: [
                  NotificationCard(),
                  Divider(color: secondaryColor,thickness: 1,indent: 5, endIndent: 5,),
                  NotificationCard(),
                  Divider(color: secondaryColor,thickness: 1,indent: 5, endIndent: 5,),
                  NotificationCard(),
                  Divider(color: secondaryColor,thickness: 1,indent: 5, endIndent: 5,),
                  NotificationCard(),
                ],
              ),
            ),
            const Divider(color: secondaryColor,thickness: 1),
          ],
        ),
      ),
    );
  }
}