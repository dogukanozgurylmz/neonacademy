import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class RewardedAdPage extends StatefulWidget {
  const RewardedAdPage({super.key});

  @override
  State<RewardedAdPage> createState() => _RewardedAdPageState();
}

class _RewardedAdPageState extends State<RewardedAdPage> {
  RewardedAd? _rewardedAd;
  bool _isAdLoaded = false;
  bool _isAdShown = false; // Reklamın gösterildiğini takip eden değişken

  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/5224354917'
      : 'ca-app-pub-3940256099942544/1712485313';

  @override
  void initState() {
    super.initState();
    loadAd();
  }

  /// Loads a rewarded ad.
  void loadAd() {
    RewardedAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          ad.fullScreenContentCallback = FullScreenContentCallback(
            // Called when the ad showed the full screen content.
            onAdShowedFullScreenContent: (ad) {
              _isAdShown = true; // Reklamın gösterildiğini işaretle
            },
            // Called when an impression occurs on the ad.
            onAdImpression: (ad) {},
            // Called when the ad failed to show full screen content.
            onAdFailedToShowFullScreenContent: (ad, err) {
              // Dispose the ad here to free resources.
              ad.dispose();
            },
            // Called when the ad dismissed full screen content.
            onAdDismissedFullScreenContent: (ad) {
              // Dispose the ad here to free resources.
              ad.dispose();
              // Reklamı kapattıktan sonra tekrar yüklemeye hazır hale getir.
              _isAdLoaded = false;
              _isAdShown = false;
            },
            // Called when a click is recorded for an ad.
            onAdClicked: (ad) {},
          );

          debugPrint('$ad loaded.');
          // Keep a reference to the ad so you can show it later.
          _rewardedAd = ad;
          setState(() {
            _isAdLoaded = true;
          });
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('RewardedAd failed to load: $error');
        },
      ),
    );
  }

  void showAd() {
    if (_isAdLoaded && !_isAdShown) {
      _rewardedAd!.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
          // Reward the user for watching an ad.
        },
      );
    } else {
      debugPrint('RewardedAd not ready yet or already shown.');
      // Reklam yüklenene kadar "Reklam yükleniyor..." mesajını göstermek için SnackBar
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Reklam yükleniyor...'),
          duration: Duration(seconds: 2),
        ),
      );
      loadAd(); // Kullanıcı butona tıkladıktan sonra yükleme işlemini başlat
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          showAd();
        },
        child: const Text('Show Rewarded Ad'),
      ),
    );
  }
}
