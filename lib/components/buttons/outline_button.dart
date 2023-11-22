import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pillowtalk/main.dart';

import '../../constants/colors.dart';

Widget customOutlineButton(
    {String? title,
    String? assetName,
    double? height,
    double? width,
    double? widthbox,
    Widget widget = const Center(),
    bool isClick = false,
    required BuildContext context,
    void Function()? onPress}) {
      mq = MediaQuery.of(context).size;
  return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: BorderSide(width: 1.0, color: secondaryColor.withOpacity(0.5)),
      ),
      onPressed: onPress,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: mq.width*0.02),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title!,
              style: TextStyle(
                fontSize: mq.width*0.035,
                  color: secondaryColor, fontWeight: FontWeight.w500),
            ),
            SizedBox(
              width: widthbox,
            ),
            isClick ? widget :
            SvgPicture.asset(
              assetName!,
              width: width,
              height: height,
            ),
          ],
        ),
      ));
}
