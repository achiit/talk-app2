// import 'dart:developer';
// import 'dart:io';

// import 'package:audioplayers/audioplayers.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:image_cropper/image_cropper.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:permission_handler/permission_handler.dart';
// import 'package:pillowtalk/controllers/audioController.dart';
// import 'package:pillowtalk/controllers/chatcontroller.dart';
// import 'package:pillowtalk/services/chat_services.dart';
// import 'package:pillowtalk/views/home/imagePreviewScreen.dart';
// import 'package:record_mp3/record_mp3.dart';
// import 'package:social_media_recorder/audio_encoder_type.dart';
// import 'package:social_media_recorder/screen/social_media_recorder.dart';
// import 'package:velocity_x/velocity_x.dart';
// import 'package:just_audio/just_audio.dart' as audioo;
// import 'package:voice_message_package/voice_message_package.dart';

// class ChatInput extends StatefulWidget {
//   TextEditingController messageController = TextEditingController();
//   void Function()? onTap;
//   var controller;
//   String currentUserUid;
//   String partnerUid;
//   ChatInput(
//       {required this.messageController,
//       required this.currentUserUid,
//       required this.partnerUid,
//       required this.controller,
//       required this.onTap});

//   @override
//   State<ChatInput> createState() => _ChatInputState();
// }

// class _ChatInputState extends State<ChatInput> {
//   final picker = ImagePicker();
//   File? _selectedImage;
//   bool isTextEmpty = true;
//   AudioController audioController = Get.put(AudioController());
//   bool isRecordingCompleted = false;
//   AudioPlayer audioPlayer = AudioPlayer();
//   audioo.AudioPlayer _audioPlayer = audioo.AudioPlayer();
//   int i = 0;
//   bool isPlaying = false;

//   Future<void> _openGallery(BuildContext context) async {
//     final pickedImage = await picker.pickImage(source: ImageSource.gallery);

//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage = File(pickedImage.path);
//       });

//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ImagePreviewScreen(
//             currentId: widget.currentUserUid,
//             partnerId: widget.partnerUid,
//             imageFile: _selectedImage!,
//           ),
//         ),
//       );
//     }
//   }

//   Future<void> _openCamera(BuildContext context) async {
//     final pickedImage = await picker.pickImage(source: ImageSource.camera);

//     if (pickedImage != null) {
//       setState(() {
//         _selectedImage = File(pickedImage.path);
//       });

//       Navigator.push(
//         context,
//         MaterialPageRoute(
//           builder: (context) => ImagePreviewScreen(
//             currentId: widget.currentUserUid,
//             partnerId: widget.partnerUid,
//             imageFile: _selectedImage!,
//           ),
//         ),
//       );
//     }
//   }

//   Future<bool> checkPermission() async {
//     if (!await Permission.microphone.isGranted) {
//       PermissionStatus status = await Permission.microphone.request();
//       if (status != PermissionStatus.granted) {
//         return false;
//       }
//     }
//     return true;
//   }

//   Future<String> getFilePath() async {
//     Directory storageDirectory = await getApplicationDocumentsDirectory();
//     String sdPath =
//         "${storageDirectory.path}/record${DateTime.now().microsecondsSinceEpoch}.mp3";
//     var d = Directory(sdPath);
//     if (!d.existsSync()) {
//       d.createSync(recursive: true);
//     }
//     return "$sdPath/test_${i++}.mp3";
//   }

//   late String recordFilePath;
//   String audioURL = "";
//   void startRecord() async {
//     print("the audio is checking the permission wait ");
//     debugPrint("the audio is checking the permission wait ");
//     bool hasPermission = await checkPermission();
//     print("started to record the audio now dont worry");
//     if (hasPermission) {
//       recordFilePath = await getFilePath();
//       setState(() {
//         audioController.isRecording.value = true;
//         // onSendMessage(strVal, TypeMessage.audio,
//         //     duration: audioController.total);
//       });
//       RecordMp3.instance.start(recordFilePath, (type) {
//         setState(() {});
//       });
//     } else {}
//     setState(() {});
//   }

//   String formatTime(Duration duration) {
//     String twoDigits(int n) => n.toString().padLeft(2, '0');
//     final hours = twoDigits(duration.inHours);
//     final minutes = twoDigits(duration.inMinutes.remainder(60));
//     final seconds = twoDigits(duration.inSeconds.remainder(60));
//     return [
//       if (duration.inHours > 0) hours,
//       minutes,
//       seconds,
//     ].join(":");
//   }

//   void stopRecord() async {
//     bool stop = RecordMp3.instance.stop();
//     audioController.end.value = DateTime.now();
//     audioController.calcDuration();
//     var ap = AudioPlayer();
//     await ap.play(AssetSource("Notification.mp3"));
//     ap.onPlayerComplete.listen((a) {});

//     if (stop) {
//       audioController.isRecording.value = false;
//       audioController.isSending.value = true;

//       // Use JustAudio to play the audio
//       await _audioPlayer.setFilePath(recordFilePath);
//       print("the path of the audio is $recordFilePath");
//       bool isPlaying = false;

//       _audioPlayer.playerStateStream.listen((playerState) {
//         if (playerState == PlayerState.completed) {
//           setState(() {
//             isPlaying = false;
//           });
//         }
//       });

//       showDialog(
//         context: context,
//         builder: (ctx) => StatefulBuilder(
//           builder: (context, setState) => AlertDialog(
//             title: Text("Sending Audio"),
//             content: Container(
//               height: 180,
//               child: Column(
//                 children: [
//                   Slider(
//                     value: audioController.currentDuration.toDouble(),
//                     onChanged: (value) {},
//                     min: 0,
//                     max: audioController.totalDuration.toDouble(),
//                   ),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text(formatTime(
//                           audioController.currentDuration.value.microseconds)),
//                       Text(formatTime(
//                           audioController.totalDuration.value.microseconds)),
//                     ],
//                   ),
//                   CircleAvatar(
//                     radius: 40,
//                     child: IconButton(
//                       onPressed: () async {
//                         if (isPlaying) {
//                           await _audioPlayer.pause();
//                         } else {
//                           await _audioPlayer.seek(Duration.zero, index: 0);
//                           await _audioPlayer.play();
//                         }
//                         setState(() {
//                           isPlaying = !isPlaying;
//                         });
//                       },
//                       icon: Icon(
//                         isPlaying ? Icons.pause : Icons.play_arrow,
//                         size: 30,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             actions: <Widget>[
//               TextButton(
//                 onPressed: () {
//                   Navigator.of(ctx).pop();
//                 },
//                 child: Container(
//                   color: Colors.green,
//                   padding: const EdgeInsets.all(14),
//                   child: const Text("Okay"),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     }
//   }

//   ChatProvider chatProvider = ChatProvider(
//       firebaseFirestore: FirebaseFirestore.instance,
//       firebaseStorage: FirebaseStorage.instance);
//   uploadAudio(File soundFile) async {
//     print("starting to upload the audio file");
//     UploadTask uploadTask = chatProvider.uploadAudio(soundFile,
//         "audio/${DateTime.now().millisecondsSinceEpoch.toString()}.mp3");
//     try {
//       print(
//           "starting to upload the audio file entering the phase of uploading the audio");
//       TaskSnapshot snapshot = await uploadTask;
//       audioURL = await snapshot.ref.getDownloadURL();
//       print("the audio url is $audioURL");
//       print("the audio duration of the audio is ${audioController.total}");
//       ChatServices().sendMessage(widget.currentUserUid, widget.partnerUid,
//           audioUrl: audioURL, duration: audioController.total);
//       String strVal = audioURL.toString();
//       setState(() {
//         audioController.isSending.value = false;
//         // onSendMessage(strVal, TypeMessage.audio,
//         //     duration: audioController.total);
//       });
//       setState(() {
//         audioController.isRecording.value = false;
//         // onSendMessage(strVal, TypeMessage.audio,
//         //     duration: audioController.total);
//       });
//     } on FirebaseException catch (e) {
//       print("failed to upload the audio file the error is ${e.toString()}");
//       setState(() {
//         audioController.isSending.value = false;
//       });
//       setState(() {
//         audioController.isRecording.value = false;
//         // onSendMessage(strVal, TypeMessage.audio,
//         //     duration: audioController.total);
//       });
//       //Fluttertoast.showToast(msg: e.message ?? e.toString());
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     // TODO: implement build
//     return SingleChildScrollView(
//       //keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//       child: Align(
//         //alignment: Alignment.bottomCenter,
//         child: Padding(
//           padding: const EdgeInsets.only(right: 13.0),
//           child: Row(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               10.widthBox,
//               IconButton(
//                 onPressed: () {
//                   // _openGallery(context);
//                   _openGallery(context);
//                 },
//                 icon: Icon(
//                   Icons.photo,
//                   color: Color(
//                     0xfffd5564,
//                   ),
//                   size: 30,
//                 ),
//               ),
//               Expanded(
//                 child: Container(
//                   padding: const EdgeInsets.symmetric(horizontal: 12),
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.circular(26),
//                     color: Colors.grey[50],
//                     border: Border.all(color: Colors.grey),
//                   ),
//                   child: Row(
//                     children: [
//                       Expanded(
//                         child: Container(
//                           constraints: BoxConstraints(
//                             maxHeight: 200,
//                           ),
//                           width: 380, // Adjust the width as needed
//                           padding: EdgeInsets.symmetric(horizontal: 20),
//                           decoration: BoxDecoration(
//                             // color: Colors.white, // Fill color
//                             borderRadius:
//                                 BorderRadius.circular(30), // Circular shape
//                           ),
//                           child: TextFormField(
//                             onChanged: (text) {
//                               setState(() {
//                                 isTextEmpty = text.isEmpty;
//                               });
//                             },
//                             validator: (value) {
//                               if (value!.trim().isEmpty) {
//                                 return 'Please enter a message';
//                               }
//                               return null;
//                             },
//                             focusNode: widget.controller.focusNode,
//                             controller: widget.messageController,
//                             keyboardType: TextInputType.multiline,
//                             maxLines: null,
//                             decoration: InputDecoration(
//                               isDense: true,
//                               hintText: audioController.isRecording.value
//                                   ? "Recording audio..."
//                                   : "Aa...",
//                               hintStyle: TextStyle(
//                                   color: Colors.black,
//                                   fontFamily: "Montserrat"),
//                               border: InputBorder.none,
//                             ),
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               IconButton(
//                 onPressed: () {
//                   // _openGallery(context);
//                   _openCamera(context);
//                 },
//                 icon: Icon(
//                   Icons.camera_alt,
//                   color: Color(
//                     0xfffd5564,
//                   ),
//                   size: 30,
//                 ),
//               ),
//               SocialMediaRecorder(
//                 // maxRecordTimeInSecond: 5,
//                 startRecording: () {
//                   // function called when start recording
//                 },
//                 stopRecording: (_time) {
//                   // function called when stop recording, return the recording time
//                 },
//                 sendRequestFunction: (soundFile, _time) async {
//                   print("the current path is ${soundFile.path}");
//                   await _audioPlayer.setFilePath(soundFile.path);
//                   //uploadAudio(soundFile);
//                 },
//                 encode: AudioEncoderType.AAC,
//                 // storeSoundRecoringPath: "/storage/emulated/0/new_record_sound",
//               ),
//               10.widthBox,
//               // isTextEmpty
//               //     ? GestureDetector(
//               //         onLongPress: () async {
//               //           print(
//               //               "hello worldhello worldhello worldhello worldhello worldhello worldhello world");
//               //           var audioPlayer = AudioPlayer();
//               //           await audioPlayer.play(AssetSource("Notification.mp3"));
//               //           audioPlayer.onPlayerComplete.listen((a) {
//               //             audioController.start.value = DateTime.now();
//               //             print("now trying to start the recording ");
//               //             startRecord();
//               //             audioController.isRecording.value = true;
//               //           });
//               //         },
//               //         onLongPressEnd: (details) {
//               //           stopRecord();
//               //         },
//               //         child: Padding(
//               //           padding: const EdgeInsets.only(top: 8.0),
//               //           child: Icon(
//               //             Icons.mic,
//               //             size: 34,
//               //             color: Color(
//               //               0xfffd5564,
//               //             ),
//               //           ),
//               //         ),
//               //       )
  //               //     : IconButton(
  //               //         onPressed: widget.messageController.text.isEmpty
  //               //             ? null // Disable the button if text is empty
  //               //             : () {
  //               //                 widget.onTap!();
  //               //                 setState(() {
  //               //                   isTextEmpty = true;
  //               //                 });
  //               //               },
  //               //         icon: Icon(
  //               //           Icons.send_rounded,
  //               //           size: 30,
  //               //           color: isTextEmpty
  //               //               ? Colors
  //               //                   .grey // Use a different color for disabled state
  //               //               : Color(0xfffd5564),
  //               //         ),
  //               //       )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
