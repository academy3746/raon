import 'package:flutter/material.dart';
import 'package:raon/constants/gaps.dart';
import 'package:raon/constants/sizes.dart';
import 'package:raon/features/screens/main_screen/main_screen.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  static String routeName = "/";

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacementNamed(context, MainScreen.routeName);
    });

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(
          Sizes.size20,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/splash.png",
                width: Sizes.size150 + Sizes.size30,
                height: Sizes.size150 + Sizes.size30,
              ),
              Gaps.v10,
              Image.asset(
                "assets/images/splash_font.png",
                width: Sizes.size250,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
