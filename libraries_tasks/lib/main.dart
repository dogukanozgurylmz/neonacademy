import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:libraries_tasks/admob/admob_view.dart';
import 'package:libraries_tasks/admob/rewarded_ad_page.dart';
import 'package:libraries_tasks/hero/hero_view.dart';
import 'package:libraries_tasks/lottie/lottie_view.dart';
import 'package:libraries_tasks/onesignal/onesignal_api.dart';

import 'admob/interstitial_ad_page.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  MobileAds.instance.initialize();
  // OneSignalApi.setupOneSignal();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: HomeView(),
    );
  }
}

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LottieView(),
                  ),
                );
              },
              child: const Text("Lottie"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameScreen(),
                  ),
                );
              },
              child: const Text("Hero"),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AdMobView(),
                  ),
                );
              },
              child: const Text("AdMob"),
            ),
            InterstitialAdPage(),
            RewardedAdPage(),
          ],
        ),
      ),
    );
  }
}

