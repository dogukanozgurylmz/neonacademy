import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:libraries_tasks/admob/admob_view.dart';

class InterstitialAdPage extends StatefulWidget {
  const InterstitialAdPage({super.key});

  @override
  State<InterstitialAdPage> createState() => _InterstitialAdPageState();
}

class _InterstitialAdPageState extends State<InterstitialAdPage> {
  InterstitialAd? _interstitialAd;
  bool _isAdLoaded = false;
  bool _isAdShown =
      false; // Reklamın gösterilip gösterilmediğini takip eden değişken

  final adUnitId = Platform.isAndroid
      ? 'ca-app-pub-3940256099942544/1033173712' // Test reklam birimi kimliği (Değiştirin!)
      : 'ca-app-pub-3940256099942544/4411468910'; // Test reklam birimi kimliği (Değiştirin!)

  @override
  void initState() {
    super.initState();
    loadAd();
  }

  /// Loads an interstitial ad.
  void loadAd() {
    InterstitialAd.load(
      adUnitId: adUnitId,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        // Called when an ad is successfully received.
        onAdLoaded: (ad) {
          _interstitialAd = ad;
          setState(() {
            _isAdLoaded = true;
          });
          debugPrint('InterstitialAd loaded.');
        },
        // Called when an ad request failed.
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint('InterstitialAd failed to load: $error');
        },
      ),
    );
  }

  /// Shows the interstitial ad.
  void showInterstitialAd() {
    if (_isAdLoaded && _interstitialAd != null && !_isAdShown) {
      _interstitialAd!.fullScreenContentCallback = FullScreenContentCallback(
        // Called when the ad showed the full screen content.
        onAdShowedFullScreenContent: (ad) {
          _isAdShown = true; // Reklamın gösterildiğini işaretle
        },
        // Called when an impression occurs on the ad.
        onAdImpression: (ad) {},
        // Called when the ad failed to show full screen content.
        onAdDismissedFullScreenContent: (ad) {
          reloadAd(); // Reload the ad after it's dismissed.
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => AdMobView(),
          ));
        },
        onAdFailedToShowFullScreenContent: (ad, err) {
          reloadAd(); // Reload the ad after it fails to show.
        },
        // Called when a click is recorded for an ad.
        onAdClicked: (ad) {},
      );
      _interstitialAd!.show();
    } else {
      debugPrint('InterstitialAd not ready yet.');
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

  /// Reload the interstitial ad.
  void reloadAd() {
    _interstitialAd?.dispose(); // Dispose the previous ad.
    _interstitialAd = null;
    _isAdLoaded = false;
    _isAdShown =
        false; // Reklamı tekrar gösterebilmek için gösterildiği işaretini sıfırla
    loadAd(); // Load a new ad.
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          if (_isAdLoaded) {
            showInterstitialAd();
          } else {
            // Reklam yüklenene kadar "Reklam yükleniyor..." mesajını göstermek için SnackBar
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Reklam yükleniyor...'),
                duration: Duration(seconds: 2),
              ),
            );
            loadAd(); // Kullanıcı butona tıkladıktan sonra yükleme işlemini başlat
          }
        },
        child: const Text('Show Interstitial Ad'),
      ),
    );
  }
}
