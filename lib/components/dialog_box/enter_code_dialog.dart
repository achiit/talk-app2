import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pillowtalk/components/code_textfield.dart';
import 'package:pillowtalk/main.dart';
import 'package:pillowtalk/services/pairing_service.dart';
import 'package:pillowtalk/views/home/home.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:math' as math;
import '../../constants/colors.dart';
import '../buttons/outline_button.dart';

class EnterCodeDialog extends StatefulWidget {
  const EnterCodeDialog({super.key});

  @override
  State<EnterCodeDialog> createState() => _EnterCodeDialogState();
}

class _EnterCodeDialogState extends State<EnterCodeDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 2))
        ..repeat();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController codeController = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return SafeArea(
      child: StatefulBuilder(builder: (stfContext, stfSetState) {
        return Dialog(
          insetAnimationCurve: Curves.easeInOut,
          backgroundColor: backgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: backgroundColor),
              padding: const EdgeInsets.symmetric(vertical: 36, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Enter invite code",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: mq.width * 0.044,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: mq.width * 0.02,
                  ),
                  Text(
                    "When your partner invited you to Playdate, their message should included a 4 digit code.",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        // fontSize: 12,
                        fontSize: mq.width * 0.028,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: mq.width * 0.03,
                  ),
                  TextField(
                    controller: codeController,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  //   children: [
                  //     codeTextField(context: context),
                  //     codeTextField(context: context),
                  //     codeTextField(context: context),
                  //     codeTextField(context: context),
                  //   ],
                  // ),
                  SizedBox(
                    height: mq.width * 0.06,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      isLoading
                          ? Row(
                              children: [
                                const Text(
                                  'Entering',
                                  style: TextStyle(color: lightColor),
                                ),
                                AnimatedBuilder(
                                  animation: _controller,
                                  builder: (_, child) {
                                    return Transform.rotate(
                                      angle: _controller.value * 2 * math.pi,
                                      child: child,
                                    );
                                  },
                                  child: Container(
                                      margin: const EdgeInsets.all(10.0),
                                      child: Image.asset(
                                        "assets/indicator.png",
                                        width: 20,
                                        height: 20,
                                        fit: BoxFit.fitWidth,
                                      )),
                                ),
                              ],
                            )
                          : customOutlineButton(
                              context: context,
                              title: "ENTER",
                              assetName: "assets/icons/arrow.svg",
                              height: 22,
                              width: 22,
                              widthbox: 4.0,
                              onPress: () {
                                stfSetState(() {
                                  isLoading = true;
                                });
                                PairingManager pairingManager =
                                    PairingManager();
                                print("the code is ${codeController.text}");
                                pairingManager
                                    .connectWithPartner(codeController.text);
                              },
                            ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
