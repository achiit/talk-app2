// import 'dart:convert';
// import 'dart:math';

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
// import 'package:pillowtalk/components/chat_cards/message_card.dart';
// import 'package:pillowtalk/main.dart';
// import 'package:velocity_x/velocity_x.dart';

// import '../../constants/colors.dart';
// import 'home.dart';

// class MessageScreen extends StatelessWidget {
//   const MessageScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     mq = MediaQuery.of(context).size;
//     return SafeArea(
//       top: false,
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           leading: IconButton(
//               onPressed: () {
//                 Get.offAll(
//                   () => const Home(),
//                   //  transition: Transition.leftToRightWithFade, duration: const Duration(milliseconds: 200)
//                 );
//               },
//               icon: const Icon(
//                 Icons.arrow_back,
//                 color: darkColor,
//                 size: 28,
//               )),
//           title: Container(
//             // color: primaryColor,
//             width: mq.width * 0.4,
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 Text(
//                   'My bunny 🐇',
//                   style: TextStyle(
//                       fontFamily: 'Univers',
//                       fontWeight: FontWeight.w500,
//                       fontSize: mq.width * 0.045),
//                 ),
//                 Center(
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       SvgPicture.asset('assets/icons/online_indicator.svg'),
//                       8.widthBox,
//                       Text(
//                         'Online',
//                         style: TextStyle(
//                             fontFamily: 'Univers',
//                             fontWeight: FontWeight.w300,
//                             fontSize: mq.width * 0.035),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           backgroundColor: backgroundColor,
//           forceMaterialTransparency: true,
//           elevation: 0,
//         ),
//         body: const MessageCard(),
//         floatingActionButton: Padding(
//           padding: EdgeInsets.only(bottom: mq.width * 0.16),
//           child: FloatingActionButton(
//             backgroundColor: primaryColor,
//             onPressed: () {},
//             child: Center(
//             //     child: SvgPicture.asset(
//             //   'assets/icons/tapcards.svg',
//             //   fit: BoxFit.fitHeight,
//             // )
//             child: Lottie.asset('assets/json/spritemap1.json'),
//             ),
//           ),
//         ),

//         // body: Center(
//         //     child: StreamBuilder(
//         //   stream: FirebaseFirestore.instance.collection('users').snapshots(),
//         //   builder: (context, snapshot) {
//         //     final list = [];
//         //     if (snapshot.hasData) {
//         //       final data = snapshot.data?.docs;
//         //       for (var i in data!) {
//         //         print('Data: ${jsonEncode(i.data())}');
//         //         list.add(i.data()['name']);
//         //       }
//         //     }
//         //     return Center(
//         //       child: ListView.builder(
//         //         itemCount: list.length,
//         //         itemBuilder: (context, index) {
//         //           return Text('Name: ${list[index]}');
//         //         },
//         //       ),
//         //     );
//         //   },
//         // )),
//       ),
//     );
//   }
// }