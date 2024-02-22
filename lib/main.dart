import 'dart:async';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:raon/features/screens/main_screen/main_screen.dart';
import 'package:raon/features/screens/splash_screen/splash_screen.dart';
import 'package:raon/features/widgets/fcm_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  FirebaseMessaging.onBackgroundMessage((message) async {
    var msgController = Get.put(MsgController());

    var backGround = await msgController.onBackgroundHandler(message);

    return backGround;
  });

  await SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp],
  );

  await runZonedGuarded(() async {}, (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack);
  });

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.transparent,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(const RaonApp());
}

class RaonApp extends StatelessWidget {
  const RaonApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '라온라이팅',
      theme: ThemeData(
        primaryColor: Colors.amberAccent,
        useMaterial3: false,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        MainScreen.routeName: (context) => const MainScreen(),
      },
    );
  }
}
