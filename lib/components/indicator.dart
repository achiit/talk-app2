import 'package:flutter/material.dart';
import 'package:pillowtalk/constants/colors.dart';

Widget indicatorContainer(double top, double bottom, double opacity) {
  return Container(
    height: 60,
    padding: EdgeInsets.only(top: top, bottom: bottom),
    child: Container(
      decoration: BoxDecoration(
          color: lightColor, borderRadius: BorderRadius.circular(16)),
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 300),
        opacity: opacity,
        child: Container(
          width: 9,
          decoration: BoxDecoration(
              color: primaryColor, borderRadius: BorderRadius.circular(16)),
        ),
      ),
    ),
  );
}
