import 'dart:io';
import 'package:android_id/android_id.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:package_info/package_info.dart';
import 'package:raon/features/widgets/fcm_controller.dart';

class UserInfo {
  /// Get App Version
  Future<String> getAppVersion() async {
    var version = "undefined";

    var packageInfo = await PackageInfo.fromPlatform();

    version = packageInfo.version;

    return version;
  }

  /// Get Unique Device ID
  Future<String> getDeviceId() async {
    var deviceId = "undefined";

    var deviceInfo = DeviceInfoPlugin();

    if (Platform.isAndroid) {
      var androidInfo = const AndroidId();

      String? androidId = await androidInfo.getId();

      deviceId = androidId!;
    } else if (Platform.isIOS) {
      var iosInfo = await deviceInfo.iosInfo;

      deviceId = iosInfo.identifierForVendor!;
    } else if (kIsWeb) {
      var webInfo = await deviceInfo.webBrowserInfo;

      deviceId = webInfo.vendor! +
          webInfo.userAgent! +
          webInfo.hardwareConcurrency.toString();
    }

    return deviceId;
  }

  /// Get User Agent
  Future<String> getUserAgent() async {
    await FkUserAgent.init();

    var userAgent = FkUserAgent.webViewUserAgent ?? "undefined";

    return userAgent;
  }

  Future<String?> getFcmToken() async {
    var msgController = Get.put(MsgController());

    var fcmToken = await msgController.getToken();

    return fcmToken;
  }

  /// Customized User Agent
  Future<String> sendUserAgent() async {
    var scheme = "undefined";

    var agent = await getUserAgent();

    var isApp = "hyapp;";

    var appId = await getDeviceId();

    var version = await getAppVersion();

    var token = await getFcmToken();

    scheme = "$agent ($isApp lightlink24.co.kr $appId $version $token)";

    return scheme;
  }
}