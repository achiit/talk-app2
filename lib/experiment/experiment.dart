// import 'package:carousel_animations/carousel_animations.dart';
// import 'package:flutter/material.dart';
// import 'package:pillowtalk/constants/lists.dart';
// import 'package:pillowtalk/main.dart';

// class Swiper extends StatefulWidget {
//   const Swiper({super.key});

//   @override
//   State<Swiper> createState() => _SwiperState();
// }

// class _SwiperState extends State<Swiper> {
//   @override
//   Widget build(BuildContext context) {
//     mq = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Container(
//             // color: primaryColor,
            
//             height: mq.height * 0.45,
//             child: Container(
//               // color: secondaryColor,
//               padding: EdgeInsets.only(right: 70),
//               child: Swiper(
//                 transformer: ScaleAndFadeTransformer(scale: 3,fade: 3),
//                 itemCount: cardImagesList.length,
//                 axisDirection: AxisDirection.right,
//                 itemWidth: 200,
//                 itemHeight: 700,
//                 // scale: 12,
//                 // viewportFraction: 10,
//                 layout: SwiperLayout.STACK,
//                 itemBuilder: (context, index) {
//                   return Image.asset(cardImagesList[index]);
//                 },
//               ),
//             ),
//             // child: Stack(
//             //   children: <Widget>[
//             //     CardScrollWidget(currentPage),
//             //     Positioned.fill(
//             //       child: PageView.builder(
//             //         itemCount: 2,
//             //         controller: controller,
//             //         reverse: true,
//             //         itemBuilder: (context, index) {
//             //           return Container(
//             //               // color: primaryColor,
//             //               );
//             //         },
//             //       ),
//             //     )
//             //   ],
//             // ),
//           )
//     );
//   }
// }