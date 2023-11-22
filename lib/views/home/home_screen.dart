import 'dart:math';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pillowtalk/components/custom_indicator.dart';
import 'package:pillowtalk/components/drawer_widget.dart';
import 'package:pillowtalk/constants/colors.dart';
import 'package:pillowtalk/constants/lists.dart';
import 'package:pillowtalk/main.dart';
import 'package:velocity_x/velocity_x.dart';

import 'message_screen.dart';

int currentIndex = 0;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

var cardAspectRatio = 2 / 3;
var widgetAspectRatio = cardAspectRatio * 1.55;

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  var isExpanded = false;
  var currentPage = cardImagesList.length - 1.0;
  @override
  Widget build(BuildContext context) {
    PageController controller =
        PageController(initialPage: cardImagesList.length - 1);
    controller.addListener(() {
      setState(() {
        currentPage = controller.page!;
        currentIndex == currentPage;
      });
    });
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Welcome, John & Jane",
              style: TextStyle(
                  fontSize: mq.width * 0.048,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500),
            ),
          ),
          SizedBox(
            height: mq.width * 0.02,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              "Pick a card",
              style: TextStyle(
                  fontSize: mq.width * 0.044,
                  color: greyColor,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500),
            ),
          ),
          // SizedBox(
          //   height: mq.height * 0.02,
          // ),
          12.heightBox,
          Expanded(
            flex: 16,
            child: Container(
              // color: primaryColor,
              // padding: EdgeInsets.symmetric(horizontal: 12),
              width: double.infinity,
              height: mq.height * 0.45,
              child: Stack(
                children: <Widget>[
                  CardScrollWidget(currentPage),
                  Positioned.fill(
                    child: PageView.builder(
                      itemCount: cardImagesList.length,
                      physics: ScrollPhysics(),
                      controller: controller,
                      reverse: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          // onTap: () {
                          //   Get.to(() => const MessageScreen(),
                          //       transition: Transition.rightToLeftWithFade,
                          //       duration: const Duration(milliseconds: 200));
                          // },
                          child: Container(
                            margin: EdgeInsets.only(right: mq.width * 0.375),
                            color: Colors.transparent,
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
          ),
          8.heightBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                cardStringsList[currentPage.round().toInt()],
                style: TextStyle(
                    fontSize: mq.width * 0.054,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500),
              ),
            ),
          ),
          8.heightBox,
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Container(
              // color: primaryColor,
              height: mq.width * 0.22,
              child: Text(descCardLlist[currentPage.round().toInt()],
                  style: TextStyle(
                      fontSize: mq.width * 0.038,
                      fontFamily: 'Univers',
                      fontWeight: FontWeight.w300)),
            ),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                // color: primaryColor,
                // height: mq.width * 0.22,
                // color: primaryColor,
                child: Row(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: const Text(
                          'Intimacy level',
                          style: TextStyle(
                              color: greyColor, fontFamily: 'Montserrat'),
                        )),
                    20.widthBox,
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        CustomIndicator(
                          context: context,
                          progressIndex: currentPage.round().toInt(),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Flexible(
                              flex: 1,
                              child: Container(),
                            ),
                            const Text(
                              '😉',
                              style: TextStyle(fontSize: 20),
                            ),
                            Flexible(
                              flex: 2,
                              child: Container(),
                            ),
                            const Text(
                              '👄',
                              style: TextStyle(fontSize: 20),
                            ),
                            Flexible(
                              flex: 2,
                              child: Container(),
                            ),
                            const Text(
                              '👀',
                              style: TextStyle(fontSize: 20),
                            ),
                            Flexible(
                              flex: 2,
                              child: Container(),
                            ),
                            const Text(
                              '😈',
                              style: TextStyle(fontSize: 20),
                            ),
                            Flexible(
                              flex: 1,
                              child: Container(),
                            ),
                          ],
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ],
          ),
          Spacer(
            flex: 1,
          )
        ],
      ),
    );
  }
}

class CardScrollWidget extends StatelessWidget {
  var currentPage;
  var padding = 0.0;
  var verticalInset = 30.0;
  CardScrollWidget(this.currentPage, {super.key});
  @override
  Widget build(BuildContext context) {
    // print(currentPage);
    return Container(
      // color: secondaryColor,
      child: LayoutBuilder(builder: (context, contraints) {
        var width = contraints.maxWidth;
        var height = contraints.maxHeight;

        var safeWidth = width - 2 * padding;
        var safeHeight = height - 2 * padding;

        var heightOfPrimaryCard = safeHeight;
        var widthOfPrimaryCard = heightOfPrimaryCard * cardAspectRatio;

        var primaryCardLeft = safeWidth - widthOfPrimaryCard;
        var horizontalInset = primaryCardLeft / 2;

        List<Widget>? cardList = [];

        for (var i = 0; i < cardImagesList.length; i++) {
          var delta = i - currentPage;
          bool isOnRight = delta > 0;

          var start = padding +
              max(
                  primaryCardLeft -
                      horizontalInset * -delta * (isOnRight ? 5 : 1),
                  0.0);

          var cardItem = Positioned.directional(
            top: padding + verticalInset * max(-delta, 0.0),
            bottom: padding + verticalInset * max(-delta, 0.0),
            start: start,
            textDirection: TextDirection.rtl,
            child: AspectRatio(
              aspectRatio: cardAspectRatio,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Image.asset(cardImagesList[i], fit: BoxFit.fill),
              ),
            ),
          );
          cardList.add(cardItem);
        }
        return Stack(
          children: cardList,
        );
      }),
    );
  }
}
