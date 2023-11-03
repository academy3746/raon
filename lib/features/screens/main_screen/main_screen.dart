// ignore_for_file: avoid_print
import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:raon/features/widgets/back_handler_button.dart';
import 'package:raon/features/widgets/permission_handler.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static String routeName = "/main";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  /// Initialize WebView Controller
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  WebViewController? _viewController;

  /// Initialize Main Page URL
  final String url = "http://raon.sogeum.kr/";

  /// Import BackHandlerButton
  BackHandlerButton? _backHandlerButton;

  @override
  void initState() {
    super.initState();

    /// Improve Android Performance
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    /// Exit Application with double touch on foreground
    _controller.future.then(
      (WebViewController webViewController) {
        _viewController = webViewController;
        _backHandlerButton = BackHandlerButton(
          context: context,
          controller: webViewController,
          mainUrl: url,
        );
      },
    );

    /// Request user permission to access external storage
    StoragePermissionHandler permissionHandler = StoragePermissionHandler(context);
    permissionHandler.requestStoragePermission();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_backHandlerButton != null) {
          return _backHandlerButton!.onWillPop();
        }
        return false;
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.white,
        body: SafeArea(
          child: WebView(
            initialUrl: url,
            javascriptMode: JavascriptMode.unrestricted,
            onPageStarted: (String url) async {
              print("Current Url: $url");
            },
            onWebViewCreated: (WebViewController webViewController) async {
              _controller.complete(webViewController);
              _viewController = webViewController;
            },
            onWebResourceError: (error) {
              print("Error Code: ${error.errorCode}");
              print("Error Description: ${error.description}");
            },
          ),
        ),
      ),
    );
  }
}
