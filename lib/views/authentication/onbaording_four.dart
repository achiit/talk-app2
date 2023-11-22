import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math' as math;
import 'package:pillowtalk/constants/colors.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../components/dialog_box/create_account_dialog.dart';
import '../../components/dialog_box/login_dialog.dart';
import '../../components/buttons/sign_in_outline_button.dart';
import '../../main.dart';
import '../../services/firebase_auth_methods.dart';
import '../onboarding/onboarding_five.dart';

class OnboardingFourScreen extends StatefulWidget {
  const OnboardingFourScreen({super.key});

  @override
  State<OnboardingFourScreen> createState() => _OnboardingFourScreenState();
}

class _OnboardingFourScreenState extends State<OnboardingFourScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 2))
        ..repeat();
  late Image image;

  @override
  void initState() {
    super.initState();
    image = Image.asset('assets/illustration1.webp');
  }

  @override
  void didChangeDependencies() {
    //provide the image provider to precached Image
    precacheImage(image.image, context);
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<dynamic> showLoginDialog() {
    return showGeneralDialog(
        barrierLabel: "Label",
        transitionDuration: const Duration(milliseconds: 300),
        context: context,
        barrierDismissible: true,
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child: Opacity(opacity: a1.value, child: const LoginDialog()),
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return Container();
        });
  }

  Future<dynamic> showCreateAccountDialog() {
    return showGeneralDialog(
        barrierLabel: "Label",
        transitionDuration: const Duration(milliseconds: 300),
        context: context,
        barrierDismissible: true,
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child:
                Opacity(opacity: a1.value, child: const CreateAccountDialog()),
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return Container();
        });
  }

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.50,
              child: Center(
                  child: Image.asset(
                "assets/illustration1.webp",
                fit: BoxFit.cover,
                // width: 400,
              )),
            ),
            // 24.heightBox,
            const Text(
              "Love is in the air",
              style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w500),
            ),
            14.heightBox,
            Row(
              children: [
                GestureDetector(
                    onTap: () {
                      showCreateAccountDialog();
                    },
                    child: const SizedBox(
                      height: 24,
                      child: Text(
                        "Create an account",
                        style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            color: secondaryColor,
                            decoration: TextDecoration.underline),
                      ),
                    )),
                const SizedBox(
                  height: 24,
                  child: Text(
                    " or ",
                    style: TextStyle(
                        fontFamily: 'Montserrat', fontWeight: FontWeight.w500),
                  ),
                ),
                GestureDetector(
                    onTap: () {
                      showLoginDialog();
                    },
                    child: const SizedBox(
                      height: 24,
                      child: Text(
                        "log in",
                        style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500,
                            color: secondaryColor,
                            decoration: TextDecoration.underline),
                      ),
                    )),
              ],
            ),
            20.heightBox,
            customSignInOutlineButton(
              assetName: "assets/icons/google.svg",
              title: "CONTINUE WITH GOOGLE",
              height: 18,
              width: 18,
              widthbox: 16,
              context: context,
              onPress: () {
                showDialog(
                  barrierDismissible: false,
                    context: context,
                    builder: (_) => Center(
                          child: AnimatedBuilder(
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
                        ));
                FirebaseAuthMethods(FirebaseAuth.instance)
                    .signInWithGoogle(context);
              },
            ),
            8.heightBox,
            customSignInOutlineButton(
                assetName: "assets/icons/Facebook.svg",
                title: "CONTINUE WITH FACEBOOK",
                height: 20,
                width: 20,
                widthbox: 12,
                context: context),
            8.heightBox,
            customSignInOutlineButton(
              assetName: "assets/icons/apple.svg",
              title: "CONTINUE WITH APPLE",
              height: 20,
              width: 20,
              widthbox: 12,
              context: context,
              onPress: () => Get.offAll(() => const OnboardingFiveScreen(),
                  transition: Transition.rightToLeftWithFade,
                  duration: const Duration(milliseconds: 200)),
            ),
            Expanded(child: Container())
          ],
        ),
      ),
    );
  }
}
