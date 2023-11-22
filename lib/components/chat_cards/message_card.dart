import 'dart:io';

import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:pillowtalk/controllers/controllers.dart';
import 'package:pillowtalk/views/home/home.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../../main.dart';
import '../../constants/colors.dart';
import 'blue_chat.dart';
import 'grey_chat.dart';
import '../buttons/outline_button.dart';

class MessageCard extends StatefulWidget {
  const MessageCard({super.key});

  @override
  State<MessageCard> createState() => _MessageCardState();
}

// WillPopScope(
//       onWillPop: () {
//         if (controller.isEmojiVisible.value) {
//           controller.isEmojiVisible.value = false;
//         } else {
//           // Navigator.pop(context);
//           // Get.to(()=> Home());
//         }
//         return Future.value(false);
//       },
class _MessageCardState extends State<MessageCard> {
  var controller = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Stack(
                      children: [
                        Image.asset("assets/tarot1.png"),
                        Positioned(
                          left: mq.width * 0.2,
                          top: mq.width * 0.16,
                          child: Container(
                            // color: primaryColor,
                            width: mq.width * 0.6,
                            child: Text(
                              "“What is your best memory of me?”",
                              style: TextStyle(
                                  color: whiteColor, fontSize: mq.width * 0.06),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  16.heightBox,
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      "Type your answer here. When your partner does the same, you both will see each other response and can continue the conversation. Swipe left to skip this prompt and draw another card.",
                      style: TextStyle(
                        height: 1.5,
                      ),
                    ),
                  ),
                  greyMessage(context: context, text: "Hello"),
                  blueMessage(context: context, text: "Hey!"),
                  greyMessage(
                      context: context,
                      text:
                          "It was the first time we met at Kevin's birthday party. You looked stunning in that red dress. I was shy haha."),

                  16.heightBox,
                  Text(
                    "🎉 5 messages streak. Keep it up",
                    style: TextStyle(
                        color: Colors.grey[700], fontWeight: FontWeight.w300),
                  ),
                  16.heightBox,
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Stack(
                      children: [
                        Image.asset("assets/tarot2.png"),
                        Positioned(
                          left: mq.width * 0.18,
                          top: mq.width * 0.1,
                          child: Container(
                            // color: primaryColor,
                            width: mq.width * 0.65,
                            child: Text(
                              "“What would you do first if you woke up as your partner?”",
                              style: TextStyle(
                                  color: whiteColor, fontSize: mq.width * 0.06),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  16.heightBox,
                  Text(
                    "🎉 10 messages streak. Keep it up",
                    style: TextStyle(
                        color: Colors.grey[700], fontWeight: FontWeight.w300),
                  ),
                  16.heightBox,
                  // Padding(
                  //   padding: const EdgeInsets.all(8.0),
                  //   child: Container(
                  //     // padding: const EdgeInsets.all(8),
                  //     decoration: BoxDecoration(
                  //         color: backgroundColor,
                  //         borderRadius: BorderRadius.circular(20),
                  //         border: Border.all(color: yellowColor),
                  //         boxShadow: const [
                  //           BoxShadow(color: lightColor, blurRadius: 10.0)
                  //         ]),
                  //     child: Padding(
                  //       padding: EdgeInsets.symmetric(
                  //           vertical: mq.width * 0.05,
                  //           horizontal: mq.width * 0.05),
                  //       child: Column(
                  //         children: [
                  //           Text(
                  //             "Subscription perks",
                  //             style: TextStyle(
                  //                 color: secondaryColor,
                  //                 fontSize: mq.width * 0.04,
                  //                 fontFamily: 'Montserrat',
                  //                 fontWeight: FontWeight.w500),
                  //           ),
                  //           SizedBox(
                  //             height: mq.width * 0.03,
                  //           ),
                  //           Text(
                  //             "All Present and future Levels",
                  //             style: TextStyle(
                  //                 fontFamily: 'Montserrat',
                  //                 fontSize: mq.width * 0.032,
                  //                 fontWeight: FontWeight.w500),
                  //           ),
                  //           SizedBox(
                  //             height: mq.width * 0.03,
                  //           ),
                  //           Text(
                  //             "New levels everymonth",
                  //             style: TextStyle(
                  //                 fontSize: mq.width * 0.032,
                  //                 fontFamily: 'Montserrat',
                  //                 fontWeight: FontWeight.w500),
                  //           ),
                  //           SizedBox(
                  //             height: mq.width * 0.03,
                  //           ),
                  //           Text(
                  //             "Complete Ad-free experience",
                  //             style: TextStyle(
                  //                 fontSize: mq.width * 0.032,
                  //                 fontFamily: 'Montserrat',
                  //                 fontWeight: FontWeight.w500),
                  //           ),
                  //           SizedBox(
                  //             height: mq.width * 0.03,
                  //           ),
                  //           Text(
                  //             "Purchases apply to both users",
                  //             style: TextStyle(
                  //                 fontSize: mq.width * 0.032,
                  //                 fontFamily: 'Montserrat',
                  //                 fontWeight: FontWeight.w500),
                  //           ),
                  //           // 16.heightBox,
                  //           // const Text(
                  //           //   "Access to all premimium features in the future",
                  //           //   style: TextStyle(
                  //           //       fontFamily: 'Montserrat',
                  //           //       fontWeight: FontWeight.w500),
                  //           // ),
                  //           // 16.heightBox,
                  //           // Container(
                  //           //   padding: const EdgeInsets.symmetric(
                  //           //       horizontal: 12, vertical: 8),
                  //           //   decoration: BoxDecoration(
                  //           //       color: Colors.lightBlue[100],
                  //           //       borderRadius: BorderRadius.circular(2)),
                  //           //   child: const Text(
                  //           //     "Share to partner",
                  //           //     style: TextStyle(
                  //           //         fontFamily: 'Roboto',
                  //           //         fontWeight: FontWeight.w500),
                  //           //   ),
                  //           // ),
                  //           SizedBox(
                  //             height: mq.width * 0.03,
                  //           ),
                  //           customOutlineButton(
                  //             context: context,
                  //             title: "\$ BILLED YEARLY" /*  (BEST VALUE) */,
                  //             assetName: "assets/icons/arrow.svg",
                  //             widthbox: 8,
                  //             onPress: () {},
                  //           ),
                  //           SizedBox(
                  //             height: mq.width * 0.03,
                  //           ),
                  //           customOutlineButton(
                  //             context: context,
                  //             title: "\$Y BILLED MONTHLY",
                  //             assetName: "assets/icons/arrow.svg",
                  //             widthbox: 8,
                  //             onPress: () {},
                  //           ),
                  //         ],
                  //       ),
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
          ),
          //chatInput(),
          Obx(
            () => Offstage(
              offstage: !controller.isEmojiVisible.value,
              child: SizedBox(
                height: mq.height * 0.34,
                child: EmojiPicker(
                  onEmojiSelected: (category, emoji) {
                    controller.textEditingController.text =
                        controller.textEditingController.text + emoji.emoji;
                  },
                  config: Config(
                    columns: 7,
                    emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                    verticalSpacing: 0,
                    horizontalSpacing: 0,
                    gridPadding: EdgeInsets.zero,
                    initCategory: Category.RECENT,
                    bgColor: const Color(0xFFF2F2F2),
                    indicatorColor: Colors.blue,
                    iconColor: Colors.grey,
                    iconColorSelected: Colors.blue,
                    backspaceColor: Colors.blue,
                    skinToneDialogBgColor: Colors.white,
                    skinToneIndicatorColor: Colors.grey,
                    enableSkinTones: true,
                    recentTabBehavior: RecentTabBehavior.RECENT,
                    recentsLimit: 28,
                    noRecents: const Text(
                      'No Recents',
                      style: TextStyle(fontSize: 20, color: Colors.black26),
                      textAlign: TextAlign.center,
                    ), // Needs to be const Widget
                    loadingIndicator:
                        const SizedBox.shrink(), // Needs to be const Widget
                    tabIndicatorAnimDuration: kTabScrollDuration,
                    categoryIcons: const CategoryIcons(),
                    buttonMode: ButtonMode.MATERIAL,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget chatInput() {
    return Container(
      padding: EdgeInsets.symmetric(
          horizontal: 12, vertical: MediaQuery.of(context).size.height * 0.01),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          8.widthBox,
          InkWell(
            onTap: () {},
            child: Container(
              // color: secondaryColor,
              height: 40,
              child: SvgPicture.asset('assets/icons/gallery.svg'),
            ),
          ),
          20.widthBox,
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(26),
                color: Colors.grey[50],
                border: Border.all(color: Colors.grey),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      focusNode: controller.focusNode,
                      controller: controller.textEditingController,
                      keyboardType: TextInputType.multiline,
                      maxLines: null,
                      decoration: const InputDecoration(
                          isDense: true,
                          hintText: "Aa",
                          border: InputBorder.none),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      controller.isEmojiVisible.value =
                          !controller.isEmojiVisible.value;

                      controller.focusNode.unfocus();
                      controller.focusNode.canRequestFocus = true;
                    },
                    child: Container(
                      height: 30,
                      width: 40,
                      // color: secondaryColor,
                      child: const Center(
                          child: Text(
                        '😃',
                        style: TextStyle(fontSize: 20),
                      )),
                    ),
                  )
                  // Container(
                  //   height: 30,
                  //   color: secondaryColor,
                  //   child: TextButton(onPressed: (){}, child: Text('😃',style: TextStyle(fontSize: 20),)))
                  // Container(
                  //   height: 10,
                  //   child: Image.asset('assets/icons/emoji.svg'),
                  // )
                ],
              ),
            ),
          ),
          20.widthBox,
          InkWell(
            onTap: () {},
            child: Container(
              // color: secondaryColor,
              height: 40,
              child: SvgPicture.asset('assets/icons/photo_camera.svg'),
            ),
          ),
          10.widthBox,
          InkWell(
            onTap: () {},
            child: Container(
              // color: secondaryColor,
              height: 40,
              child: SvgPicture.asset('assets/icons/mic.svg'),
            ),
          ),

          // MaterialButton(
          //   onPressed: () {},
          //   padding:
          //       const EdgeInsets.only(right: 5, left: 10, top: 10, bottom: 10),
          //   shape: const CircleBorder(),
          //   color: Colors.redAccent,
          //   minWidth: 0,
          //   child: const Icon(
          //     Icons.send_rounded,
          //     color: Colors.white,
          //   ),
          // )
        ],
      ),
    );
  }
}
