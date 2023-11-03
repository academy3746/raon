import 'package:flutter/material.dart';
import 'package:raon/features/widgets/back_handler_button.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});
  static String routeName = "/main";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  late BackHandlerButton _backHandlerButton;

  @override
  void initState() {
    super.initState();

    _backHandlerButton = BackHandlerButton(context: context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _backHandlerButton.onWillPop,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Container(),
      ),
    );
  }
}
