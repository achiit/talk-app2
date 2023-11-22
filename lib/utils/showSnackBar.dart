import 'package:flutter/material.dart';
import 'package:pillowtalk/constants/colors.dart';

void showSnackBar(BuildContext context, String text) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      behavior: SnackBarBehavior.floating,
      backgroundColor: secondaryColor,
      content: Text(
        text,
        style: TextStyle(
            fontSize: 14,
            fontFamily: 'Montserrat',
            fontWeight: FontWeight.w500),
      )));
}
