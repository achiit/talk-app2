import 'dart:ffi';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:pillowtalk/api/apis.dart';
import 'package:pillowtalk/views/home/home.dart';
import 'package:pillowtalk/views/onboarding/onboarding_five.dart';
import 'package:share_plus/share_plus.dart';
import 'package:uuid/uuid.dart';

class PairingManager {
  Future<void> initDynamicLinks(
      Function(PendingDynamicLinkData openLink) dataObj) async {
    FirebaseDynamicLinks.instance.onLink.listen((dynamicLinkData) {
      dataObj(dynamicLinkData);
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }

  Future<void> createDynamicLink(String uid) async {
    final String link = 'https://pillowtalk.page.link/?id=$uid';
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://pillowtalk.page.link',
      link: Uri.parse(link), // Append UID to the link
      androidParameters: AndroidParameters(
          packageName: 'com.pillowtalk.gamesforcouples',
          minimumVersion: 1 // Android package name
          ),
      // Add more parameters as needed for iOS, navigation, etc.
    );
    print(uid);
    final ShortDynamicLink dynamicUrl =
        await FirebaseDynamicLinks.instance.buildShortLink(parameters);
    final String shortUrl = dynamicUrl.shortUrl.toString();
    print(shortUrl);
    Share.share(shortUrl); // Share the short URL containing the UID
    // return shortUrl;
  }

  Future<String?> handleDynamicLink() async {
    final PendingDynamicLinkData? data =
        await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null && deepLink.queryParameters['id'] != null) {
      return deepLink.queryParameters['id'];
    }
    return null;
  }

  Future<bool> verifyAndPairUsers(String user1Uid, String user2Uid) async {
    bool isPairingVerified = await checkPairingInFirebase(user1Uid);

    if (isPairingVerified) {
      await FirebaseFirestore.instance.collection('pairs').add({
        'user1Uid': user1Uid,
        'user2Uid': user2Uid,
        'timestamp': FieldValue.serverTimestamp(),
      });
      return true;
    } else {
      return false;
    }
  }

  Future<bool> checkPairingInFirebase(String user1Uid) async {
    // Implement logic to check if user1Uid exists in your Firebase database
    // Return true if pairing is verified, false otherwise
    return true; // Placeholder logic, replace it with actual verification logic
  }

  Future<void> sendMessage(
      String senderUid, String receiverUid, String message) async {
    await FirebaseFirestore.instance.collection('chats').add({
      'senderUid': senderUid,
      'receiverUid': receiverUid,
      'message': message,
      'timestamp': FieldValue.serverTimestamp(),
    });
  }

  Future<String> generateUniquePartnerCode() async {
    final uuid = Uuid();
    String partnerCode;
    bool codeExists;

    do {
      partnerCode = uuid.v4();
      final snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('partnerCode', isEqualTo: partnerCode)
          .get();
      codeExists = snapshot.docs.isNotEmpty;
    } while (codeExists);

    return partnerCode;
  }

// Register a new user and store the partner code in Firestore
  Future<void> registerUserAndStorePartnerCode(
      String email, String password, String firstname, String lastname) async {
    try {
      final authResult =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Generate a partner code

      await FirebaseFirestore.instance
          .collection('users')
          .doc(authResult.user!.uid)
          .set({
        'email': email,
        //'partnerCode': partnerCode,
        'firstname': firstname,
        'lastname': lastname,
        // Other user data you may want to store
      });
      Get.back();
      Get.to(() => const OnboardingFiveScreen(),
          transition: Transition.rightToLeftWithFade,
          duration: const Duration(milliseconds: 200));
    } catch (e) {
      print('Error during user registration: $e');
      // Handle registration error
    }
  }

  Future<void> connectWithPartner(String enteredCode) async {
    try {
      final userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('partnerCode', isEqualTo: enteredCode)
          // .where('used', isEqualTo: false)
          .get();

      print('Query results: ${userSnapshot.docs}');

      if (userSnapshot.docs.isEmpty) {
        // No user with the entered partner code found or the code is already used
        print('Partner not found or code is used.');
      } else {
        // Get the user document associated with the partner code
        final partnerDocument = userSnapshot.docs.first;

        // Update the current user's document to indicate the connection
        final currentUserUid = FirebaseAuth.instance.currentUser!.uid;
        await FirebaseFirestore.instance
            .collection('users')
            .doc(currentUserUid)
            .update({
          'partnerCode': partnerDocument.id, // or another appropriate field
          'used': true
        });

        // Mark the partner code as used
        await partnerDocument.reference.update({
          'partnerCode': currentUserUid, // or another appropriate field
          'used': true,
        });

        // Display a success message or navigate to the connected partner's profile, etc.
        print('Connected with partner!');
        Future.delayed(const Duration(seconds: 1), () {
          Get.offAll(() => Home(myUID: currentUserUid, partnerUID: partnerDocument.id),
              transition: Transition.rightToLeftWithFade,
              duration: const Duration(milliseconds: 250));
        });
      }
    } catch (e) {
      print('Error during connection: $e');
      // Handle connection error
    }
  }
}
