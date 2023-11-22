import 'dart:io';
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pillowtalk/controllers/audioController.dart';
import 'package:pillowtalk/controllers/chatcontroller.dart';
import 'package:pillowtalk/services/chat_services.dart';
import 'package:pillowtalk/views/home/imagePreviewScreen.dart';
import 'package:social_media_recorder/audio_encoder_type.dart';
import 'package:social_media_recorder/screen/social_media_recorder.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:just_audio/just_audio.dart' as audioo;

class ChatInput extends StatefulWidget {
  TextEditingController messageController = TextEditingController();
  void Function()? onTap;
  var controller;
  String currentUserUid;
  String partnerUid;

  ChatInput({
    required this.messageController,
    required this.currentUserUid,
    required this.partnerUid,
    required this.controller,
    required this.onTap,
  });

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  String audioURL = "";
  final picker = ImagePicker();
  File? _selectedImage;
  bool isTextEmpty = true;
  AudioController audioController = Get.put(AudioController());
  audioo.AudioPlayer _audioPlayer = audioo.AudioPlayer();
  bool isRecording = false;

  Future<void> _openGallery(BuildContext context) async {
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImagePreviewScreen(
            currentId: widget.currentUserUid,
            partnerId: widget.partnerUid,
            imageFile: _selectedImage!,
          ),
        ),
      );
    }
  }

  ChatProvider chatProvider = ChatProvider(
    firebaseFirestore: FirebaseFirestore.instance,
    firebaseStorage: FirebaseStorage.instance,
  );

  uploadAudio(File soundFile) async {
    print("starting to upload the audio file");
    UploadTask uploadTask = chatProvider.uploadAudio(
      soundFile,
      "audio/${DateTime.now().millisecondsSinceEpoch.toString()}.mp3",
    );
    try {
      print(
          "starting to upload the audio file entering the phase of uploading the audio");
      TaskSnapshot snapshot = await uploadTask;
      audioURL = await snapshot.ref.getDownloadURL();
      print("the audio url is $audioURL");
      print("the audio duration of the audio is ${audioController.total}");
      ChatServices().sendMessage(
        widget.currentUserUid,
        widget.partnerUid,
        audioUrl: audioURL,
        duration: audioController.total,
      );
      String strVal = audioURL.toString();
      setState(() {
        audioController.isSending.value = false;
      });
      setState(() {
        audioController.isRecording.value = false;
      });
    } on FirebaseException catch (e) {
      print("failed to upload the audio file the error is ${e.toString()}");
      setState(() {
        audioController.isSending.value = false;
      });
      setState(() {
        audioController.isRecording.value = false;
      });
    }
  }

  Future<void> _openCamera(BuildContext context) async {
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      setState(() {
        _selectedImage = File(pickedImage.path);
      });

      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ImagePreviewScreen(
            currentId: widget.currentUserUid,
            partnerId: widget.partnerUid,
            imageFile: _selectedImage!,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Align(
        child: Padding(
          padding: const EdgeInsets.only(left: 13.0),
          child: Stack(
            children: [
              Container(
                width: MediaQuery.of(context).size.width * 0.87,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          _openGallery(context);
                        },
                        icon: Icon(
                          Icons.photo,
                          color: Color(0xfffd5564),
                          size: 30,
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        constraints: BoxConstraints(
                          maxHeight: 200,
                        ),
                        width: 380,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.grey),
                          color: Color(0xffD2D4DA),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                onChanged: (text) {
                                  setState(() {
                                    isTextEmpty = text.isEmpty;
                                  });
                                },
                                controller: widget.messageController,
                                keyboardType: TextInputType.multiline,
                                maxLines: null,
                                style: TextStyle(
                                  color: Colors.black,
                                  fontFamily: "Montserrat",
                                ),
                                decoration: InputDecoration(
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 7),
                                  isDense: true,
                                  hintText:
                                      /* isRecording ? "Recording audio..." : */ "Aa...",
                                  hintStyle: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Montserrat",
                                  ),
                                  border: InputBorder.none,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    5.widthBox,
                    Expanded(
                      child: IconButton(
                        onPressed: () {
                          _openCamera(context);
                        },
                        icon: Icon(
                          Icons.camera_alt,
                          color: Color(0xfffd5564),
                          size: 30,
                        ),
                      ),
                    ),
                    10.widthBox,
                  ],
                ),
              ),
              isTextEmpty
                  ? Padding(
                      padding: const EdgeInsets.only(right: 15.0),
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: SocialMediaRecorder(
                          startRecording: () {
                            setState(() {
                              isRecording = true;
                            });
                          },
                          sendButtonIcon: Transform.rotate(
                            angle: pi,
                            child: Icon(
                              Icons.send,
                              color: Colors.white,
                              size: 30,
                            ),
                          ),
                          recordIconWhenLockBackGroundColor: Color(0xfffd5564),
                          recordIconBackGroundColor:
                              Color.fromARGB(255, 245, 164, 171),
                          recordIcon: Icon(
                            Icons.mic,
                            size: 34,
                            color: Color(0xfffd5564),
                          ),
                          backGroundColor: Colors.white,
                          stopRecording: (_time) {
                            setState(() {
                              isRecording = false;
                            });
                            print(
                                "the recording has been canceledthe recording has been canceledthe recording has been canceledthe recording has been canceledthe recording has been canceledthe recording has been canceledthe recording has been canceledthe recording has been canceledthe recording has been canceledthe recording has been canceledthe recording has been canceledthe recording has been canceledthe recording has been canceled");
                          },
                          sendRequestFunction: (soundFile, _time) async {
                            print("the current path is ${soundFile.path}");
                            await _audioPlayer.setFilePath(soundFile.path);

                            print(
                                "the recording is getting to startthe recording is getting to startthe recording is getting to startthe recording is getting to startthe recording is getting to startthe recording is getting to startthe recording is getting to startthe recording is getting to startthe recording is getting to startthe recording is getting to startthe recording is getting to startthe recording is getting to startthe recording is getting to startthe recording is getting to start");
                            uploadAudio(soundFile);
                          },
                          encode: AudioEncoderType.AAC,
                        ),
                      ),
                    )
                  : Align(
                      alignment: Alignment.centerRight,
                      child: IconButton(
                        onPressed: widget.messageController.text.isEmpty
                            ? null
                            : () {
                                widget.onTap!();
                                setState(() {
                                  isTextEmpty = true;
                                });
                              },
                        icon: Icon(
                          Icons.send_rounded,
                          size: 30,
                          color: isTextEmpty ? Colors.grey : Color(0xfffd5564),
                        ),
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
