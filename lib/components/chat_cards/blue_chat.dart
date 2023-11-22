import 'package:flutter/material.dart';
import '../../main.dart';

Widget blueMessage({BuildContext? context, String? text}) {
  mq = MediaQuery.of(context!).size;
  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Flexible(
          child: Container(
            padding: EdgeInsets.all(mq.width * 0.04),
            margin: EdgeInsets.only(
              right: mq.width * 0.04,
            ),
            decoration: BoxDecoration(
                color: Colors.blue[100],
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomLeft: Radius.circular(10))),
            child: Text(
              text!,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ),
        const CircleAvatar(
          radius: 18,
          backgroundImage: AssetImage("assets/man.png"),
        ),
      ],
    ),
  );
}
