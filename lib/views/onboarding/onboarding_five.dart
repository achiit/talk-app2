import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pillowtalk/api/apis.dart';
import 'package:pillowtalk/components/buttons/outline_button.dart';
import 'package:pillowtalk/constants/colors.dart';
import 'package:pillowtalk/services/firebase_dynamic_links.dart';
import 'package:pillowtalk/services/pairing_service.dart';
import 'package:pillowtalk/views/authentication/onbaording_four.dart';
import 'package:pillowtalk/views/home/home.dart';
import 'package:pillowtalk/views/splash_screen.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../components/dialog_box/enter_code_dialog.dart';
import '../../main.dart';
import 'dart:math' as math;

class OnboardingFiveScreen extends StatefulWidget {
  const OnboardingFiveScreen({super.key});
  @override
  State<OnboardingFiveScreen> createState() => _OnboardingFiveScreenState();
}

class _OnboardingFiveScreenState extends State<OnboardingFiveScreen>
    with SingleTickerProviderStateMixin {
  int _counter = 0;
  // DynamicLinkHelper dHelper = DynamicLinkHelper();
  PairingManager pairingService = PairingManager();

  @override
  void initState() {
    super.initState();
    pairingService.initDynamicLinks((openLink) {
      print(openLink.link.path);
      if (openLink.link.path == '/') {
        Get.to(() => SplashScreen());
      } else if (openLink.link.path == '/start1') {
        Get.to(() => OnboardingFourScreen());
      }
    });
    handleDynamicLinks(); // Call the function to handle dynamic links
  }

  void handleDynamicLinks() {
    FirebaseDynamicLinks.instance.onLink.listen(
        (PendingDynamicLinkData? dynamicLink) {
      _handleLinkData(dynamicLink!);
    }, onError: (e) {
      // Handle errors here
      print('Error: ${e.message}');
    });
  }

  void _handleLinkData(PendingDynamicLinkData? data) {
    if (data != null) {
      final Uri? deepLink = data.link;
      if (deepLink != null) {
        final String? uid = deepLink.queryParameters['uid'];
        if (uid != null) {
          print('Received UID from dynamic link: $uid');
          // Now you can use the UID in your app
        } else {
          print('UID parameter is null in the dynamic link.');
        }
      } else {
        print('Deep link is null in the dynamic link.');
      }
    } else {
      print('PendingDynamicLinkData is null.');
    }
  }

  Future<dynamic> showEnterCodeDialog() {
    return showGeneralDialog(
        barrierLabel: "Label",
        transitionDuration: const Duration(milliseconds: 250),
        context: context,
        barrierDismissible: true,
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: Opacity(opacity: a1.value, child: const EnterCodeDialog()),
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return Container();
        });
  }

  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 2))
        ..repeat();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.all(16),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              // Expanded(child: Container()),
              SizedBox(
                height: mq.height * 0.2,
              ),
              Center(
                  child: Image.asset(
                "assets/illustration2.png",
                width: 220,
              )),
              24.heightBox,
              const Text(
                "It takes two to tango",
                style: TextStyle(
                    fontSize: 20,
                    fontFamily: 'Montserrat',
                    fontWeight: FontWeight.w500),
              ),
              14.heightBox,
              const Text(
                "Invite your partner to enjoy the full experience, or join using invite code.",
                style: TextStyle(
                    fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
              ),
              20.heightBox,
              customOutlineButton(
                context: context,
                assetName: "assets/icons/arrow.svg",
                title: isLoading ? "AWAITING PARTNER" : "INVITE MY PARTNER",
                height: mq.width * 0.05,
                width: mq.width * 0.05,
                widthbox: 12,
                widget: AnimatedBuilder(
                  animation: _controller,
                  builder: (_, child) {
                    return Transform.rotate(
                      angle: _controller.value * 2 * math.pi,
                      child: child,
                    );
                  },
                  child: Container(
                      // margin: const EdgeInsets.all(10.0),
                      child: Image.asset(
                    "assets/indicator.png",
                    width: 20,
                    height: 20,
                    fit: BoxFit.fitWidth,
                  )),
                ),
                isClick: isLoading,
                onPress: () async {
                  // String generateCode() {
                  //   var random = Random();
                  //   const characters = 'abcdefghijklmnopqrstuvwxyz0123456789';
                  //   String code = '';
                  //   for (int i = 0; i < 6; i++) {
                  //     code += characters[random.nextInt(characters.length)];
                  //   }
                  //   print(code);
                  //   return code;
                  // }
                  // dHelper.createDynamicLink('start');
                  // PairingManager().generateDynamicLink(APIs.auth.currentUser!.uid);
                  // var currentUser = APIs.auth.currentUser;
                  // if (currentUser != null) {
                  //   pairingService.createDynamicLink(currentUser.uid);
                  //   // print(currentUser.uid);
                  //   print('handle dynamic chala raha tha yr ');
                  //   // handleDynamicLink();
                  //   print('i hope bc chal gaya hoga yr please');
                  //   setState(() {
                  //     isLoading = true;
                  //   });
                  // } else {
                  //   // Handle the case where the user is not authenticated.
                  //   print('User not authenticated.');
                  // }

                  // print(APIs.auth.currentUser!.uid);
                  setState(() {
                    isLoading = true;
                  });
                  PairingManager pairingManager = PairingManager();
                  final partnerCode =
                      await pairingManager.generateUniquePartnerCode();
                  final authResult = FirebaseAuth.instance.currentUser;
                  await FirebaseFirestore.instance
                      .collection('users')
                      .doc(authResult!.uid)
                      .update({
                    'used': false,
                    'partnerCode': partnerCode,

                    // Other user data you may want to store
                  });
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Partner Code"),
                      content: Column(
                        children: [
                          Text("Your partner code is: $partnerCode"),
                          ElevatedButton(
                            onPressed: () {
                              // Copy to clipboard
                              Clipboard.setData(
                                  ClipboardData(text: partnerCode));
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content:
                                      Text("Partner code copied to clipboard"),
                                ),
                              );
                            },
                            child: Text("Copy"),
                          ),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            // If you want to navigate after the dialog is closed
                            // Get.offAll(() => const Home(),
                            //     transition: Transition.rightToLeftWithFade,
                            //     duration: const Duration(milliseconds: 250));
                          },
                          child: Text("OK"),
                        ),
                      ],
                    ),
                  );
                  // Future.delayed(const Duration(seconds: 1), () {
                  //   Get.offAll(() => const Home(),
                  //       transition: Transition.rightToLeftWithFade,
                  //       duration: const Duration(milliseconds: 250));
                  // });
                },
              ),
              8.heightBox,
              customOutlineButton(
                context: context,
                assetName: "assets/icons/arrow.svg",
                title: "ENTER INVITE CODE",
                height: mq.width * 0.05,
                width: mq.width * 0.05,
                widthbox: 12,
                onPress: () {
                  showEnterCodeDialog();
                },
              ),
              // Expanded(child: Container()),
            ],
          ),
        ),
      ),
    );
  }
}
