import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pillowtalk/main.dart';
import 'package:pillowtalk/services/firebase_auth_methods.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../constants/colors.dart';
import '../buttons/outline_button.dart';
import 'forget_pass_code.dart';

class ForgetPasswordDialog extends StatefulWidget {
  const ForgetPasswordDialog({super.key});

  @override
  State<ForgetPasswordDialog> createState() => _ForgetPasswordDialogState();
}

class _ForgetPasswordDialogState extends State<ForgetPasswordDialog> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();

  Future<dynamic> showForgetPassCodeDialog() {
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
                Opacity(opacity: a1.value, child: const ForgetPassCodeDialog()),
          );
        },
        pageBuilder: (context, animation, secondaryAnimation) {
          return Container();
        });
  }

//Login Function
  loginUser() {
    FirebaseAuthMethods(FirebaseAuth.instance).loginWithEmail(
        email: emailController.text,
        password: passController.text,
        context: context);
  }

  final _formField = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;
    return SafeArea(
      child: Dialog(
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
                vertical: mq.width * 0.122, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Forget Password?",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: mq.width * 0.044,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: mq.width * 0.04,
                ),
                Text(
                  "Enter your email below to receive your password reset code",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: mq.width * 0.03,
                      fontFamily: 'Montserrat',
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: mq.width * 0.05,
                ),
                Form(
                  key: _formField,
                  child: TextFormField(
                    autofocus: true,
                    cursorColor: secondaryColor,
                    controller: emailController,
                    decoration: const InputDecoration(
                        errorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: darkColor)),
                        focusedErrorBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: darkColor)),
                        isDense: true),
                    validator: (value) {
                      bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_'{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value!);
                      if (value.isEmpty) {
                        return "Enter email";
                      } else if (!emailValid) {
                        return "Enter valid email";
                      }
                      return null;
                    },
                  ),
                ),
                SizedBox(
                  height: mq.width * 0.07,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customOutlineButton(
                      context: context,
                      title: "RESET PASSWORD",
                      assetName: "assets/icons/arrow.svg",
                      height: mq.width * 0.05,
                      width: mq.width * 0.05,
                      widthbox: 4.0,
                      onPress: () {
                        if (_formField.currentState!.validate()) {
                          loginUser();
                        }
                        Navigator.pop(context);
                        showForgetPassCodeDialog();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
