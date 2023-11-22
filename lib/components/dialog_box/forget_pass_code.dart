import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pillowtalk/components/code_textfield.dart';
import 'package:pillowtalk/main.dart';
import 'package:pillowtalk/views/home/home.dart';
import 'package:velocity_x/velocity_x.dart';
import 'dart:math' as math;
import '../../constants/colors.dart';
import '../buttons/outline_button.dart';
import 'create_new_pass.dart';

class ForgetPassCodeDialog extends StatefulWidget {
  const ForgetPassCodeDialog({super.key});

  @override
  State<ForgetPassCodeDialog> createState() => _ForgetPassCodeDialogState();
}

class _ForgetPassCodeDialogState extends State<ForgetPassCodeDialog>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller =
      AnimationController(vsync: this, duration: const Duration(seconds: 2))
        ..repeat();
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  Future<dynamic> showCreateNewPassDialog() {
    return showGeneralDialog(
        barrierLabel: "Label",
        transitionDuration: const Duration(milliseconds: 250),
        context: context,
        barrierDismissible: true,
        transitionBuilder: (context, a1, a2, widget) {
          final curvedValue = Curves.easeInOutBack.transform(a1.value) - 1.0;
          return Transform(
            transform: Matrix4.translationValues(0.0, curvedValue * 200, 0.0),
            child:
                Opacity(opacity: a1.value, child: const CreateNewPassDialog()),
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return Container();
        });
  }

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
              padding: EdgeInsets.symmetric(
                  vertical: mq.width * 0.15, horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Forgot password?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: mq.width * 0.044,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: mq.width * 0.05,
                  ),
                  Text(
                    "Enter the 4 - digit code to reset your password",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        // fontSize: 12,
                        fontSize: mq.width * 0.03,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: mq.width * 0.03,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      codeTextField(context: context),
                      codeTextField(context: context),
                      codeTextField(context: context),
                      codeTextField(context: context),
                    ],
                  ),
                  SizedBox(
                    height: mq.width * 0.06,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customOutlineButton(
                        context: context,
                        title: "NEXT",
                        assetName: "assets/icons/arrow.svg",
                        height: 22,
                        width: 22,
                        widthbox: 4.0,
                        onPress: () {
                          stfSetState(() {
                            isLoading = true;
                          });
                          // Future.delayed(const Duration(seconds: 1), () {
                          //   Get.offAll(() => const Home(),
                          //       transition:
                          //           Transition.rightToLeftWithFade,
                          //       duration:
                          //           const Duration(milliseconds: 400));
                          // });
                          Navigator.pop(context);
                          showCreateNewPassDialog();
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
