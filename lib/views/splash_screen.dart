import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pillowtalk/views/home/home.dart';
import 'package:pillowtalk/views/onboarding/onboarding_five.dart';
import 'dart:math' as math;
import '../constants/colors.dart';
import 'package:velocity_x/velocity_x.dart';
import 'authentication/onbaording_four.dart';
import 'onboarding/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 2))
        ..repeat();

  late Image image1;
  late Image image2;
  late Image image3;

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 2), () async{
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setSystemUIOverlayStyle(
          const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
      image1 = Image.asset("assets/banner1.png");
      image2 = Image.asset("assets/banner2.png");
      image3 = Image.asset("assets/banner3.png");
       Widget nextPage = await startUp();
      Get.off(() => nextPage, transition: Transition.noTransition);
    });
  }

  Future<Widget> startUp() async {
    print("started the process");
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
          final partnerId = userSnapshot.data()!['partnerCode'];
          print("the partner id is ${partnerId}");
      if (userSnapshot.exists) {
        final userData = userSnapshot.data() as Map<String, dynamic>;
        final isUsed = userData['used'] ?? false;
        if (isUsed) {
          return Home(myUID: user.uid, partnerUID: partnerId,);
        } else {
          // User not used, navigate to registration
          return OnboardingScreen();
        }
      }
    } else {
      return const OnboardingScreen();
    }
    return OnboardingScreen();
  }

  @override
  void didChangeDependencies() {
    // Adjust the provider based on the image type
    super.didChangeDependencies();
    precacheImage(const AssetImage("assets/banner1.webp"), context);
    precacheImage(const AssetImage("assets/banner2.webp"), context);
    precacheImage(const AssetImage("assets/banner3.webp"), context);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(child: Container()),
            // Logo file
            Center(
                child: Image.asset(
              "assets/logo.png",
              width: 130,
              height: 130,
            )),

            28.heightBox,

            const Text(
              "PillowTalk",
              style: TextStyle(
                  fontSize: 22,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500),
            ),

            16.heightBox,

            const Text(
              'Discovering the spark',
              style: TextStyle(
                  fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
            ),

            32.heightBox,
            AnimatedBuilder(
              animation: _controller,
              builder: (_, child) {
                return Transform.rotate(
                  angle: _controller.value * 2 * math.pi,
                  child: child,
                );
              },
              child: Container(
                  margin: const EdgeInsets.all(20.0),
                  child: Image.asset(
                    "assets/indicator.png",
                    width: 40,
                    height: 40,
                    fit: BoxFit.fitWidth,
                  )),
            ),
            Expanded(child: Container()),
            const Text(
              "V1.2.1",
              style: TextStyle(
                  color: lightColor,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500),
            ),

            48.heightBox
          ],
        ),
      ),
    );
  }
}
