import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:pillowtalk/views/home/home.dart';
import '../utils/showSnackBar.dart';
import '../views/onboarding/onboarding_five.dart';

class FirebaseAuthMethods {
  final FirebaseAuth _auth;
  FirebaseAuthMethods(
    this._auth,
  );

  // Email Sign up
  Future<void> signUpWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      // Inside signUpWithEmail method
      await _auth.createUserWithEmailAndPassword(
          email: email, password: password);

      Get.back();
      Get.to(() => const OnboardingFiveScreen(),
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(milliseconds: 200));
      // await sendEmailVerification(context);
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  // Register user in Firestore after successful email registration
  // Future<void> registerUserInFirestore({
  //   required String uid,
  //   required String email,
  //   required String displayName,
  // }) async {
  //   try {
  //     await FirebaseFirestore.instance.collection('users').doc(uid).set({
  //       'uid': uid,
  //       'email': email,
  //       'displayName': displayName,
  //       // Add more fields as needed
  //     });
  //   } catch (e) {
  //     print('Error registering user in Firestore: $e');
  //   }
  // }

  // Get user information from Firestore using UID
  // Future<User?> getUserFromFirestore(String uid) async {
  //   try {
  //     DocumentSnapshot userSnapshot =
  //         await FirebaseFirestore.instance.collection('users').doc(uid).get();
  //     if (userSnapshot.exists) {
  //       Map<String, dynamic> userData =
  //           userSnapshot.data() as Map<String, dynamic>;
  //       return User(
  //         uid: userData['uid'],
  //         email: userData['email'],
  //         displayName: userData['displayName'],
  //         // Retrieve more fields as needed
  //       );
  //     }
  //     return null;
  //   } catch (e) {
  //     print('Error getting user from Firestore: $e');
  //     return null;
  //   }
  // }

  // Email Login
  Future<void> loginWithEmail({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      Get.back();
      Get.offAll(() => const OnboardingFiveScreen(),
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(milliseconds: 200));
    } on FirebaseAuthException catch (e) {
      showSnackBar(context, e.message!);
    }
  }

  // Google sign in
  Future<void> signInWithGoogle(BuildContext context) async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      if (googleAuth?.accessToken != null && googleAuth?.idToken != null) {
        print('${FirebaseAuth.instance.currentUser}');
        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
        UserCredential userCredential =
            await _auth.signInWithCredential(credential);
        Navigator.pop(context);
        Get.offAll(() {
          return const OnboardingFiveScreen();
        },
            duration: const Duration(milliseconds: 200),
            transition: Transition.rightToLeftWithFade);
      } else if (googleAuth?.accessToken == null &&
          googleAuth?.idToken == null) {
        Navigator.pop(context);
      }
      // else{
      //   Get.offAll(() {
      //     return const OnboardingFiveScreen();
      //   },
      //       duration: const Duration(milliseconds: 200),
      //       transition: Transition.rightToLeftWithFade);
      // }
    } catch (e) {
      Navigator.pop(context);
      showSnackBar(context, 'Something went wrong(Check Internet!)');
    }
  }
  // Email verification
  // Future<void> sendEmailVerification(BuildContext context) async {
  //   try {
  //     _auth.currentUser!.sendEmailVerification();
  //   } on FirebaseAuthException catch (e) {
  //     showSnackBar(context, e.message!);
  //   }
  // }
}

class User {
  final String uid;
  final String email;
  final String displayName; // Add more fields as needed

  User({
    required this.uid,
    required this.email,
    required this.displayName,
  });
}
