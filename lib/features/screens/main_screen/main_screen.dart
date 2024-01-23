// ignore_for_file: avoid_print, prefer_collection_literals, deprecated_member_use
import 'dart:async';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_webview_pro/webview_flutter.dart';
import 'package:raon/features/widgets/app_cookie_handler.dart';
import 'package:raon/features/widgets/app_version_check_handler.dart';
import 'package:raon/features/widgets/back_handler_button.dart';
import 'package:raon/features/widgets/user_info.dart';
import 'package:tosspayments_widget_sdk_flutter/model/tosspayments_url.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  static String routeName = "/main";

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with WidgetsBindingObserver {
  /// Initialize WebView Controller
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  WebViewController? viewController;

  /// Initialize Main Page URL
  final String url = "http://uljilight.co.kr/?pn=main";

  /// Initialize Home URL
  final String homeUrl = "http://uljilight.co.kr/";

  /// Import BackHandlerButton
  BackHandlerButton? backHandlerButton;

  /// Import App Cookie Handler
  AppCookieHandler? appCookieHandler;

  /// Page Loading Indicator
  bool isLoading = false;

  /// Get Unique User Info
  UserInfo userInfo = UserInfo();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addObserver(this);

    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      userInfo.getUserAgent();
    });

    /// Improve Android Performance
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();

    /// Exit Application with double touch
    _controller.future.then(
      (WebViewController webViewController) {
        viewController = webViewController;
        backHandlerButton = BackHandlerButton(
          context: context,
          controller: webViewController,
          mainUrl: url,
          homeUrl: homeUrl,
        );
      },
    );

    /// Initialize Cookie Settings
    appCookieHandler = AppCookieHandler(homeUrl, url);

    /// App Version Check Manually
    AppVersionChecker appVersionChecker = AppVersionChecker(context);

    appVersionChecker.getAppVersion();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.resumed) {
      print("앱이 포그라운드 상태입니다.");
    } else {
      print("앱이 백그라운드 상태입니다.");
    }
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    var width = MediaQuery.of(context).size.width;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          FutureBuilder<String>(
            future: userInfo.getAppScheme(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                print("App UserAgent: ${snapshot.data}");
                return WillPopScope(
                  onWillPop: () async {
                    if (backHandlerButton != null) {
                      return backHandlerButton!.onWillPop();
                    }
                    return false;
                  },
                  child: SizedBox(
                    height: height,
                    width: width,
                    child: SafeArea(
                      child: WebView(
                        initialUrl: url,
                        javascriptMode: JavascriptMode.unrestricted,
                        onPageStarted: (String url) async {
                          setState(() {
                            isLoading = true;
                          });

                          print("Current Url: $url");
                        },
                        onPageFinished: (String url) async {
                          setState(() {
                            isLoading = false;
                          });

                          /// Soft Keyboard hide input field on Android issue
                          if (Platform.isAndroid) {
                            if (url.contains(url) && viewController != null) {
                              await viewController!.runJavascript("""
                              (function() {
                                function scrollToFocusedInput(event) {
                                  const focusedElement = document.activeElement;
                                  if (focusedElement.tagName.toLowerCase() === 'input' || focusedElement.tagName.toLowerCase() === 'textarea') {
                                    setTimeout(() => {
                                      focusedElement.scrollIntoView({ behavior: 'smooth', block: 'center' });
                                    }, 500);
                                  }
                                }
                                document.addEventListener('focus', scrollToFocusedInput, true);
                              })();
                            """);
                            }
                          }
                        },
                        onWebViewCreated:
                            (WebViewController webViewController) async {
                          _controller.complete(webViewController);
                          viewController = webViewController;

                          /// Get Cookie Statement
                          await appCookieHandler?.setCookies(
                            appCookieHandler!.cookieValue,
                            appCookieHandler!.domain,
                            appCookieHandler!.cookieName,
                            appCookieHandler!.url,
                          );
                        },
                        navigationDelegate: (request) async {
                          /// Toss Payments
                          final appScheme = ConvertUrl(request.url);

                          if (appScheme.isAppLink()) {
                            try {
                              await appScheme.launchApp();
                            } on Error catch (e) {
                              print("Request to Toss Payments is invalid: $e");
                            }

                            return NavigationDecision.prevent;
                          }

                          return NavigationDecision.navigate;
                        },
                        onWebResourceError: (error) {
                          print("Error Code: ${error.errorCode}");
                          print("Error Description: ${error.description}");
                        },
                        zoomEnabled: false,
                        gestureRecognizers: Set()
                          ..add(
                            Factory<EagerGestureRecognizer>(
                                  () => EagerGestureRecognizer(),
                            ),
                          ),
                        gestureNavigationEnabled: true,
                        userAgent: snapshot.data,
                      ),
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              }
            },
          ),
          isLoading
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : Container(),
        ],
      ),
    );
  }
}
