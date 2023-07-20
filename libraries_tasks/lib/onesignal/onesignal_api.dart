import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class OneSignalApi {
  static Future setupOneSignal() async {
    try {
      final deviceInfoPlugin = DeviceInfoPlugin();
      final BaseDeviceInfo deviceInfo = await deviceInfoPlugin.deviceInfo;
      final String allInfo = deviceInfo.data.values.toList().first;
      final String deviceLang =
          WidgetsBinding.instance.platformDispatcher.locale.languageCode;

      OneSignal oneSignal = OneSignal.shared;

      var promptUserForPushNotificationPermission =
          oneSignal.promptUserForPushNotificationPermission();
      print(promptUserForPushNotificationPermission);
      oneSignal.setAppId("c63e2ea9-e94a-4783-aad2-aef047258ab2");
      oneSignal.setExternalUserId(allInfo);
      oneSignal.setLanguage(deviceLang);
      oneSignal.sendTags({
        "deviceId": allInfo,
        "deviceLang": deviceLang,
      });
    } catch (error) {
      print("Hata oluştu: $error");
    }
  }
}
