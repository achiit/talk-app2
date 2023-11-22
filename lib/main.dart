import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:pillowtalk/constants/colors.dart';
import 'package:pillowtalk/experiment/customIcons.dart';
import 'package:pillowtalk/views/home/home.dart';
import 'package:pillowtalk/views/home/home_screen.dart';
import 'package:pillowtalk/views/home/message_screen.dart';
import 'package:pillowtalk/views/splash_screen.dart';
import 'firebase_options.dart';

late Size mq;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(statusBarColor: Colors.transparent));
  SystemChrome.setPreferredOrientations(
          [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown])
      .then((value) async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    runApp(const MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Size mq;

  @override
  void didChangeDependencies() {
    // Adjust the provider based on the image type
    super.didChangeDependencies();
    precacheImage(const AssetImage("assets/banner1.webp"), context);
    precacheImage(const AssetImage("assets/banner2.webp"), context);
    precacheImage(const AssetImage("assets/banner3.webp"), context);
  }

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        scaffoldBackgroundColor: backgroundColor,
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: secondaryColor),
      ),
      home: const SplashScreen(),
    );
  }
}


