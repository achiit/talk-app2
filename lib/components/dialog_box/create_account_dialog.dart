import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pillowtalk/main.dart';
import 'package:pillowtalk/services/pairing_service.dart';
import 'package:pillowtalk/utils/showSnackBar.dart';
import 'package:velocity_x/velocity_x.dart';
import '../../services/firebase_auth_methods.dart';
import '../../constants/colors.dart';
import '../buttons/outline_button.dart';

class CreateAccountDialog extends StatefulWidget {
  const CreateAccountDialog({super.key});

  @override
  State<CreateAccountDialog> createState() => _CreateAccountDialogState();
}

class _CreateAccountDialogState extends State<CreateAccountDialog> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  TextEditingController firstnameController = TextEditingController();
  TextEditingController lastnameController = TextEditingController();

  var hidePass = true;
  void signUpUser() {
    if (firstnameController.text == '') {
      showSnackBar(context, 'Please enter you name');
    } else if (lastnameController.text == '') {
      showSnackBar(context, 'Please enter your last name');
    } else {
      // FirebaseAuthMethods(FirebaseAuth.instance).signUpWithEmail(
      //     email: emailController.text,
      //     password: passController.text,
      //     context: context);
      PairingManager pairingManager = PairingManager();
      pairingManager.registerUserAndStorePartnerCode(
          emailController.text,
          passController.text,
          firstnameController.text,
          lastnameController.text);
    }
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
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: backgroundColor),
            padding: EdgeInsets.symmetric(
                vertical: MediaQuery.of(context).size.width * 0.025,
                horizontal: mq.width * 0.04),
            child: Form(
              key: _formField,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Sign up",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: mq.width * 0.045,
                        fontFamily: 'Montserrat',
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: mq.width * 0.04,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "First name",
                              style: TextStyle(
                                  fontSize: mq.width * 0.034,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500),
                            ),
                            TextFormField(
                              cursorColor: secondaryColor,
                              autofocus: true,
                              decoration: const InputDecoration(
                                  errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: darkColor)),
                                  focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: darkColor)),
                                  isDense: true),
                              controller: firstnameController,
                              validator: (value) {
                                bool _nameRegex =
                                    RegExp(r"^[a-zA-Z]+$").hasMatch(value!);
                                if (value.isEmpty) {
                                  return "Enter Name";
                                } else if (!_nameRegex) {
                                  return "Enter correct name";
                                }
                                return null;
                              },
                            )
                          ],
                        ),
                      ),
                      16.widthBox,
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Last name",
                              style: TextStyle(
                                  fontSize: mq.width * 0.034,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500),
                            ),
                            TextFormField(
                              autofocus: true,
                              decoration: const InputDecoration(
                                  errorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: darkColor)),
                                  focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: darkColor)),
                                  isDense: true),
                              controller: lastnameController,
                              validator: (value) {
                                bool _nameRegex =
                                    RegExp(r"^[a-zA-Z]+$").hasMatch(value!);
                                if (value.isEmpty) {
                                  return "Enter Last Name";
                                } else if (!_nameRegex) {
                                  return "Enter correct name";
                                }
                                return null;
                              },
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: mq.width * 0.03,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        style: TextStyle(
                            fontSize: mq.width * 0.034,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          errorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: darkColor)),
                          focusedErrorBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: darkColor)),
                          isDense: true,
                        ),
                        controller: emailController,
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
                      SizedBox(
                        height: mq.width * 0.03,
                      ),
                      Text(
                        "Password",
                        style: TextStyle(
                            fontSize: mq.width * 0.034,
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500),
                      ),
                      TextFormField(
                        controller: passController,
                        obscureText: hidePass ? true : false,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Password";
                          } else if (value.length < 6) {
                            return "Password length should be more than 6 characters";
                          }
                          return null;
                        },
                        decoration: InputDecoration(
                          isDense: true,
                          errorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: darkColor)),
                          focusedErrorBorder: const UnderlineInputBorder(
                              borderSide: BorderSide(color: darkColor)),
                          suffix: GestureDetector(
                              onTap: () {
                                setState(() {
                                  hidePass = !hidePass;
                                });
                              },
                              child: Container(
                                height: mq.width * 0.05,
                                // color: primaryColor,
                                child: hidePass == true
                                    ? Icon(
                                        Icons.visibility_off_outlined,
                                        size: mq.width * 0.05,
                                      )
                                    : Icon(
                                        Icons.visibility_outlined,
                                        size: mq.width * 0.05,
                                      ),
                              )),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: mq.width * 0.03,
                  ),
                  RichText(
                    text: TextSpan(
                        style: const TextStyle(
                            fontFamily: 'Montserrat',
                            fontWeight: FontWeight.w500),
                        children: [
                          TextSpan(
                              text:
                                  "By selecting Agree and continue below, I agree to PillowTalk ",
                              style: TextStyle(
                                  fontSize: mq.width * 0.028,
                                  color: greyColor,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500)),
                          TextSpan(
                              text: "Terms & Conditions",
                              style: TextStyle(
                                  color: secondaryColor,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                  fontSize: mq.width * 0.028,
                                  decoration: TextDecoration.underline)),
                          TextSpan(
                              text: " and ",
                              style: TextStyle(
                                  color: greyColor,
                                  fontSize: mq.width * 0.028,
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500)),
                          TextSpan(
                              text: "Privacy Policy",
                              style: TextStyle(
                                  fontFamily: 'Montserrat',
                                  fontWeight: FontWeight.w500,
                                  color: secondaryColor,
                                  fontSize: mq.width * 0.028,
                                  decoration: TextDecoration.underline)),
                        ]),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(
                    height: mq.height * 0.01,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      customOutlineButton(
                        context: context,
                        title: "AGREE AND CONTINUE",
                        assetName: "assets/icons/arrow.svg",
                        height: mq.width * 0.05,
                        width: mq.width * 0.05,
                        widthbox: 4.0,
                        onPress: () {
                          if (_formField.currentState!.validate()) {
                            signUpUser();
                          }
                        },
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
