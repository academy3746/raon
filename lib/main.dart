import 'package:flutter/material.dart';
import 'package:raon/features/screens/main_screen/main_screen.dart';
import 'package:raon/features/screens/onboarding_screen/onboarding_screen.dart';
import 'package:raon/features/screens/splash_screen/splash_screen.dart';

void main() {
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
        OnBoardingScreen.routeName: (context) => const OnBoardingScreen(),
        MainScreen.routeName: (context) => const MainScreen(),
      },
    );
  }
}
