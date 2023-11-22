// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pillowtalk/main.dart';
import 'indicator.dart';

class CustomIndicator extends StatefulWidget {
  final BuildContext context;
  final int progressIndex;
  const CustomIndicator({
    Key? key,
    required this.context,
    required this.progressIndex,
  }) : super(key: key);
  @override
  State<CustomIndicator> createState() => _CustomIndicatorState();
}
class _CustomIndicatorState extends State<CustomIndicator> {
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Container(
      height: 60,
      width: 280,
      // color: primaryColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          indicatorContainer(21, 21, widget.progressIndex >= 7 ? 0.0 : 1.0,),
          indicatorContainer(14, 14, widget.progressIndex >= 6 ? 0.0 : 1.0,),
          indicatorContainer(14, 20, widget.progressIndex >= 6 ? 0.0 : 1.0,),
          indicatorContainer(20, 14, widget.progressIndex >= 5 ? 0.0 : 1.0,),
          indicatorContainer(14, 20, widget.progressIndex >= 5 ? 0.0 : 1.0,),
          indicatorContainer(20, 14, widget.progressIndex >= 4 ? 0.0 : 1.0,),
          indicatorContainer(14, 14, widget.progressIndex >= 4 ? 0.0 : 1.0,),
          indicatorContainer(14, 20, widget.progressIndex >= 3 ? 0.0 : 1.0,),
          indicatorContainer(20, 14, widget.progressIndex >= 3 ? 0.0 : 1.0,),
          indicatorContainer(14, 20, widget.progressIndex >= 2 ? 0.0 : 1.0,),
          indicatorContainer(14, 14, widget.progressIndex >= 2 ? 0.0 : 1.0,),
          indicatorContainer(20, 14, widget.progressIndex >= 2 ? 0.0 : 1.0,),
          indicatorContainer(14, 20, widget.progressIndex >= 1 ? 0.0 : 1.0,),
          indicatorContainer(20, 14, widget.progressIndex >= 1 ? 0.0 : 0.0,),
          indicatorContainer(14, 20, widget.progressIndex >= 1 ? 0.0 : 0.0,),
          indicatorContainer(20, 14, widget.progressIndex >= 2 ? 0.0 : 0.0,),
          indicatorContainer(21, 21, widget.progressIndex >= 1 ? 0.0 : 0.0,),
        ],
      ),
    );
  }
}
