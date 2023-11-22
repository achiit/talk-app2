import 'package:flutter/material.dart';
import 'package:pillowtalk/main.dart';

import '../constants/colors.dart';


class OnBoard {
  final String image, text;

  OnBoard({
    required this.image,
    required this.text,
  });
}

class OnboardContent extends StatelessWidget {
  const OnboardContent({
    super.key,
    required this.image,
    required this.text,
  });

  final String image, text;

  @override
  Widget build(BuildContext context) {
    mq =  MediaQuery.of(context).size;
    return SizedBox(
      height: mq.height*0.86,
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(
            height: mq.height*0.08,
          ),
          Container(
            // color: primaryColor,
            child: Image.asset(image, fit: BoxFit.cover,height: mq.height*0.65,)),
          // SizedBox(
          //   height: mq.height*0.06,
          // ),
          const Expanded(child: SizedBox(),),
          Container(
            // color: primaryColor,
            margin: EdgeInsets.symmetric(horizontal: mq.width*0.2),
            child: Text(
              text,
              style: TextStyle(
                fontSize: mq.width*0.052,
                fontFamily: 'Montserrat',
                fontWeight: FontWeight.w500
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(
            height: mq.height*0.05,
          )
        ],
      ),
    );
  }
}
