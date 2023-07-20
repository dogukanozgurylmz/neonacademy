import 'dart:io' show Platform;
import 'dart:js_interop';
import 'package:flutter/services.dart';
import 'package:purchases_flutter/purchases_flutter.dart';

//...

Future<void> initPlatformState() async {
  await Purchases.setDebugLogsEnabled(true);

  PurchasesConfiguration? configuration;
  if (Platform.isAndroid) {
    configuration =
        PurchasesConfiguration("AIzaSyDY1zah0WdlwQcNm3Nh4X7CJT0Aoph-WHQ");
  }
  await Purchases.configure(configuration!);
  try {
    Offerings offerings = await Purchases.getOfferings();
    if (offerings.current != null) {}
  } on PlatformException catch (e) {
    print(e);
  }
}
