import 'package:flutter/material.dart';
import 'package:libraries_tasks/admob/banner_ad_page.dart';
import 'package:libraries_tasks/admob/interstitial_ad_page.dart';

class AdMobView extends StatefulWidget {
  const AdMobView({Key? key}) : super(key: key);

  @override
  _AdMobViewState createState() => _AdMobViewState();
}

class _AdMobViewState extends State<AdMobView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AdMob Challenge'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InterstitialAdPage(),
            Text("sdfsdf"),
          ],
        ),
      ),
      bottomNavigationBar: const BannerAdPage(),
    );
  }
}
