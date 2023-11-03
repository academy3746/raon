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
              Gaps.v32,
              const Text(
                "라온라이팅",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: Sizes.size40,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
