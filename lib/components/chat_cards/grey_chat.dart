import 'package:flutter/material.dart';

import '../../main.dart';

Widget greyMessage({context, String? text}){

  mq = MediaQuery.of(context).size;

  return Padding(
    padding: const EdgeInsets.all(12.0),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        const CircleAvatar(
          radius: 18,
          backgroundImage: AssetImage("assets/women.png"),
        ),
        Flexible(
          child: Container(
            padding: EdgeInsets.all(mq.width*0.04),
            margin: EdgeInsets.only(left: mq.width*0.04,),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(10), topRight: Radius.circular(10), bottomRight: Radius.circular(10))
            ),
            child: Text(
              text!,
              style: const TextStyle(
                 fontSize: 15,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}