import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../constants/colors.dart';

Widget customSignInOutlineButton(
    {String? title,
    String? assetName,
    double? height,
    double? width,
    double? widthbox,
    context,
    // double? startwidth,
    void Function()? onPress}) {

  return OutlinedButton(
      style: OutlinedButton.styleFrom(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        side: BorderSide(width: 1.0, color: secondaryColor.withOpacity(0.5)),
      ),
      onPressed: onPress,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(width: MediaQuery.of(context).size.height*0.07,),
            SvgPicture.asset(
              assetName!,
              width: width,
              height: height,
            ),
            SizedBox(
              width: widthbox,
            ),
            Text(
              title!,
              style: const TextStyle(
                fontFamily: 'Roboto',
                color: secondaryColor,
                fontWeight: FontWeight.w500
              ),
            ),
            const Spacer(flex: 1,),
            // SizedBox(width: MediaQuery.of(context).size.height*0.07,),

          ],
        ),
      ));
}
