import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pillowtalk/main.dart';

import '../constants/colors.dart';

Widget codeTextField({context}) {
  mq = MediaQuery.of(context).size;
  return Container(
    // color: primaryColor,
    height: mq.width * 0.16,
    width: mq.width * 0.14,
    child: Center(
      child: TextField(
        autofocus: true,
        cursorColor: secondaryColor,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        decoration: InputDecoration(
          isDense: true,
          focusColor: secondaryColor,
          hintText: ".",
          hintStyle: TextStyle(
              fontSize: mq.width * 0.13,
              // fontSize: 60,
              fontWeight: FontWeight.w900,
              color: lightColor),
        ),
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        inputFormatters: [
          LengthLimitingTextInputFormatter(1),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    ),
  );
}
