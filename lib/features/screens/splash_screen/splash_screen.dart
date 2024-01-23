import 'package:flutter/material.dart';
import 'package:raon/constants/sizes.dart';
import 'package:raon/features/screens/main_screen/main_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  static String routeName = "/";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, MainScreen.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(
          Sizes.size20,
        ),
        child: Center(
          child: Align(
            alignment: Alignment.center,
            child: Image.asset(
              "assets/images/splash.png",
              width: Sizes.size250,
              height: Sizes.size250,
            ),
          ),
        ),
      ),
    );
  }
}
