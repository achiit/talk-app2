import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:pillowtalk/components/chat_cards/blue_chat.dart';
import 'package:pillowtalk/components/chat_cards/grey_chat.dart';
import 'package:pillowtalk/constants/colors.dart';
import 'package:pillowtalk/controllers/audioController.dart';
import 'package:pillowtalk/controllers/controllers.dart';
import 'package:pillowtalk/models/message_model.dart';
import 'package:pillowtalk/services/chat_services.dart';
import 'package:pillowtalk/views/home/home.dart';
import 'package:pillowtalk/views/home/imagePreviewScreen.dart';
import 'package:pillowtalk/views/home/show_image.dart';
import 'package:pillowtalk/widgets/chatkeyboard.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:voice_message_package/voice_message_package.dart';

class MessageScreen extends StatefulWidget {
  final String currentUserUid;
  final String partnerUid;

  MessageScreen({
    required this.currentUserUid,
    required this.partnerUid,
  });

  @override
  _MessageScreenState createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  final TextEditingController _messageController = TextEditingController();
  int messagecount = 1;
  String x = "";
  AudioController audioController = Get.put(AudioController());
  AudioPlayer audioPlayer = AudioPlayer();

  @override
  Widget build(BuildContext context) {
    Size mq = MediaQuery.of(context).size;
    var controller = Get.put(ChatController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              Get.offAll(
                  () => Home(
                      myUID: widget.currentUserUid,
                      partnerUID: widget.partnerUid),
                  transition: Transition.leftToRightWithFade,
                  duration: const Duration(milliseconds: 200));
            },
            icon: const Icon(
              Icons.arrow_back,
              color: darkColor,
              size: 28,
            )),
        title: Container(
          // color: primaryColor,
          width: mq.width * 0.4,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'My bunny 🐇',
                style: TextStyle(
                    fontFamily: 'Univers',
                    fontWeight: FontWeight.w500,
                    fontSize: mq.width * 0.045),
              ),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset('assets/icons/online_indicator.svg'),
                    8.widthBox,
                    Text(
                      'Online',
                      style: TextStyle(
                          fontFamily: 'Univers',
                          fontWeight: FontWeight.w300,
                          fontSize: mq.width * 0.035),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        backgroundColor: backgroundColor,
        forceMaterialTransparency: true,
        elevation: 0,
      ),
      body: SafeArea(
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Column(
            children: [
              Expanded(
                child: StreamBuilder<List<Message>>(
                  stream: ChatServices()
                      .getMessages(widget.currentUserUid, widget.partnerUid),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting &&
                        !snapshot.hasData) {
                      return Center(
                        child: SizedBox(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child:
                            Text('Error loading messages: ${snapshot.error}'),
                      );
                    } else {
                      List<Message> messages = snapshot.data ?? [];

                      if (messages.isEmpty) {
                        return Center(
                          child: Text('Write your first message!'),
                        );
                      }
                      return Column(
                        children: [
                          Expanded(
                              child: ListView.builder(
                            reverse: true,
                            itemCount: messages.length,
                            itemBuilder: (context, index) {
                              if (index == 0 && messagecount % 5 == 0) {
                                // Display streak message
                                return ChatServices()
                                    .buildStreakMessage(messagecount);
                              } else {
                                Message message;
                                if (messagecount % 5 == 0) {
                                  // Adjust index when displaying streak message
                                  message = messages[index - 1];
                                } else {
                                  message = messages[index];
                                }

                                if (message.imgUrl.isNotEmpty &&
                                    message.content.isEmpty &&
                                    message.audioUrl.isEmpty) {
                                  print("the image is here");
                                  print(
                                      "the audiourl is here ${message.audioUrl}");
                                  // Display container with image
                                  return message.senderId ==
                                          widget.currentUserUid
                                      ? GestureDetector(
                                          onTap: () {
                                            Get.to(() => ShowImageScreen(
                                                imageFile: message.imgUrl));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.end,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.7,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.3,
                                                      constraints:
                                                          BoxConstraints(
                                                              maxWidth: 300),
                                                      padding: EdgeInsets.all(
                                                          mq.width * 0.01),
                                                      margin: EdgeInsets.only(
                                                          right:
                                                              mq.width * 0.04),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Color(0xffc9e5fc),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            image:
                                                                DecorationImage(
                                                              image: NetworkImage(
                                                                  message
                                                                      .imgUrl),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                    const CircleAvatar(
                                                      radius: 18,
                                                      backgroundImage:
                                                          AssetImage(
                                                              "assets/man.png"),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Text(
                                                    DateFormat('HH:mm').format(
                                                        message.timestamp
                                                            .toDate()),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color:
                                                          Colors.grey.shade700,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            Get.to(() => ShowImageScreen(
                                                imageFile: message.imgUrl));
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Row(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.end,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              right: 12.0),
                                                      child: const CircleAvatar(
                                                        radius: 18,
                                                        backgroundImage: AssetImage(
                                                            "assets/women.png"),
                                                      ),
                                                    ),
                                                    Container(
                                                      width:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .width *
                                                              0.7,
                                                      height:
                                                          MediaQuery.of(context)
                                                                  .size
                                                                  .height *
                                                              0.3,
                                                      constraints:
                                                          BoxConstraints(
                                                              maxWidth: 300),
                                                      padding: EdgeInsets.all(
                                                          mq.width * 0.01),
                                                      margin: EdgeInsets.only(
                                                          right:
                                                              mq.width * 0.04),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.grey[400]!,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10),
                                                        ),
                                                      ),
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(8.0),
                                                        child: Container(
                                                          decoration:
                                                              BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            image:
                                                                DecorationImage(
                                                              image: NetworkImage(
                                                                  message
                                                                      .imgUrl),
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 8.0),
                                                  child: Text(
                                                    DateFormat('HH:mm').format(
                                                        message.timestamp
                                                            .toDate()),
                                                    style: TextStyle(
                                                      fontSize: 12,
                                                      color: Colors.grey,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        );
                                }
                                /* else if (message.audioUrl.isNotEmpty &&
                                    message.content.isEmpty &&
                                    message.imgUrl.isEmpty) {
                                  Text("hello this is audio ");
                                }  */
                                else if (message.audioUrl.isNotEmpty &&
                                    message.content.isEmpty &&
                                    message.imgUrl.isEmpty) {
                                  // Display text indicating audio
                                  return message.senderId ==
                                          widget.currentUserUid
                                      ? Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              VoiceMessage(
                                                contactBgColor: Colors.white,
                                                meBgColor: Color(0xffc9e5fc),
                                                audioSrc: message.audioUrl,
                                                played:
                                                    false, // To show played badge or not.
                                                me: true, // Set message side.
                                                onPlay:
                                                    () {}, // Do something when voice played.
                                              ),
                                              Column(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 12.0),
                                                    child: const CircleAvatar(
                                                      radius: 18,
                                                      backgroundImage:
                                                          AssetImage(
                                                              "assets/man.png"),
                                                    ),
                                                  ),
                                                  Text(
                                                    DateFormat('HH:mm').format(
                                                        message.timestamp
                                                            .toDate()),
                                                    style: TextStyle(
                                                      fontSize: 11,
                                                      color:
                                                          Colors.grey.shade700,
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                right: 12.0),
                                                        child:
                                                            const CircleAvatar(
                                                          radius: 18,
                                                          backgroundImage:
                                                              AssetImage(
                                                                  "assets/women.png"),
                                                        ),
                                                      ),
                                                      Text(
                                                        DateFormat('HH:mm')
                                                            .format(message
                                                                .timestamp
                                                                .toDate()),
                                                        style: const TextStyle(
                                                          fontSize: 11,
                                                          color: Colors.grey,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                  VoiceMessage(
                                                    me: message.senderId ==
                                                        widget.currentUserUid,
                                                    contactBgColor:
                                                        Colors.grey[400]!,
                                                    // mePlayIconColor:
                                                    //     Colors.black,
                                                    contactFgColor: Colors
                                                        .black, //color of the duration
                                                    contactPlayIconColor:
                                                        Colors.black,
                                                    contactCircleColor:
                                                        Colors.white,
                                                    contactPlayIconBgColor:
                                                        Colors.white,
                                                    radius: 10,
                                                    showDuration: false,
                                                    audioSrc: message.audioUrl,
                                                    played:
                                                        false, // To show played badge or not.
                                                    //me: true, // Set message side.
                                                    onPlay:
                                                        () {}, // Do something when voice played.
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        );
                                } else {
                                  print(
                                      "the audiourl is here ${message.audioUrl}");
                                  return message.senderId ==
                                          widget.currentUserUid
                                      ? Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  Flexible(
                                                    child: Container(
                                                      constraints: BoxConstraints(
                                                          maxWidth: MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width *
                                                              0.6),
                                                      padding: EdgeInsets.all(
                                                          mq.width * 0.04),
                                                      margin: EdgeInsets.only(
                                                          left:
                                                              mq.width * 0.04),
                                                      decoration: BoxDecoration(
                                                        color: const Color(
                                                            0xffc9e5fc),
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          bottomLeft:
                                                              Radius.circular(
                                                                  10),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        message.content,
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 12.0),
                                                    child: const CircleAvatar(
                                                      radius: 18,
                                                      backgroundImage:
                                                          AssetImage(
                                                              "assets/man.png"),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 2.0),
                                                child: Text(
                                                  DateFormat('HH:mm').format(
                                                      message.timestamp
                                                          .toDate()),
                                                  style: TextStyle(
                                                    fontSize: 11,
                                                    color: Colors.grey.shade700,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        )
                                      : Padding(
                                          padding: const EdgeInsets.all(12.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  const CircleAvatar(
                                                    radius: 18,
                                                    backgroundImage: AssetImage(
                                                        "assets/women.png"),
                                                  ),
                                                  Flexible(
                                                    child: Container(
                                                      constraints:
                                                          BoxConstraints(
                                                              maxWidth:
                                                                  mq.width *
                                                                      0.6),
                                                      padding: EdgeInsets.all(
                                                          mq.width * 0.04),
                                                      margin: EdgeInsets.only(
                                                          left:
                                                              mq.width * 0.04),
                                                      decoration: BoxDecoration(
                                                        color:
                                                            Colors.grey[400]!,
                                                        borderRadius:
                                                            const BorderRadius
                                                                .only(
                                                          topLeft:
                                                              Radius.circular(
                                                                  10),
                                                          topRight:
                                                              Radius.circular(
                                                                  10),
                                                          bottomRight:
                                                              Radius.circular(
                                                                  10),
                                                        ),
                                                      ),
                                                      child: Text(
                                                        message.content,
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                  right: 12.0,
                                                ),
                                                child: Text(
                                                  DateFormat('HH:mm').format(
                                                      message.timestamp
                                                          .toDate()),
                                                  style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.grey,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                }
                              }
                            },
                          )),
                        ],
                      );
                    }
                  },
                ),
              ),
              ChatInput(
                currentUserUid: widget.currentUserUid,
                partnerUid: widget.partnerUid,
                messageController: _messageController,
                controller: controller,
                onTap: () {
                  ChatServices().sendMessage(
                    widget.currentUserUid,
                    widget.partnerUid,
                    content: _messageController.text,
                  );
                  messagecount++;
                  print(" the total messages are $messagecount");

                  _messageController.clear();
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
